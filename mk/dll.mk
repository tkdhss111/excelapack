#==============================================================================
# Makefile for Dynamic Link Library 
#
# Compiler settings see:
# https://wiki.tcl-lang.org/page/calling+Fortran+routines+in+a+DLL
# The "static" flags are to make the DLL work on systems where gfortran hasn't been installed separately. 
#
# Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

SRCS_DLL        := lapack_dll.f90
VPATH           := $(DIR_SRC)
OBJS_DLL        := $(SRCS_DLL:.f90=.o)
PATH_OBJS_DLL   := $(addprefix $(DIR_DLL),   $(OBJS_DLL))
PATH_OBJS_DLL32 := $(addprefix $(DIR_DLL32), $(OBJS_DLL))
WIN32           := -mrtd
LFRGS           := -shared -static -fPIC

.PHONY: dll

dll: $(DLL) $(DLL32)

$(DLL): $(PATH_OBJS_DLL)
	$(FC) $(CFRGS) $(LFRGS) -o $@ $^ $(PATH_LIBS_BL)

$(DLL32): $(PATH_OBJS_DLL32)
	$(FC32) $(CFRGS) $(LFRGS) $(WIN32) -o $@ $^ $(PATH_LIBS_BL)

#
# Implicit rule for making object files
#
$(DIR_DLL)%.o:%.f90
	$(MD) $(DIR_DLL)
	$(FC) $(CFRGS) -fno-underscoring -o $@ -c $^

$(DIR_DLL32)%.o:%.f90
	$(MD) $(DIR_DLL32)
	$(FC32) $(CFRGS) $(WIN32) -fno-underscoring -o $@ -c $^

#
# Clean up
#
clean_dll:
	$(RM) $(PATH_OBJS_DLL)
	$(RM) $(PATH_OBJS_DLL32)

extraclean_dll:
	$(RM) $(PATH_OBJS_DLL) $(DLL)
	$(RM) $(PATH_OBJS_DLL32) $(DLL32)
	$(RM) -r $(DIR_DLL) $(DIR_DLL32)
