DOC=\cbx\mars\doc
PHOBOSDOC=\cbx\mars\doc\phobos
# Where scp command copies to
SCPDIR=..\backup

##### Tools

# D compiler
DMD=dmd
# C++ compiler
CC=dmc
# Make program
MAKE=make
# Librarian
LIB=lib
# Delete file(s)
DEL=del
# Make directory
MD=mkdir
# Remove directory
RD=rmdir
# File copy
CP=cp
# De-tabify
DETAB=detab
# Convert line endings to Unix
TOLF=tolf
# Zip
ZIP=zip32
# Copy to another directory
SCP=$(CP)

DFLAGS=-O -release

TARGETS=dman.exe findtags.exe rdmd.exe changed.exe dustmite.exe

MAKEFILES=win32.mak posix.mak

SRCS=dman.d findtags.d rdmd.d ddemangle.d

TAGS=	expression.tag \
	statement.tag \
	std_algorithm.tag \
	std_array.tag \
	std_file.tag \
	std_format.tag \
	std_math.tag \
	std_parallelism.tag \
	std_path.tag \
	std_random.tag \
	std_range.tag \
	std_regex.tag \
	std_stdio.tag \
	std_string.tag \
	std_traits.tag \
	std_typetuple.tag

targets : $(TARGETS)

expression.tag : findtags.exe $(DOC)\expression.html
	+findtags $(DOC)\expression.html >expression.tag


statement.tag : findtags.exe $(DOC)\statement.html
	+findtags $(DOC)\statement.html >statement.tag

std_algorithm.tag : findtags.exe $(PHOBOSDOC)\std_algorithm.html
	+findtags $(PHOBOSDOC)\std_algorithm.html >std_algorithm.tag

std_array.tag : findtags.exe $(PHOBOSDOC)\std_array.html
	+findtags $(PHOBOSDOC)\std_array.html >std_array.tag

std_file.tag : findtags.exe $(PHOBOSDOC)\std_file.html
	+findtags $(PHOBOSDOC)\std_file.html >std_file.tag

std_format.tag : findtags.exe $(PHOBOSDOC)\std_format.html
	+findtags $(PHOBOSDOC)\std_format.html >std_format.tag

std_math.tag : findtags.exe $(PHOBOSDOC)\std_math.html
	+findtags $(PHOBOSDOC)\std_math.html >std_math.tag

std_parallelism.tag : findtags.exe $(PHOBOSDOC)\std_parallelism.html
	+findtags $(PHOBOSDOC)\std_parallelism.html >std_parallelism.tag

std_path.tag : findtags.exe $(PHOBOSDOC)\std_path.html
	+findtags $(PHOBOSDOC)\std_path.html >std_path.tag

std_random.tag : findtags.exe $(PHOBOSDOC)\std_random.html
	+findtags $(PHOBOSDOC)\std_random.html >std_random.tag

std_range.tag : findtags.exe $(PHOBOSDOC)\std_range.html
	+findtags $(PHOBOSDOC)\std_range.html >std_range.tag

std_regex.tag : findtags.exe $(PHOBOSDOC)\std_regex.html
	+findtags $(PHOBOSDOC)\std_regex.html >std_regex.tag

std_stdio.tag : findtags.exe $(PHOBOSDOC)\std_stdio.html
	+findtags $(PHOBOSDOC)\std_stdio.html >std_stdio.tag

std_string.tag : findtags.exe $(PHOBOSDOC)\std_string.html
	+findtags $(PHOBOSDOC)\std_string.html >std_string.tag

std_traits.tag : findtags.exe $(PHOBOSDOC)\std_traits.html
	+findtags $(PHOBOSDOC)\std_traits.html >std_traits.tag

std_typetuple.tag : findtags.exe $(PHOBOSDOC)\std_typetuple.html
	+findtags $(PHOBOSDOC)\std_typetuple.html >std_typetuple.tag


findtags.exe : findtags.d
	$(DMD) findtags.d

dman.exe : dman.d $(TAGS)
	$(DMD) $(DFLAGS) dman.d -J.

rdmd.exe : rdmd.d
	$(DMD) $(DFLAGS) rdmd.d advapi32.lib

dustmite.exe : DustMite/dustmite.d DustMite/dsplit.d
	$(DMD) $(DFLAGS) DustMite/dustmite.d DustMite/dsplit.d -of$@

changed.exe : changed.d
	$(DMD) $(DFLAGS) changed.d

clean :
	del $(TARGETS) $(TAGS)

detab:
	$(DETAB) $(SRCS)

tolf:
	$(TOLF) $(SRCS) $(MAKEFILES)

zip: detab tolf $(MAKEFILES)
	$(DEL) dman.zip
	$(ZIP) dman $(MAKEFILES) $(SRCS) $(TAGS)

scp: detab tolf $(MAKEFILES)
	$(SCP) $(SRCS) $(MAKEFILES) $(SCPDIR)



