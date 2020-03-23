#================================================================
# Makefile for BLAS and LAPACK Interface Libraries, 
#              Excel DLL and User Executables 
# 
# Targets:
#
#  default - Make debug executable (debug.exe) and run it.
#
#  all     - Make BLAS and LAPACK interface libraries
#            (libblas95.a and liblapack95.a),
#            Excel dll's (lapack_64bit.dll and lapack_32bit.dll)
#            and executables (debug.exe and lapack.exe).
#
#  clean      - Remove all object files (*.o)
#  extraclean - Remove all created files
#
# Library targets (\mk\lib.mk):
#
#   blas           - Make BLAS interface library
#   lapack         - Make LAPACK interface library
#   lib            - Make blas and lapack
#   clean_lib      - Remove object files (*.o)
#   extraclean_lib - Remove all *.o, *.mod, *.a files
#
# Dynamic link library targets (\mk\dll.mk):
#  
#   dll            - Make lapack_32bit.dll and lapack_64bit.dll
#   clean_dll      - Remove object files (*.o)
#   extraclean_dll - Remove all *.o, *.dll files
#   
# Executable targets (\mk\exe.mk):
#  
#   release        - Make lapack.exe (-O2 optimized) 
#   debug          - Make debug.exe (w/ debug flags) 
#   run            - Run lapack.exe
#   debugrun       - Run debug.exe
#   clean_exe      - Remove object files (*.o)
#   extraclean_exe - Remove all *.o, *.exe files
#
# Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

#
# Targets
#
default   : debug
all       : lib dll debug release clean
clean     : clean_lib clean_dll clean_exe
extraclean: extraclean_lib extraclean_dll extraclean_exe

#
# Directories
#
DIR_SRC   := ../src/
DIR_BIN   := ../bin/
DIR_LIB   := ../lib/
DIR_OBJ   := ../obj/release/
DIR_DBG   := ../obj/debug/
DIR_DLL   := ../obj/dll/
DIR_DLL32 := ../obj/dll32/

#
# Executables and DLL's
#
EXE   := $(DIR_BIN)lapack.exe
DBG   := $(DIR_BIN)debug.exe
DLL   := $(DIR_BIN)lapack_64bit.dll
DLL32 := $(DIR_BIN)lapack_32bit.dll

#
# Include makefiles
#
include ../mk/lib.mk
include ../mk/exe.mk
include ../mk/dll.mk

#
# Compilation flags
#
FC    := "C:/Rtools/mingw_64/bin/gfortran"
FC32  := "C:/Rtools/mingw_32/bin/gfortran"
AR    := "C:/Rtools/mingw_64/bin/ar"
AR32  := "C:/Rtools/mingw_32/bin/ar"
CFRGS := -cpp -ffree-line-length-none
RFRGS := -Drelease -O2
DFRGS := -Ddebug -g -Wall
AARGS := -rcsv
RM    := rm -f
MD    := @mkdir -p
