ARCHIVENAME        = jpegls

ARCHIVEFILES       = *.cc *.h *.sh *.html Makefile data man [A-Z]*

              CCC = g++
         COMPRESS = bzip2
      COMPRESSEXT = bz2
              TAR = tar
           TAREXT = tar
               MV = mv
               RM = rm -rf

CPLUSPLUS_ALLDEFINES = -DUSEOWNLOG2=1 -DHASGETHOSTID=1 -DHASGETHOSTIDPROTOTYPE=1 -Wno-deprecated

CPLUSPLUS_SRCS = rawnjl2.cc getoptns.cc bnopti.cc bnopto.cc mesgtext.cc

all:	rawnjl2

rawnjl2: $(CPLUSPLUS_SRCS)
	$(CCC) $(CPLUSPLUS_ALLDEFINES) -o rawnjl2 $(CPLUSPLUS_SRCS)

clean:
	rm -f rawnjl2 core *% data/*.cmp data/*.jls *.bak

test:
	@echo Testing lossless on tiny image from standard
	./rawnjl2 -rows 4 -columns 4 -depth 8 -input-endian little data/njltest.raw data/njltest.jls
	@echo Comparing JLS compressed output with expected
	cmp data/njltest.jls data/njltest.jls.dist
	./rawnjl2 -d -output-endian little data/njltest.jls data/njltest.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/njltest.raw data/njltest.cmp
	@echo Testing lossless on HP image
	./rawnjl2 -rows 256 -columns 256 -depth 8 -input-endian little data/hploco.raw data/hploco.jls
	@echo Comparing JLS compressed output with expected
	cmp data/hploco.jls data/hploco.jls.dist
	./rawnjl2 -d -output-endian little data/hploco.jls data/hploco.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/hploco.raw data/hploco.cmp
	@echo Testing lossless on 16 bit CT image
	./rawnjl2 -rows 512 -columns 512 -depth 16 -input-endian little data/CT2.raw data/CT2.jls
	@echo Comparing JLS compressed output with expected
	cmp data/CT2.jls data/CT2.jls.dist
	./rawnjl2 -d -output-endian little data/CT2.jls data/CT2.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/CT2.raw data/CT2.cmp
	@echo Testing without runs on tiny image from standard
	./rawnjl2 -rows 4 -columns 4 -depth 8 -input-endian little -noruns data/njltest.raw data/njltest.noruns.jls
	@echo Comparing JLS compressed output with expected
	cmp data/njltest.noruns.jls data/njltest.noruns.jls.dist
	./rawnjl2 -d -output-endian little -noruns data/njltest.noruns.jls data/njltest.noruns.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/njltest.raw data/njltest.noruns.cmp
	@echo Testing without runs on HP image
	./rawnjl2 -rows 256 -columns 256 -depth 8 -input-endian little -noruns data/hploco.raw data/hploco.noruns.jls
	@echo Comparing JLS compressed output with expected
	cmp data/hploco.noruns.jls data/hploco.noruns.jls.dist
	./rawnjl2 -d -output-endian little -noruns data/hploco.noruns.jls data/hploco.noruns.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/hploco.raw data/hploco.noruns.cmp
	@echo Testing without runs on 16 bit CT image
	./rawnjl2 -rows 512 -columns 512 -depth 16 -input-endian little -noruns data/CT2.raw data/CT2.noruns.jls
	@echo Comparing JLS compressed output with expected
	cmp data/CT2.noruns.jls data/CT2.noruns.jls.dist
	./rawnjl2 -d -output-endian little -noruns data/CT2.noruns.jls data/CT2.noruns.cmp
	@echo Comparing JLS decompressed output with original
	cmp data/CT2.raw data/CT2.noruns.cmp
	@echo Testing near-lossless on tiny image from standard
	./rawnjl2 -rows 4 -columns 4 -depth 8 -input-endian little -near 3 data/njltest.raw data/njltest.near.jls
	@echo Comparing JLS compressed output with expected
	cmp data/njltest.near.jls data/njltest.near.jls.dist
	./rawnjl2 -d -output-endian little data/njltest.near.jls data/njltest.near.cmp
	@echo No comparision of JLS decompressed output with original since not lossless mode
	@echo Testing near-lossless on HP image
	./rawnjl2 -rows 256 -columns 256 -depth 8 -input-endian little -near 3 data/hploco.raw data/hploco.near.jls
	@echo Comparing JLS compressed output with expected
	cmp data/hploco.near.jls data/hploco.near.jls.dist
	./rawnjl2 -d -output-endian little data/hploco.near.jls data/hploco.near.cmp
	@echo No comparision of JLS decompressed output with original since not lossless mode
	@echo Testing near-lossless on 16 bit CT image
	./rawnjl2 -rows 512 -columns 512 -depth 16 -input-endian little -near 3 data/CT2.raw data/CT2.near.jls
	@echo Comparing JLS compressed output with expected
	cmp data/CT2.near.jls data/CT2.near.jls.dist
	./rawnjl2 -d -output-endian little data/CT2.near.jls data/CT2.near.cmp
	@echo No comparision of JLS decompressed output with original since not lossless mode

testdist:
	$(MV) data/njltest.jls data/njltest.jls.dist
	$(MV) data/hploco.jls data/hploco.jls.dist
	$(MV) data/CT2.jls data/CT2.jls.dist
	$(MV) data/njltest.noruns.jls data/njltest.noruns.jls.dist
	$(MV) data/hploco.noruns.jls data/hploco.noruns.jls.dist
	$(MV) data/CT2.noruns.jls data/CT2.noruns.jls.dist
	$(MV) data/njltest.near.jls data/njltest.near.jls.dist
	$(MV) data/hploco.near.jls data/hploco.near.jls.dist
	$(MV) data/CT2.near.jls data/CT2.near.jls.dist

World:	clean all test

archive: clean
	version=""; \
	if [ -f VERSION ]; \
		then version="_"`cat VERSION`; fi; \
	link=$(ARCHIVENAME)$$version; \
	ln -s . $$link; \
	archive=$(ARCHIVENAME)$$version.$(TAREXT).$(COMPRESSEXT); \
	if [ -f $$archive ]; then $(MV) $$archive $$archive.old; fi; \
	$(TAR) cvh -f - `for i in $(ARCHIVEFILES); do echo $$link/$$i; done` \
		| $(COMPRESS) > $$archive; \
	rm $$link
