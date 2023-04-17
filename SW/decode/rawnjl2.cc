#include "bnstream.h"
#include "bnopt.h"
#include "mesgtext.h"
#include <fstream>
#include <string>
#include <cmath>
#include <memory>

// Test of new lossless JPEG proposal ISO/IEC WD 14495

static inline Uint32 Maximum(Uint32 a,Uint32 b) { return (a > b) ? a : b; }
static inline Uint16 Maximum(Uint16 a,Uint16 b) { return (a > b) ? a : b; }
static inline Uint32 Minimum(Uint32 a,Uint32 b) { return (a > b) ? b : a; }
static inline Uint16 Minimum(Uint16 a,Uint16 b) { return (a > b) ? b : a; }

static inline Uint32 Abs(Int32 x) { return (Uint32)((x < 0) ? -x : x); }
static inline Uint16 Abs(Int16 x) { return (Uint16)((x < 0) ? -x : x); }

static inline double Log(double x)	{ return (ourlog2(x)); }

static inline Uint32 Floor(double x)	{ return Uint32(floor(x)); }
static inline Uint32 Ceiling(double x)	{ return Uint32(ceil(x)); }
static inline Uint32 FloorDivision(Uint32 n,Uint32 d)	{ return Uint32(floor(double(n)/double(d))); }
static inline Uint32 CeilingDivision(Uint32 n,Uint32 d)	{ return Uint32(ceil(double(n)/double(d))); }

// Constant tables for run length codes ...

static const Uint16 J[32] = {		// Order of run length codes
	0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,5,5,6,6,7,7,8,9,10,11,12,13,14,15
};

static const Uint16 J_rm[32] = {	// Length of run length codes (ie. 1<<J[n])
	1u<<0,1u<<0,1u<<0,1u<<0,
	1u<<1,1u<<1,1u<<1,1u<<1,
	1u<<2,1u<<2,1u<<2,1u<<2,
	1u<<3,1u<<3,1u<<3,1u<<3,
	1u<<4,1u<<4,
	1u<<5,1u<<5,
	1u<<6,1u<<6,
	1u<<7,1u<<7,
	1u<<8,
	1u<<9,
	1u<<10,
	1u<<11,
	1u<<12,
	1u<<13,
	1u<<14,
	1u<<15
};

static Uint32
readRow(BinaryInputStream &in, Uint16 *buffer, Uint32 n,Uint16 bpp)
{
	Uint32 count=0;
	if (bpp <= 8) {
		while (n-- && in) {
			unsigned char value;
			in >> value;
			*buffer++=Uint16(value);
			if (in || in.eof()) ++count;
		}
	}
	else {
		while (n-- && in) {
			in >> *buffer++;
			if (in || in.eof()) ++count;
		}
	}
	return (in || in.eof()) ? count : 0;
}

static BinaryOutputStream &
writeRow(BinaryOutputStream &out, Uint16 *buffer, Uint32 n,Uint16 bpp)
{
	if (bpp <= 8) {
		while (n-- && out) out << (unsigned char)(*buffer++);
	}
	else {
		while (n-- && out) out << *buffer++;
	}
	return out;
}

static BinaryOutputStream &
writeRow(BinaryOutputStream &out, Uint16 *buffer_red, Uint16 *buffer_green, Uint16 *buffer_blue, Uint32 n, Uint16 bpp)
{
	if (bpp <= 8) {
		while (n-- && out){ 
			out << (unsigned char)(*buffer_red++);
			out << (unsigned char)(*buffer_green++);
			out << (unsigned char)(*buffer_blue++);
		}
	}
	else {
		while (n-- && out) {
			out << *buffer_red++;
			out << *buffer_green++;
			out << *buffer_blue++;
		}
	}
	return out;
}

static Uint32 		readBitByteOffset=0;
static Int16 		readBitCount=0;
static unsigned char 	readBitByte=0;
static unsigned char 	readForwardByte;

static BinaryInputStream &
readBit(BinaryInputStream &in,Uint32 &bit)
{
	// first bits are read from msb of byte
	Assert(readBitCount >= 0);
	if (readBitCount < 1) {
		++readBitByteOffset;
		in.read((char *)&readBitByte,1);
		readBitCount=8;
	}
	bit=(readBitByte>>(--readBitCount)) & 1;

	return in;
}

static void
dumpReadBitPosition(void)
{
	cerr << "dumpReadBitPosition: " << (readBitByteOffset-1+(readBitCount ? 0 : 1)) << "." << (readBitCount ? (8-readBitCount) : 0) << endl;
}

static Uint32 		writeBitByteOffset=0;
static Uint16 		writeBitCount=0;
static unsigned char 	writeBitByte=0;

static BinaryOutputStream &
writeBit(BinaryOutputStream &out,Uint32 bit)
{
	// first bits are written into msb of byte
	Assert(writeBitCount<8);
	writeBitByte=writeBitByte<<1;
	if (bit) writeBitByte|=1;

	if (++writeBitCount >= 8) {
		++writeBitByteOffset;
		out.write((char *)&writeBitByte,1);
		writeBitCount=0;
		writeBitByte=0;
	}
	return out;
}

static BinaryOutputStream &
writeBitFlush(BinaryOutputStream &out)
{
	Assert(writeBitCount<8);
	writeBitByte=writeBitByte<<(8-writeBitCount);
	out.write((char *)&writeBitByte,1);
	writeBitByte=0;
	writeBitCount=0;
	return out;
}

static void
dumpWriteBitPosition(void)
{
	cerr << "dumpWriteBitPosition: " << writeBitByteOffset << "." << writeBitCount << endl;
}


static BinaryOutputStream &
write16BE(BinaryOutputStream &out,Uint16 word)
{
	unsigned char byte;
	byte=word>>8;
	out.write((char *)&byte,1);
	byte=word&0xff;
	out.write((char *)&byte,1);
	return out;
}

static BinaryOutputStream &
write8(BinaryOutputStream &out,unsigned char byte)
{
	out.write((char *)&byte,1);
	return out;
}

static BinaryInputStream &
read16BE(BinaryInputStream &in,Uint16 &value)
{
	unsigned char byte;
	in.read((char *)&byte,1);
	value=Uint16(byte)<<8;
	in.read((char *)&byte,1);
	value|=byte;
	return in;
}

static BinaryInputStream &
read8(BinaryInputStream &in,unsigned char &byte)
{
	in.read((char *)&byte,1);
	return in;
}

// JPEG Syntax - Marker Segment stuff ....

const Uint16 JPEG_MARKER_DNL = 0xffdc;
const Uint16 JPEG_MARKER_EOI = 0xffd9;
const Uint16 JPEG_MARKER_SOI = 0xffd8;
const Uint16 JPEG_MARKER_SOS = 0xffda;

// New for JPEG-LS (14495-1:1997)

const Uint16 JPEG_MARKER_SOF55 = 0xfff7;
const Uint16 JPEG_MARKER_LSE   = 0xfff8;

const unsigned char JPEG_LSE_ID_L1   = 0x01;
const unsigned char JPEG_LSE_ID_L2   = 0x02;
const unsigned char JPEG_LSE_ID_L3   = 0x03;
const unsigned char JPEG_LSE_ID_L4   = 0x04;

static BinaryOutputStream &
writeSOI(BinaryOutputStream &out)
{
	write16BE(out,JPEG_MARKER_SOI);
	return out;
}

static BinaryOutputStream &
writeSOF55(BinaryOutputStream &out,Uint16 P,Uint16 ROWS,Uint16 COLUMNS)
{
	write16BE(out,JPEG_MARKER_SOF55);
	write16BE(out,11);			// length (inclusive of self)

	Assert(P < 256);
	write8(out,(unsigned char)P);		// sample precision
	write16BE(out,ROWS);			// Y - number of lines
	write16BE(out,COLUMNS);			// X - number of samples per line

	write8(out,1);				// one component per frame only

	write8(out,1);				// component identifier is 1
	write8(out,0x11);			// no horizontal or vertical sampling factor
	write8(out,0);				// no quantization table used in JPEG-LS

	return out;
}

static BinaryOutputStream &
writeSOS(BinaryOutputStream &out,Uint16 NEAR)
{
	write16BE(out,JPEG_MARKER_SOS);
	write16BE(out,8);			// length (inclusive of self)

	write8(out,1);				// one component per scan only

	write8(out,1);				// select component 1
	write8(out,0);				// no mapping table

	Assert(NEAR < 256);
	write8(out,(unsigned char)NEAR);	// in place of start of spectral selection
	write8(out,0);				// ILV - interleave mode is 0 (none)

	write8(out,0);				// not used in JPEG-LS

	return out;
}

static BinaryOutputStream &
writeLSE1(BinaryOutputStream &out,Uint16 MAXVAL,Uint16 T1,Uint16 T2,Uint16 T3,Uint16 RESET)
{
	write16BE(out,JPEG_MARKER_LSE);
	write16BE(out,13);
	write8(out,JPEG_LSE_ID_L1);
	write16BE(out,MAXVAL);
	write16BE(out,T1);
	write16BE(out,T2);
	write16BE(out,T3);
	write16BE(out,RESET);

	return out;
}

static BinaryOutputStream &
writeEOI(BinaryOutputStream &out)
{
	write16BE(out,JPEG_MARKER_EOI);
	return out;
}

static bool
readJPEGMarker(BinaryInputStream &in,Uint16 &marker)
{
	return read16BE(in,marker) && (marker&0xff80) != 0;
}

static bool
readSOI(BinaryInputStream &in,Uint16 marker)
{
	return marker == JPEG_MARKER_SOI;
}

static bool
readSOF55(BinaryInputStream &in,Uint16 marker,Uint16 &P,Uint32 &ROWS,Uint32 &COLUMNS)
{
	Uint16 length;
	unsigned char precision;
	Uint16 rows;
	Uint16 columns;
	unsigned char ncomponents;
	unsigned char componentid;
	unsigned char hvsampling;
	unsigned char quanttable;
	return marker == JPEG_MARKER_SOF55
	    && read16BE(in,length) && length == 11
	    && read8(in,precision) && (P=precision,true)
	    && read16BE(in,rows) && (ROWS=rows,true)
	    && read16BE(in,columns) && (COLUMNS=columns,true)
	    && read8(in,ncomponents) && ncomponents == 1
	    && read8(in,componentid)
	    && read8(in,hvsampling)
	    && read8(in,quanttable)
	;
}

static bool
readSOS(BinaryInputStream &in,Uint16 marker,Uint16 &NEAR)
{
	Uint16 length;
	unsigned char ncomponents;
	unsigned char componentid;
	unsigned char mappingtable;
	unsigned char near;
	unsigned char ilv;
	unsigned char dummy;
	return marker == JPEG_MARKER_SOS
	    && read16BE(in,length) && length == 8
	    && read8(in,ncomponents) && ncomponents == 1
	    && read8(in,componentid)
	    && read8(in,mappingtable)
	    && read8(in,near) && (NEAR=near,true)
	    && read8(in,ilv)
	    && read8(in,dummy);
}

static bool
readLSE1(BinaryInputStream &in,Uint16 marker,Uint32 &MAXVAL,Uint16 &T1,Uint16 &T2,Uint16 &T3,Uint16 &RESET)
{
	Uint16 length;
	unsigned char id;
	Uint16 maxval;
	return marker == JPEG_MARKER_LSE
	    && read16BE(in,length) && length > 2
	    && read8(in,id) && id == JPEG_LSE_ID_L1
	    && length == 13
	    && read16BE(in,maxval) && (MAXVAL=maxval,true)
	    && read16BE(in,T1)
	    && read16BE(in,T2)
	    && read16BE(in,T3)
	    && read16BE(in,RESET);
}

// JPEG-LS support routines ...

static Uint16
determineGolombParameter(Uint32 n,Uint32 a)
{
	Uint16 k;

	Assert(n);			// Make sure we don't get out of control
	for (k=0;(n<<k) < a; ++k)	// Number of occurrences vs accumulated error magnitude
		Assert(k<31);		// ... internal limit ... don't exceed width of Uint32

	return k;
}

static BinaryInputStream &
decodeMappedErrvalWithGolomb(Uint16 k,Uint16 glimit,Uint16 qbpp,Uint32 &value,BinaryInputStream &in)
{
	// Read unary representation of remaining most significant bits

	Uint32 bit;
	Uint32 unarycode=0;
	while (readBit(in,bit) && !bit) ++unarycode;	// stops after bit is 1 (having read and discared trailing 1 bit)

	Uint32 offset;
	Uint16 bitstoread;
	Assert(glimit > qbpp+1);
	Uint16 limit=glimit-qbpp-1;
	if (unarycode < limit) {		// use it to form most significant bits
		value=unarycode;		// will later get shifted into ms bits
		bitstoread=k;
		offset=0;
	}
	else {
		value=0;			// no contribution from unary code ... whole value is next
		bitstoread=qbpp;
		offset=1;
	}

	// Read least significant k bits

	while (bitstoread-- && readBit(in,bit)) value=(value<<1) | bit;	// msb bit is read first

	value+=offset;				// correct for limited case 

	return in;
}

static BinaryOutputStream &
encodeMappedErrvalWithGolomb(Uint16 k,Uint16 glimit,Uint16 qbpp,Uint32 value,BinaryOutputStream &out, ofstream &dbg_file)
{
	string dbg_str;	// For debugging

	// A.5.3 Mapped-error encoding

	Uint32 unarycode=value>>k;					// Most significant bits go into unary code

	Assert(glimit > qbpp+1);
	Uint16 limit=glimit-qbpp-1;

	if (unarycode < limit) {
		while (unarycode--)
		{
			dbg_str.push_back('0');
			writeBit(out,0);			// Append unary representation of remaining most significant bits
		}
		writeBit(out,1);					// Flag the end of the unary code
		dbg_str.push_back('1');
		Uint16 bits=k;						// Append least significant k bits
		while (bits--)
		{
			writeBit(out,(value>>bits)&1);
			dbg_str += to_string((value>>bits)&1);
		} 	// msb bit is written first & use the decremented bits as shift
	}
	else {
		while (limit--)
		{
			writeBit(out,0);			// Append limit 0 bits
			dbg_str.push_back('0');
		}
		writeBit(out,1);					// Flag the end of the unary code
		dbg_str.push_back('1');
		value-=1;
		while (qbpp--)
		{
			writeBit(out,(value>>qbpp)&1);
			dbg_str += to_string((value>>qbpp)&1);
		} 	// write whole value (always of length qbpp)
	}

	dbg_file << dbg_str << endl;
	return out;
}

static void
quantizeErrval(Uint16 NEAR,Int32 &Errval)
{
	if (NEAR) {
		if (Errval > 0)
			Errval=(Errval+NEAR)/(2*NEAR+1);
		else
			Errval=(Errval-NEAR)/(2*NEAR+1);		// in A.4.4 it is actually -(NEAR-Errval)/(2*NEAR+1)
	}
	// else leave Errval as it is for lossless mode
}

static void
deQuantizeErrval(Uint16 NEAR,Int32 &Errval)
{

	if (NEAR) Errval=Errval*(2*NEAR+1);

}

static inline void
clampPredictedValue(Int32 &X,Int32 MAXVAL)
{

	if      (X > MAXVAL)	X=MAXVAL;
	else if (X < 0)		X=0;

}

static void
codecRunEndSample(Uint16 &Ix,Int32 Ra,Int32 Rb,Int32 RANGE,Uint16 NEAR,Uint32 MAXVAL,Uint16 RESET,
		Uint16 LIMIT,Uint16 qbpp,Uint16 rk,
		Uint32 *A,Int32 *N,Int32 *Nn,
		BinaryInputStream &in,BinaryOutputStream &out,bool decompressing, ofstream &dbg_file)
{

	bool RItype = (Ra == Rb || Abs(Ra-Rb) <= NEAR);

	Int16 SIGN = (!RItype && Ra > Rb) ? -1 : 1;

	Int32 Px = RItype ? Ra : Rb;

	Uint32 TEMP = RItype ? A[366]+(N[366]>>1) : A[365];

	Uint16 Q = 365 + (RItype ? 1 : 0);

	Uint16 k = determineGolombParameter(N[Q],TEMP);

	Int32  Errval;
	Int32  updateErrval;
	Uint32 EMErrval;

	decodeMappedErrvalWithGolomb(k,LIMIT-rk-1,qbpp,EMErrval,in);	// needs work :(

	Uint32 tEMErrval = EMErrval + (RItype ? 1 : 0);		// use local copy to leave original for parameter update later

	if (tEMErrval == 0) {
		Errval = 0;
	}
	else if (k == 0) {
		if (2*Nn[Q-365] < N[Q]) {
			if (tEMErrval%2 == 0) {
				Errval = -Int32(tEMErrval>>1);		// "map = 0"	2 becomes -1, 4 becomes -2, 6 becomes -3
			}
			else {
				Errval = (tEMErrval+1)>>1;		// "map = 1"	1 becomes 1, 3 becomes 2, 5 becomes 3
			}
		}
		else {	// 2*Nn[Q-365] >= N[Q]
			if (tEMErrval%2 == 0) {
				Errval = tEMErrval>>1;			// "map = 0"	2 becomes 1, 4 becomes 2, 6 becomes 3
			}
			else {
				Errval = -Int32((tEMErrval+1)>>1);	// "map = 1"	1 becomes -1, 3 becomes -2, 5 becomes -3
			}
		}
	}
	else {
		if (tEMErrval%2 == 0) {
			Errval = tEMErrval>>1;				// "map = 0"	2 becomes  1, 4 becomes  2, 6 becomes 3
		}
		else {
			Errval = -Int32((tEMErrval+1)>>1);		// "map = 1"	1 becomes -1, 3 becomes -2, 5 becomes -3
		}
	}

	updateErrval=Errval;

	if (NEAR > 0) deQuantizeErrval(NEAR,Errval);

	if (SIGN < 0) Errval=-Errval;		// if "context type" was negative

	Int32 Rx = Px+Errval;

	// modulo(RANGE*(2*NEAR+1)) as per F.1 Item 14

	// (NB. Is this really the reverse of the encoding procedure ???)

	if (Rx < -NEAR)
		Rx+=RANGE*(2*NEAR+1);
	else if (Rx > MAXVAL+NEAR)
		Rx-=RANGE*(2*NEAR+1);

	clampPredictedValue(Rx,MAXVAL);

	// Apply inverse point transform and mapping table when implemented

	Ix=(Uint16)Rx;

	// Update parameters ...

	if (updateErrval < 0) ++Nn[Q-365];
	A[Q]+=(EMErrval+1-(RItype ? 1 : 0))>>1;
	if (N[Q] == RESET) {
		A[Q]=A[Q]>>1;
		N[Q]=N[Q]>>1;
		Nn[Q-365]=Nn[Q-365]>>1;
	}
	++N[Q];
}

static const char* concat_chars(char text1, string text2) {
	return (string(1, text1) + text2).c_str();
}

struct ColorContext {

	const Uint16 nContexts = 365;	// plus two more run mode interruption contexts

	const Int32 MIN_C = -128;	// Limits on values in bias correction array C
	const Int32 MAX_C =  127;

	static Uint16 COLUMNS;
	static Uint16 ROWS;

	static bool bad;

	static void set_col_row_dims(Uint16 _cols, Uint16 _rows) {
		COLUMNS = _cols;
		ROWS = _rows;
	}

	Uint16 NEAR{0};		// Lossless if zero
	Uint16 T1{0};
	Uint16 T2{0};
	Uint16 T3{0};
	Uint16 RESET{0};

	Uint16 P{0};		// Sample precision
	Uint32 MAXVAL{0};

	Int32 RANGE;
	Uint16 bpp;
	Uint16 qbpp;
	Uint16 LIMIT;

	Int32	*N;
				
	Uint32	*A;
	Int32	*B;
	Int32	*C; 

	Int32	*Nn; 
	
	Uint16 *thisRow;
	Uint16 *prevRow;

	Uint16 prevRa0;

	unsigned RUNIndex{0};

	ColorContext(GetNamedOptions& options, char opt_prefix) {

		Assert(COLUMNS > 0);
		Assert(ROWS > 0);

		// Thresholds for context gradients ...

		unsigned reset;	if (options.get("reset",reset))				RESET=reset;

		if (!RESET) RESET=64;		// May have been set on command line

		unsigned t1;
		if ( !options.get(concat_chars(opt_prefix, "T1"),t1) && !options.get(concat_chars(opt_prefix, "Ta"),t1)) {
			cerr << EMsgDC(NeedOption) << " - [rgb]T1" << endl;
			bad=true;
		}
		T1=t1;

		unsigned t2;
		if ( !options.get(concat_chars(opt_prefix, "T2"),t2) && !options.get(concat_chars(opt_prefix, "Tb"),t2)) {
			cerr << EMsgDC(NeedOption) << " - [rgb]T2" << endl;
			bad=true;
		}
		T2=t2;
		unsigned t3;
		if ( !options.get(concat_chars(opt_prefix, "T3"),t3) && !options.get(concat_chars(opt_prefix, "Tc"),t3)) {
			cerr << EMsgDC(NeedOption) << " - [rgb]T3" << endl;
			bad=true;
		}
		T3=t3;

		unsigned bits=0;
		if ( !options.get(concat_chars(opt_prefix, "bits"),bits) && !options.get(concat_chars(opt_prefix, "depth"),bits)) {
			cerr << EMsgDC(NeedOption) << " - bits" << endl;
			bad=true;
		}
		Assert(bits <= 16);
		P = bits;

		unsigned limit=0;
		if ( !options.get(concat_chars(opt_prefix, "limit"),limit) && !options.get(concat_chars(opt_prefix, "lim"),limit)) {
			cerr << EMsgDC(NeedOption) << " - limit" << endl;
			bad=true;
		}
		LIMIT = limit;

		Assert(P);

		MAXVAL=(1ul<<P)-1;

		Assert(T1 == 0 || (NEAR+1 <= T1 && T1 <= MAXVAL));
		Assert(T2 == 0 || (T1 <= T2 && T2 <= MAXVAL));
		Assert(T3 == 0 || (T2 <= T3 && T3 <= MAXVAL));

		// Initialization as per Annex A.2.1

		Int32 RANGE = FloorDivision(MAXVAL+2*NEAR,2*NEAR+1)+1;	// int not unsigned to avoid need for cast when used

		bpp = Maximum(2,Ceiling(Log(MAXVAL+1)));	// Number of bits needed to represent MAXVAL with a minumum of 2
		qbpp = Ceiling(Log(RANGE));		// Number of bits needed to represent a mapped error value


		Assert(MAXVAL == 0 || (1 <= MAXVAL && MAXVAL < 1ul<<P));
		if (NEAR == 0) Assert(RANGE == MAXVAL+1);

		Assert(bpp >= 2);
		Assert(LIMIT > qbpp);			// Else LIMIT-qbpp-1 will fail (see A.5.3)

		// Initialization of variables ...

		Int32	*N = new Int32[nContexts+2];	// counters for context type occurence [0..nContexts+2-1]
							// [nContexts],[nContexts+1] for run mode interruption
		Uint32	*A = new Uint32[nContexts+2];	// accumulated prediction error magnitude [0..nContexts-1]
							// [nContexts],[nContexts+1] for run mode interruption
		Int32	*B = new Int32[nContexts];	// auxilliary counters for bias cancellation [0..nContexts-1]
		Int32	*C = new Int32[nContexts];	// counters indicating bias correction value [0..nContexts-1]
							// (never -ve but often used as -N[Q] so int not unsigned saves cast)

		Int32	*Nn = new Int32[2];		// negative prediction error for run interruption [365..366]

		Assert(N);
		Assert(A);
		Assert(B);
		Assert(C);
		Assert(Nn);

		{
			Uint32 A_Init_Value=Maximum(2,FloorDivision(RANGE+(1lu<<5),(1lu<<6)));
			unsigned i;
			for (i=0; i<nContexts; ++i) {
				N[i]=1;
				A[i]=A_Init_Value;
				B[i]=C[i]=0;
			}
			N[nContexts]=1;
			N[nContexts+1]=1;
			A[nContexts]=A_Init_Value;
			A[nContexts+1]=A_Init_Value;
		}

		Nn[365-365]=Nn[366-365]=0;

		// The run variables seem to need to live beyond a single run or row !!!

		unsigned RUNIndex = 0;

		Uint16 *thisRow = new Uint16[COLUMNS];
		Uint16 *prevRow = new Uint16[COLUMNS];
		Assert(thisRow);
		Assert(prevRow);

	}

	~ColorContext() {

		if (thisRow) delete[] thisRow;
		if (prevRow) delete[] prevRow;

		if (A) delete[] A;
		if (B) delete[] B;
		if (C) delete[] C;
		if (N) delete[] N;

	}
};

Uint16 ColorContext::COLUMNS{0};
Uint16 ColorContext::ROWS{0};
bool ColorContext::bad{false};

void decomp_single_pixel(BinaryInputStream& in, Uint16 row, Uint16 col, ColorContext& ctx, bool useRunMode);

int
main(int argc,char **argv)
{
	// Create file for debugging
	ofstream dbg_file;

	bool bad=false;

	GetNamedOptions				options(argc,argv);
	BinaryInputOptionsWithByteOrder		input_options(options);
	BinaryOutputOptionsWithByteOrder	output_options(options);

	bool verbose=options.get("v") || options.get("verbose");

	bool useRunMode=!options.get("noruns");

	unsigned rows=0;
	if (!options.get("rows",rows) && !options.get("height",rows) && !options.get("h",rows)) {
		cerr << EMsgDC(NeedOption) << " - rows" << endl;
		bad=true;
	}
	unsigned cols=0;
	if (!options.get("columns",cols) && !options.get("width",cols) && !options.get("w",cols)) {
		cerr << EMsgDC(NeedOption) << " - columns" << endl;
		bad=true;
	}

	ColorContext::set_col_row_dims(cols, rows);

	struct ColorContext red(options, 'r');
	struct ColorContext green(options, 'g');
	struct ColorContext blue(options, 'b');

	input_options.done();
	output_options.done();
	options.done();

	BinaryInputOpenerFromOptions input_opener(
		options,input_options.filename,cin);
	BinaryOutputOpenerFromOptions output_opener(
		options,output_options.filename,cout);

	cerr << input_options.errors();
	cerr << output_options.errors();
	cerr << options.errors();
	cerr << input_opener.errors();
	cerr << output_opener.errors();

	if (!input_options.good()
	 || !output_options.good()
	 || !options.good()
	 || !input_opener.good()
	 || !output_opener.good()
	 || !options
	 || bad
	 || red.bad) {
		cerr 	<< MMsgDC(Usage) << ": " << options.command()
			<< input_options.usage()
			<< output_options.usage()
			<< " -rows|height|h n"
			<< " -columns|width|w n"
			<< " -[rgb]bits|[rgb]depth n"
			<< " -[rgb]T1|[rgb]Ta n"
			<< " -[rgb]T2|[rgb]Tb n"
			<< " -[rgb]T3|[rgb]Tc n"
			<< " -[rgb]limit|[rgb]lim n"
			<< " [-near n]"
			<< " [-reset n]"
			<< " [-noruns]"
			<< " [-v|verbose]"
			<< " [" << MMsgDC(InputFile)
				<< "[" << MMsgDC(OutputFile) << "]]"
			<< " <" << MMsgDC(InputFile)
			<< " >" << MMsgDC(OutputFile)
			<< endl;
		exit(1);
	}

	BinaryInputStream in(*(istream *)input_opener,input_options.byteorder);
	BinaryOutputStream out(*(ostream *)output_opener,output_options.byteorder);

	bool success=true;

	

	Uint16 max_bpp = red.bpp;
	max_bpp = (max_bpp > green.bpp) ? max_bpp : green.bpp;
	max_bpp = (max_bpp > blue.bpp) ? max_bpp : blue.bpp;

	Uint16 max_val = red.MAXVAL;
	max_val = (max_val > green.MAXVAL) ? max_val : green.MAXVAL;
	max_val = (max_val > blue.MAXVAL) ? max_val : blue.MAXVAL;

	// Add header of .pgm file when decompressing
	string header = "P6\n";
	header += to_string(red.COLUMNS) + ' ';
	header += to_string(red.ROWS) + '\n';
	header += to_string(max_val) + '\n';

	{
		Uint16 tempRow[Uint8_MAX];

		Assert(tempRow);

		for (Uint8 idx=0; idx<header.length(); idx++)
		{
			tempRow[idx] = (Uint16)header[idx];
		}

		writeRow(out, tempRow, header.length(), 8);
	}

	for (Uint16 row = 0; row < red.ROWS; ++row) {
		for (Uint16 col=0; col<red.COLUMNS; ++col) {

			decomp_single_pixel(in, row, col, red, 0);
			decomp_single_pixel(in, row, col, green, 0);
			decomp_single_pixel(in, row, col, blue, 0);
		}

		if (!writeRow(out,red.thisRow, green.thisRow, blue.thisRow,red.COLUMNS, max_bpp)) Assert(0);
		Uint16 *tmpRow=red.thisRow;
		red.thisRow=red.prevRow;
		red.prevRow=tmpRow;

		tmpRow=green.thisRow;
		green.thisRow=green.prevRow;
		green.prevRow=tmpRow;

		tmpRow=blue.thisRow;
		blue.thisRow=blue.prevRow;
		blue.prevRow=tmpRow;
	}

	return success ? 0 : 1;
}

void decomp_single_pixel(BinaryInputStream& in, Uint16 row, Uint16 col, ColorContext& ctx, bool useRunMode) {

	//	c b d .
	//	a x . .
	//	. . . .

	Int32 Rx;	// Reconstructed value - not Uint16 to allow overrange before clamping

	// value at edges (first row and first col is zero) ...

	Uint16 Ra;
	Uint16 Rb;
	Uint16 Rc;
	Uint16 Rd;

	if (row > 0) {
		Rb=ctx.prevRow[col];
		Rc=(col > 0) ? ctx.prevRow[col-1] : ctx.prevRa0;
		Ra=(col > 0) ? ctx.thisRow[col-1] : (ctx.prevRa0=Rb);
		Rd=(col+1 < ctx.COLUMNS) ? ctx.prevRow[col+1] : Rb;
	}
	else {
		Rb=Rc=Rd=0;
		Ra=(col > 0) ? ctx.thisRow[col-1] : (ctx.prevRa0=0);
	}

	// NB. We want the Reconstructed values, which are the same
	// in lossless mode, but if NEAR != 0 take care to write back
	// reconstructed values into the row buffers in previous positions

	// Compute local gradient ...

	Int32 D1=(Int32)Rd-Rb;
	Int32 D2=(Int32)Rb-Rc;
	Int32 D3=(Int32)Rc-Ra;

	// Check for run mode ... (should check Abs() works ok for Int32)

	if (Abs(D1) <= ctx.NEAR && Abs(D2) <= ctx.NEAR && Abs(D3) <= ctx.NEAR && useRunMode) {
		// // Run mode

		// // Why is RUNIndex not reset to 0 here ?
		// Uint32 R;
		// while (readBit(in,R)) {
		// 	if (R == 1) {
		// 		// Fill image with 2^J[RUNIndex] samples of Ra or till EOL
		// 		Int32 rm=J_rm[ctx.RUNIndex];
		// 		while (rm-- && col < ctx.COLUMNS) {
		// 			ctx.thisRow[col]=Ra;
		// 			++col;
		// 		}
		// 		// This will match when exact count coincides with end of row ...
		// 		if (rm == -1 && ctx.RUNIndex < 31) {
		// 			++ctx.RUNIndex;
		// 		}
		// 		if (col >= ctx.COLUMNS) {
		// 			break;
		// 		}
		// 	}
		// 	else {
		// 		// Read J[RUNIndex] bits and fill image with that number of samples of Ra
		// 		Uint16 bits=J[ctx.RUNIndex];
		// 		Uint32 nfill=0;
		// 		Uint32 bit;
		// 		// msb bit is read first
		// 		while (bits-- && readBit(in,bit)) {
		// 			nfill=(nfill<<1) | bit;
		// 		}
		// 		// Fill with nfill values of Ra
		// 		while (nfill--) {
		// 			Assert(col<(ctx.COLUMNS-1));
		// 			ctx.thisRow[col]=Ra;
		// 			++col;
		// 		}
		// 		// Decode the run interruption sample ...

		// 		// First update local context for interrupting sample, since weren't kept updated during run

		// 		if (row > 0) {
		// 			Rb=ctx.prevRow[col];
		// 			Ra=(col > 0) ? ctx.thisRow[col-1] : Rb;
		// 		}
		// 		else {
		// 			Rb=0;
		// 			Ra=(col > 0) ? ctx.thisRow[col-1] : 0;
		// 		}
		// 		codecRunEndSample(ctx.thisRow[col],Ra,Rb,ctx.RANGE,ctx.NEAR,ctx.MAXVAL,ctx.RESET,ctx.LIMIT,ctx.qbpp,J[ctx.RUNIndex],ctx.A,ctx.N,ctx.Nn,in,out,true, dbg_file);

		// 		if (ctx.RUNIndex > 0) {
		// 			--ctx.RUNIndex;	// NB. Do this AFTER J[RUNIndex] used in the limited length Golomb coding
		// 		}

		// 		break;
		// 	}
		// }

	}
	else
		{

		// Regular mode

		// Gradient quantization ... (A.3.3)

		Int16 Q1,Q2,Q3;

		if      (D1 <= -ctx.T3)   Q1=-4;
		else if (D1 <= -ctx.T2)   Q1=-3;
		else if (D1 <= -ctx.T1)   Q1=-2;
		else if (D1 <  -ctx.NEAR) Q1=-1;
		else if (D1 <=  ctx.NEAR) Q1= 0;
		else if (D1 <   ctx.T1)   Q1= 1;
		else if (D1 <   ctx.T2)   Q1= 2;
		else if (D1 <   ctx.T3)   Q1= 3;
		else                  Q1= 4;

		if      (D2 <= -ctx.T3)   Q2=-4;
		else if (D2 <= -ctx.T2)   Q2=-3;
		else if (D2 <= -ctx.T1)   Q2=-2;
		else if (D2 <  -ctx.NEAR) Q2=-1;
		else if (D2 <=  ctx.NEAR) Q2= 0;
		else if (D2 <   ctx.T1)   Q2= 1;
		else if (D2 <   ctx.T2)   Q2= 2;
		else if (D2 <   ctx.T3)   Q2= 3;
		else                  Q2= 4;

		if      (D3 <= -ctx.T3)   Q3=-4;
		else if (D3 <= -ctx.T2)   Q3=-3;
		else if (D3 <= -ctx.T1)   Q3=-2;
		else if (D3 <  -ctx.NEAR) Q3=-1;
		else if (D3 <=  ctx.NEAR) Q3= 0;
		else if (D3 <   ctx.T1)   Q3= 1;
		else if (D3 <   ctx.T2)   Q3= 2;
		else if (D3 <   ctx.T3)   Q3= 3;
		else                  Q3= 4;

		// Context merging and determination of SIGN ... (A.3.4)

		Int16 SIGN;

		// "If the 1st non-zero component of vector (Q1,Q2,Q3) is negative" ...

		if ( Q1 < 0
			|| (Q1 == 0 && Q2 < 0)
			|| (Q1 == 0 && Q2 == 0 && Q3 < 0) ) {
			Q1=-Q1;
			Q2=-Q2;
			Q3=-Q3;
			SIGN=-1;	// signifies -ve
		}
		else {
			SIGN=1;		// signifies +ve
		}

		// The derivation of Q is not specified in the standard :(

		// Let's try this approach ....

		// Q1 can be 0 to 4 only
		// Q1 1 to 4 and Q2 -4 to 4 and Q3 -4 to 4	= 4*9*9 = 324
		// Q1 0 and Q2 1 to 4 only and Q3 -4 to 4	= 1*4*9 = 36
		// Q1 0 and Q2 0 and Q3 0 to 4			= 1*1*5 = 5
		// total of 365
		// and 0,0,0 (Q == 360) only occurs for run mode or regular mode with sample interleaved

		Uint16 Q;

		if (Q1 == 0) {
			if (Q2 == 0) {
				Q=360+Q3;		// fills 360..364
			}
			else {	// Q2 is 1 to 4
				Q=324+(Q2-1)*9+(Q3+4);	// fills 324..359
			}
		}
		else {		// Q1 is 1 to 4
			Q=(Q1-1)*81+(Q2+4)*9+(Q3+4);	// fills 0..323
		}

		Assert(Q<ctx.nContexts);	// Just in case

		// Figure A.5 Edge detecting predictor ...

		Int32 Px;	// Predicted value - not Uint16 to allow overrange before clamping

		if      (Rc >= Maximum(Ra,Rb))	Px = Minimum(Ra,Rb);
		else if (Rc <= Minimum(Ra,Rb))	Px = Maximum(Ra,Rb);
		else				Px = (Int32)Ra+Rb-Rc;

		// Figure A.6 Prediction correction and clamping ...

		Px = Px + ((SIGN > 0) ? ctx.C[Q] : -ctx.C[Q]);

		clampPredictedValue(Px, ctx.MAXVAL);

		// Figure A.10 Prediction error Golomb encoding and decoding...

		Uint16 k = determineGolombParameter(ctx.N[Q],ctx.A[Q]);
		
		Uint32 MErrval;
		Int32 Errval;
		Int32 updateErrval;

		// Decode Golomb mapped error from input...
		decodeMappedErrvalWithGolomb(k,ctx.LIMIT,ctx.qbpp,MErrval,in);

		// Unmap error from non-negative (inverse of A.5.2 Figure A.11) ...

		if (ctx.NEAR == 0 && k == 0 && 2*ctx.B[Q] <= -ctx.N[Q]) {
			if (MErrval%2 != 0)
				Errval=((Int32)MErrval-1)/2;	//  1 becomes  0,  3 becomes  1,  5 becomes  2
			else
				Errval=-(Int32)MErrval/2 - 1;	//  0 becomes -1,  2 becomes -2,  4 becomes -3
		}
		else {
			if (MErrval%2 == 0)
				Errval=(Int32)MErrval/2;	//  0 becomes  0, 2 becomes  1,  4 becomes  2
			else
				Errval=-((Int32)MErrval + 1)/2;	//  1 becomes -1, 3 becomes -2
		}

		updateErrval=Errval;			// NB. Before dequantization and sign correction

		deQuantizeErrval(ctx.NEAR,Errval);

		if (SIGN < 0) Errval=-Errval;		// if "context type" was negative

		Rx=Px+Errval;

		// modulo(RANGE*(2*NEAR+1)) as per F.1 Item 14

		// (NB. Is this really the reverse of the encoding procedure ???)

		if (Rx < -ctx.NEAR)
			Rx+=ctx.RANGE*(2*ctx.NEAR+1);
		else if (Rx > ctx.MAXVAL+ctx.NEAR)
			Rx-=ctx.RANGE*(2*ctx.NEAR+1);

		clampPredictedValue(Rx,ctx.MAXVAL);

		// Apply inverse point transform and mapping table when implemented

		ctx.thisRow[col]=(Uint16)Rx;

		// Update variables (A.6) ...

		// A.6.1 Use the signed error after modulo reduction (figure A.12 note). which is updateErrval

		ctx.B[Q]=ctx.B[Q]+updateErrval*(2*ctx.NEAR+1);
		ctx.A[Q]=ctx.A[Q]+Abs(updateErrval);
		if (ctx.N[Q] == ctx.RESET) {
			ctx.A[Q]=ctx.A[Q]>>1;
			ctx.B[Q]=ctx.B[Q]>>1;
			ctx.N[Q]=ctx.N[Q]>>1;
		}
		++ctx.N[Q];

		// A.6.2 Context dependent bias cancellation ...

		if (ctx.B[Q] <= -ctx.N[Q]) {
			ctx.B[Q]+=ctx.N[Q];
			if (ctx.C[Q] > ctx.MIN_C) --ctx.C[Q];
			if (ctx.B[Q] <= -ctx.N[Q]) ctx.B[Q]=-ctx.N[Q]+1;
		}
		else if (ctx.B[Q] > 0) {
			ctx.B[Q]-=ctx.N[Q];
			if (ctx.C[Q] < ctx.MAX_C) ++ctx.C[Q];
			if (ctx.B[Q] > 0) ctx.B[Q]=0;
		}

	}
}