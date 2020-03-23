#==================================================
# Makefile for BLAS and LAPACK libraries 
#
# Created by: Hisashi Takeda, Ph.D. on: 2020-03-23.

#
# Directories
#
DIR_IF  := $(DIR_LIB)interfaces/
DIR_B95 := $(DIR_IF)blas95/
DIR_L95 := $(DIR_IF)lapack95/

#
# BLAS and LAPACK source files
#
VPATH         := $(DIR_LIB) $(DIR_IF) $(DIR_B95) $(DIR_L95)
PATH_SRCS_B95 := $(DIR_IF)blas_interfaces.f90  $(DIR_IF)blas.f90
PATH_SRCS_B95 += $(wildcard $(DIR_B95)*.f90)
PATH_SRCS_L95 := $(DIR_IF)lapack_interfaces.f90 $(DIR_IF)lapack.f90
PATH_SRCS_L95 += $(wildcard $(DIR_L95)*.f90)
SRCS_B95      := $(notdir $(PATH_SRCS_B95))
SRCS_L95      := $(notdir $(PATH_SRCS_L95))

#
# Object files
#
OBJS_B95      :=$(SRCS_B95:.f90=.o)
OBJS_L95      :=$(SRCS_L95:.f90=.o)
PATH_OBJS_B95 :=$(addprefix $(DIR_LIB), $(OBJS_B95))
PATH_OBJS_L95 :=$(addprefix $(DIR_LIB), $(OBJS_L95))

#
# Libraries
#
LIB_B77       := libblas.a
LIB_L77       := liblapack.a
LIB_B95       := libblas95.a
LIB_L95       := liblapack95.a
LIBS_BL       := $(LIB_L95) $(LIB_L77) $(LIB_B95) $(LIB_B77)
PATH_LIBS_BL  := $(addprefix $(DIR_LIB), $(LIBS_BL))
PATH_LIB_B95  := $(addprefix $(DIR_LIB), $(LIB_B95))
PATH_LIB_L95  := $(addprefix $(DIR_LIB), $(LIB_L95))

#
# BLAS and LAPACK interface libraries
#
.PHONY: lib blas lapack

lib: blas lapack
blas:   $(PATH_LIB_B95)
lapack: $(PATH_LIB_L95)

# BLAS95 library
$(PATH_LIB_B95): $(PATH_OBJS_B95) 
	$(AR) $(AARGS) $@ $^

# LAPACK95 library
$(PATH_LIB_L95): $(PATH_OBJS_L95)
	$(AR) $(AARGS) $@ $^

#
# Implicit rule for making object files
#
$(DIR_LIB)%.o: $(DIR_IF)%.f90
	$(FC) $(CFRGS) $(RFRGS) -I $(DIR_IF) -J $(DIR_LIB) -o $@ -c $^

$(DIR_LIB)%.o:$(DIR_B95)%.f90
	$(FC) $(CFRGS) $(RFRGS) -I $(DIR_B95) -J $(DIR_LIB) -o $@ -c $^

$(DIR_LIB)%.o:$(DIR_L95)%.f90
	$(FC) $(CFRGS) $(RFRGS) -I $(DIR_L95) -J $(DIR_LIB) -o $@ -c $^

#
# Clean up
#
clean_lib:
	$(RM) $(PATH_OBJS_B95) $(PATH_OBJS_L95)

extraclean_lib:
	$(RM) $(PATH_OBJS_B95) $(PATH_OBJS_L95)
	$(RM) $(PATH_LIB_B95) $(PATH_LIB_L95)
	$(RM) $(DIR_LIB)*.mod 
