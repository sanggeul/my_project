#!/bin/bash


echo $0 

mkdir -p dump
mkdir -p log

SIM=$(echo $0 | cut -f2 -d'/' | cut -f1 -d. | tr '[:upper:]' '[:lower:]')
DUV=$(echo $0 | cut -f2 -d'/' | cut -f2 -d. | tr '[:upper:]' '[:lower:]')
FNC=$(echo $0 | cut -f2 -d'/' | cut -f3 -d. | tr '[:upper:]' '[:lower:]')

TOP_TB="top_tb.v"
CFG="filelist.${DUV}.f"
OPTION="${OPTION} +define+${DUV}"

#----------------------------------------
# define sim
SIMDUV="+define+`echo ${DUV} | tr '[:lower:]' '[:upper:]'`"

#----------------------------------------
# define dump
DUMPDEF="+define+DUMP" # dump on/off
DUMPDEF="${DUMPDEF} +define+DUMPFILE=\"./dump/dump.${DUV}.${FNC}.fsdb\""
if [ -f "./dump.${DUV}.v" ];then
    DUMPDEF="${DUMPDEF} +define+DUMPMODULE=\"./dump.${DUV}.v\""
elif [ -f "./dump.v" ];then
    DUMPDEF="${DUMPDEF} +define+DUMPMODULE=\"./dump.v\""
else
    echo "Error! Dump Module not found!"
    exit 1
fi

#----------------------------------------
# define libdir
LIBDIR="libs_${SIM}.${DUV}.${FNC}"
mkdir -p ${LIBDIR}


ncverilog \
	+nc64bit \
	+access+r \
	+functional_mode \
    +nclibdirname+${LIBDIR} \
    -l ./log/${SIM}.${DUV}.${FNC}.log \
	${OPTION} \
	${SIMDUV} \
	${DUMPDEF} \
	+fsdb+autoflush \
	+fsdb+no_warning \
	${TOP_TB} \
	-f ${CFG}

