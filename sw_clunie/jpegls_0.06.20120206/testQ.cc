#include <iostream.h>

static const int nContexts = 365;

int main(int argc, char ** argv)
{

	int *checkfill = new int[nContexts];
	int i;
	for (i=0; i<nContexts; ++i) checkfill[i]=0;

	short int oQ1,oQ2,oQ3;

	cerr << "Q1\tQ2\tQ3\tSIGN\tQ1\tQ2\tQ3\tQ\n" << endl;

	for (oQ1 = -4; oQ1 <= 4; ++oQ1) {
		for (oQ2 = -4; oQ2 <= 4; ++oQ2) {
			for (oQ3 = -4; oQ3 <= 4; ++oQ3) {

				// Context merging and determination of SIGN ... (A.3.4)

				short int Q1,Q2,Q3;
				short int SIGN;
				unsigned short Q;

				// "If the 1st non-zero component of vector (Q1,Q2,Q3) is negative" ...

				if ( oQ1 < 0
				 || (oQ1 == 0 && oQ2 < 0)
				 || (oQ1 == 0 && oQ2 == 0 && oQ3 < 0) ) {
					Q1=-oQ1;
					Q2=-oQ2;
					Q3=-oQ3;
					SIGN=-1;	// signifies -ve
				}
				else {
					Q1=oQ1;
					Q2=oQ2;
					Q3=oQ3;
					SIGN=1;		// signifies +ve
				}

				// Q1 therefore always becomes +ve or is already 0

				// The derivation of Q is not specified in the standard :(

				// Q1 can be 0 to 4 only
				// Q1 1 to 4 and Q2 -4 to 4 and Q3 -4 to 4	= 4*9*9 = 324
				// Q1 0 and Q2 1 to 4 only and Q3 -4 to 4	= 1*4*9 = 36
				// Q1 0 and Q2 0 and Q3 0 to 4		= 1*1*5 = 5
				// total of 365
				// and 0,0,0 only occurs for run mode or regular mode with sample interleaved

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

				cerr << oQ1 << "\t" << oQ2 << "\t" << oQ3 << "\t" << SIGN << "\t" << Q1 << "\t" << Q2 << "\t" << Q3 << "\t" << Q << endl;

				if (Q < nContexts)
					++checkfill[Q];
				else
					cerr << "Q was outside bounds" << endl;
			}
		}
	}

	cerr << "\n\nCheckfill:" << endl;
	for (i=0; i<nContexts; ++i)
		cerr << "[" << i << "]: " << checkfill[i] << endl;

}

