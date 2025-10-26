# ---------------------------------------------------------------------------
!if !$d(BCB)
BCB = $(MAKEDIR)\..
!endif

# ---------------------------------------------------------------------------
# IDE SECTION
# ---------------------------------------------------------------------------
# The following section of the project makefile is managed by the BCB IDE.
# It is recommended to use the IDE to change any of the values in this
# section.
# ---------------------------------------------------------------------------

VERSION = BCB.06.00
# ---------------------------------------------------------------------------
PROJECT = wmidcl60.bpl
OBJFILES = wmidcl60.obj WmiReg.obj WmiRegEditors.obj
RESFILES = 
MAINSOURCE = wmidcl60.cpp
RESDEPEN = $(RESFILES)
LIBFILES = 
IDLFILES = 
IDLGENFILES = 
LIBRARIES = dclocx.lib bcbsmp.lib
PACKAGES = rtl.bpi vcl.bpi dclstd.bpi designide.bpi VclCommonDcl60.bpi wmirtl60.bpi
SPARELIBS = rtl.lib bcbsmp.lib dclocx.lib wmirtl60.lib
DEFFILE = 
OTHERFILES = 
# ---------------------------------------------------------------------------
DEBUGLIBPATH = $(BCB)\lib\debug
RELEASELIBPATH = $(BCB)\lib\release
USERDEFINES = $(SYSDEFINES);$(USERDEFINES)
SYSDEFINES = NO_STRICT;USEPACKAGES
INCLUDEPATH = ..\common
LIBPATH = $(BCB)\Lib;$(BCB)\Projects\Lib;..\common
WARNINGS= 
PATHCPP = .;
PATHASM = .;
PATHPAS = .;
PATHRC = .;
PATHOBJ = .;$(LIBPATH)
# ---------------------------------------------------------------------------
CFLAG1 = -O2 -H=f:\PROGRA~1\borland\CBUILD~3\lib\vcl60.csm -Hc -w -Vx -Ve -Tkh30000 \
    -X- -a8 -b- -k- -vi -I$(BCB)\lib\obj;$(BCB)\include\vcl;$(BCB)\include \
    -D$(SYSDEFINES);$(USERDEFINES) -c -w-par -w-inl -tWM -tWM -tWM
IDLCFLAGS = -src_suffix cpp -D$(SYSDEFINES) -D$(USERDEFINES) -boa
PFLAGS = -N2. -N0. -$Y- -$L- -$D- -$A8 \
    -U$(BCB)\Projects\Lib;$(BCB)\lib\obj;$(BCB)\lib;$(RELEASELIBPATH) \
    -I$(BCB)\lib\obj;$(BCB)\include\vcl;$(BCB)\include;..\common \
    -D$(SYSDEFINES);$(USERDEFINES) -v -LUdclstd -M -JPHNE -JPHNE -JPHNE
RFLAGS = -i$(BCB)\lib\obj;$(BCB)\include\vcl;$(BCB)\include \
    -D$(SYSDEFINES);$(USERDEFINES)
AFLAGS = /mx /w2 /zn /i$(BCB)\lib\obj /i$(BCB)\include\vcl /i$(BCB)\include \
    /d$(SYSDEFINES) /d$(USERDEFINES)
LFLAGS = -l. -I. -D"Design time package with NT specific components" -aa -Tpp -Gpd \
    -x -Gn -Gl -Gi \
    -L$(BCB)\Projects\Lib;$(BCB)\lib\obj;$(BCB)\lib;$(RELEASELIBPATH)
# ---------------------------------------------------------------------------
ALLOBJ = c0pkg32.obj $(PACKAGES) sysinit.obj sysinit.obj sysinit.obj $(OBJFILES)
ALLRES = $(RESFILES)
ALLLIB = $(LIBFILES) $(LIBRARIES) import32.lib cp32mt.lib
# ---------------------------------------------------------------------------
!ifdef IDEOPTIONS

[Version Info]
IncludeVerInfo=0
AutoIncBuild=0
MajorVer=1
MinorVer=0
Release=0
Build=0
Debug=0
PreRelease=0
Special=0
Private=0
DLL=0

[Version Info Keys]
CompanyName=
FileDescription=
FileVersion=1.0.0.0
InternalName=
LegalCopyright=
LegalTrademarks=
OriginalFilename=
ProductName=
ProductVersion=1.0.0.0
Comments=

[Debugging]
DebugSourceDirs=$(BCB)\source\vcl

!endif





# ---------------------------------------------------------------------------
# MAKE SECTION
# ---------------------------------------------------------------------------
# This section of the project file is not used by the BCB IDE.  It is for
# the benefit of building from the command-line using the MAKE utility.
# ---------------------------------------------------------------------------

.autodepend
# ---------------------------------------------------------------------------
!if "$(USERDEFINES)" != ""
AUSERDEFINES = -d$(USERDEFINES:;= -d)
!else
AUSERDEFINES =
!endif

!if !$d(BCC32)
BCC32 = bcc32
!endif

!if !$d(CPP32)
CPP32 = cpp32
!endif

!if !$d(DCC32)
DCC32 = dcc32
!endif

!if !$d(TASM32)
TASM32 = tasm32
!endif

!if !$d(LINKER)
LINKER = ilink32
!endif

!if !$d(BRCC32)
BRCC32 = brcc32
!endif


# ---------------------------------------------------------------------------
!if $d(PATHCPP)
.PATH.CPP = $(PATHCPP)
.PATH.C   = $(PATHCPP)
!endif

!if $d(PATHPAS)
.PATH.PAS = $(PATHPAS)
!endif

!if $d(PATHASM)
.PATH.ASM = $(PATHASM)
!endif

!if $d(PATHRC)
.PATH.RC  = $(PATHRC)
!endif

!if $d(PATHOBJ)
.PATH.OBJ  = $(PATHOBJ)
!endif
# ---------------------------------------------------------------------------
$(PROJECT): $(OTHERFILES) $(IDLGENFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(BCB)\BIN\$(LINKER) @&&!
    $(LFLAGS) -L$(LIBPATH) +
    $(ALLOBJ), +
    $(PROJECT),, +
    $(ALLLIB), +
    $(DEFFILE), +
    $(ALLRES)
!
# ---------------------------------------------------------------------------
.pas.hpp:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.pas.obj:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.cpp.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.cpp.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.asm.obj:
    $(BCB)\BIN\$(TASM32) $(AFLAGS) -i$(INCLUDEPATH:;= -i) $(AUSERDEFINES) -d$(SYSDEFINES:;= -d) $<, $@

.rc.res:
    $(BCB)\BIN\$(BRCC32) $(RFLAGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -fo$@ $<



# ---------------------------------------------------------------------------




