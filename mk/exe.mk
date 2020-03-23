#==========================================
# Makefile for BLAS and LAPACK Executables 
#
# Created by: Hisashi Takeda, Ph.D. on: .

SRC_EXE      := lapack_exe.f90
VPATH        := $(DIR_SRC)
OBJ_EXE      :=$(SRC_EXE:.f90=.o)
PATH_OBJ_EXE :=$(addprefix $(DIR_OBJ), $(OBJ_EXE))
PATH_DBG_EXE :=$(addprefix $(DIR_DBG), $(OBJ_EXE))

.PHONY: release debug run debugrun

release: $(EXE)
debug  : $(DBG) debugrun

run:
	$(EXE)

debugrun:
	$(DBG)

#
# Executable 
#
$(EXE): $(PATH_OBJ_EXE)
	$(FC) $(CFRGS) $(RFRGS) -I $(DIR_OBJ) -J $(DIR_LIB) -o $@ $^ $(PATH_LIBS_BL)

$(DBG): $(PATH_DBG_EXE)
	$(FC) $(CFRGS) $(DFRGS) -I $(DIR_DBG) -J $(DIR_LIB) -o $@ $^ $(PATH_LIBS_BL)

#
# Implicit rules for making object files
#
# N.B. Module files for debug are located in DIR_LIB
#
$(DIR_OBJ)%.o:%.f90
	$(MD) $(DIR_OBJ)
	$(FC) $(CFRGS) $(RFRGS) -I $(DIR_OBJ) -J $(DIR_LIB) -o $@ -c $^

$(DIR_DBG)%.o:%.f90
	$(MD) $(DIR_DBG)
	$(FC) $(CFRGS) $(DFRGS) -I $(DIR_DBG) -J $(DIR_LIB) -o $@ -c $^

#
# Clean up
#
clean_exe:
	$(RM) $(PATH_OBJ_EXE) $(PATH_DBG_EXE)
	$(RM) $(DIR_BIN)*.log $(DIR_BIN)lapack_input $(DIR_BIN)lapack_output

extraclean_exe:
	$(RM) $(PATH_OBJ_EXE) $(PATH_DBG_EXE)
	$(RM) $(DIR_BIN)*.log $(DIR_BIN)lapack_input $(DIR_BIN)lapack_output
	$(RM) -r $(DIR_OBJ) $(DIR_DBG)
	$(RM) $(EXE) $(DBG)
