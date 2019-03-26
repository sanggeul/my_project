#!/bin/bash
#
# simulation script
#
# usage : symbolic link this file 
#
#             sim.boot.pre.fnc
#              ^   ^    ^   ^
#              |   |    |   +-- timing ( fnc, bst, wst )
#              |   |    +--- simulation level ( port, pre, rtl )
#           sticky  simulation name                   
#
#         symoblic link file name consists of four parts.
#         The first is a sticky string, "sim".
#         The second is a simulation name.
#         The second is a simulation level, which can be pre, post, etc.
#         The third is a simulation type, which can be rtl, wst, bst, etc
#

# project configuration
PROJECT=/nfshome/tcc8970/project/tcc8970
NS_seed=`date +%N`
echo ${NS_seed}

echo "arg:" $0
TEST=`basename $0`
DUV=`echo ${TEST}|cut -d . -f 2`
LEVEL=`echo ${TEST}|cut -d . -f 3`
TIMING=`echo ${TEST}|cut -d . -f 4`

SIMULATION=${DUV}.${LEVEL}.${TIMING}

LOG_BACKUP="0"
SRC_COMPILE="0" # testcode compile
IUS_VER="14.1"   # ius version select
LIB_CLEAR="0"
NO_SRC="0"
DSM_TRACE="ON"
PT_OPT=""       # Pass-throuh Options (apply to ncverilog)
DRAM_BUFFER_DEL="0"
LOG_GZIP="0" # Insert by tcc8910.sukhyun @ 2013-02-06_14:20:49
RERUN="0" # Insert by tcc8910.sukhyun @ 2013-06-19_14:39:07

[ -f "simconf" ] && source "simconf" && cat "simconf"
[ -f "${LEVEL}.simconf" ] && source "${LEVEL}.simconf" && cat "${LEVEL}.simconf"
[ -f "${LEVEL}.${TIMING}.simconf" ] && source "${LEVEL}.${TIMING}.simconf" && cat "${LEVEL}.${TIMING}.simconf"
[ -f "${DUV}.simconf" ] && source "${DUV}.simconf" && cat "${DUV}.simconf"
[ -f "${DUV}.${LEVEL}.simconf" ] && source "${DUV}.${LEVEL}.simconf" && cat "${DUV}.${LEVEL}.simconf"
[ -f "${DUV}.${LEVEL}.${TIMING}.simconf" ] && source "${DUV}.${LEVEL}.${TIMING}.simconf" && cat "${DUV}.${LEVEL}.${TIMING}.simconf"
#    cat "simconf"
#    source "${DUV}.simconf"
#    cat "${DUV}.simconf"

#    source "${DUV}.${LEVEL}.simconf"
#    cat "${DUV}.${LEVEL}.simconf"

OPTION=""
PLUGIN=""

while getopts "RsctbSCTBv:r:o:zZ" opt;do
    case ${opt} in
        s ) SRC_COMPILE="1";;
        c ) LIB_CLEAR="1";;
        t ) NO_SRC="1";;
        b ) DRAM_BUFFER_DEL="1";;
        S ) SRC_COMPILE="0";;
        C ) LIB_CLEAR="0";;
        T ) NO_SRC="0";;
        B ) DRAM_BUFFER_DEL="0";;
        v ) IUS_VER="${OPTARG}";;
        r ) DSM_TRACE=`echo "${OPTARG}" | tr '[a-z]' '[A-Z]'`;;
        o ) PT_OPT="${PT_OPT} ${OPTARG}";;
        z ) LOG_GZIP="1";; # Insert by tcc8910.sukhyun @ 2013-02-06_14:20:56
        Z ) LOG_GZIP="0";; # Insert by tcc8910.sukhyun @ 2013-02-06_14:20:56
        R ) LIB_CLEAR="0";RERUN="1";; # Insert by tcc8910.sukhyun @ 2013-06-19_14:39:28
    esac
done
IUS_VER=`echo "${IUS_VER}" | sed -e "s/\.//"`

OPTION="${OPTION} +define+IUS${IUS_VER}"
OPTION="${OPTION} +licq"

if [ -e "${PROJECT}/00.common/env/ius${IUS_VER}.sh"  ];then
    source ${PROJECT}/00.common/env/ius${IUS_VER}.sh
elif [ -e "${HOME}/.myenv/ius${IUS_VER}.sh"  ];then
    source ${HOME}/.myenv/ius${IUS_VER}.sh
else
    echo "Error - [IUS_VER] Invalid Option!"
    FILES=`ls ${PROJECT}/00.common/env/ius*.sh | sed -e "s/ius//"`
    VERS=""
    for FILE in ${FILES};do
        DISP=`basename ${FILE%.*}`
        VERS="${VERS} `printf "%2d.%01d " $(($DISP/10)) $(($DISP%10))`"
    done
    VERS=`echo "${VERS}" | tr " " "\n" | sort -nu | tr "\n" " " | sed -e "s/\.[0-9] /&\/ /g"`
    echo "Valid Options = ${VERS}"
    exit 1
fi

if [ "${DSM_TRACE}" == "ON" ];then
     source    ${PROJECT}/00.common/env/ARMDSM.sh
else
     source    ${PROJECT}/00.common/env/ARMDSM.tarmac_off.sh
fi
# /nfshome/tcc8970/project/tcc8970/00.common/env/ARMDSM.sh

mkdir -p dump
mkdir -p log
mkdir -p log/autobackup

CFG="vlg.arg"

case "${LEVEL}" in
    "dft")
        TOP_NET_FILE="+define+TOP_NET_FILE=\"./inc/dft/dftnet.v\""
        OPTION="${OPTION} +fsdb+writer_mem_limit=2048" # 4~2048 MB // Insert by tcc8970.sukhyun @ 2014-07-15_14:47:54
        CFG="vlg.dft.arg"
        if [ ${TIMING} == "fnc" ]; then
            OPTION="${OPTION} +notimingchecks"
            OPTION="${OPTION} +define+PRE_NETLIST_SIM +define+FF_NO_X_OUT +define+ForcedX_VAL=0"
        else
            OPTION="${OPTION} +nctfile+./tfile/tfile.pre.list"
        fi
        STI_FILE="${SIMULATION}.v"
        ;;
    "rtl") 
        TOP_NET_FILE="+define+TOP_NET_FILE=\"./inc/rtl/rtl_list.v\""
        STI_FILE="${SIMULATION}.v"
        CFG="vlg.rtl.arg"
        ;;
    "rtlaf") 
        TOP_NET_FILE="+define+TOP_NET_FILE=\"./inc/rtl/rtl_list.v\""
        STI_FILE="${DUV}.rtl.${TIMING}.v ./satest2/${DUV}/rtl/${DUV}.rtl.sti"
        OPTION="${OPTION} +define+BACK_ANNOTATION +define+RTL"
        CFG="vlg.rtlaf.arg"
        ;;
    "pre"   )
        TOP_NET_FILE="+define+TOP_NET_FILE=\"./inc/pre/prenet.v\""
        OPTION="${OPTION} +fsdb+writer_mem_limit=2048" # 4~2048 MB // Insert by tcc8970.sukhyun @ 2014-07-15_14:47:54
        CFG="vlg.post.arg"
        if [ ${TIMING} == "fnc" ]; then
            OPTION="${OPTION} +notimingchecks"
            OPTION="${OPTION} +define+PRE_NETLIST_SIM +define+FF_NO_X_OUT +define+ForcedX_VAL=0"
        else
            OPTION="${OPTION} +ncsdf_nocheck_celltype" # Insert by tcc8970.sukhyun @ 2015-03-03_14:59:48
            OPTION="${OPTION} +nctfile+./tfile/tfile.pre.list"
        fi
        STI_FILE="${SIMULATION}.v"
        ;;
    "post"  )
        TOP_NET_FILE="+define+TOP_NET_FILE=\"./inc/post/postnet.v\""
        OPTION="${OPTION} +fsdb+writer_mem_limit=2048" # 4~2048 MB // Insert by tcc8970.sukhyun @ 2014-07-15_14:47:54
        CFG="vlg.post.arg"
        if [ ${TIMING} == "fnc" ]; then
            OPTION="${OPTION} +notimingchecks"
        else
            # -- +ncsdf_nocheck_celltype    Do not check the accuracy of CELLTYPE field
            #OPTION="${OPTION} +nospecify"
            OPTION="${OPTION} +ncsdf_nocheck_celltype" # Insert by tcc8970.sukhyun @ 2015-03-03_14:59:48
            OPTION="${OPTION} +pulse_e/0 +pulse_r/0 +ncpulse_e/0 +ncpulse_r/0"
            OPTION="${OPTION} +nctfile+./tfile/tfile.post.list"
        fi
        #//------\/--------  Insert by tcc8910.sukhyun @ 2012-12-21_14:27:42  --------\/--------
        # pre-compiled SDF
        #SDF_COMMON_PATH="/nfshome/tcc8970/project/tcc8970/08.release/post/final/compiled_sdf"
        #SDFS=`ls ${SDF_COMMON_PATH}/*.X`
        #for SDF in ${SDFS};do
        #    BNAME_SDF=`basename "${SDF}"`
        #    [ ! -e "${BNAME_SDF}" ] && ln -s "${SDF}" .
        #done
        #//------/\--------  Insert by tcc8910.sukhyun @ 2012-12-21_14:27:42  --------/\--------
        STI_FILE="${SIMULATION}.v"
        ;;
    * ) echo "Error!"; exit 1;;
esac

for STI in ${STI_FILE};do
    if [ ! -f "${STI}" ];then
        echo "Simulation Constraint file not found! - ${STI}"
        exit 1
    fi
done

# XIN_PERIOD Check
#XIN_PERIOD=`sed -n -e '/^\`define/p' ${STI_FILE} | grep XIN_PERIOD | awk '{ print $3 }'`
#if [ "${XIN_PERIOD}" != "41.667" ] && [ "${XIN_PERIOD}" != "42.000" ] && [ "${XIN_PERIOD}" != "" ];then
#    echo "Error! XIN_PERIOD is neither 41.667 nor 42.000 ! (${XIN_PERIOD}) Please check ${STI_FILE} file!"
#    exit 1
#fi

if [ "${SRC_COMPILE}" == "1" ];then
    pushd "src.${DUV}/m4_src/srcs" &> /dev/null
    :run_make || exit
    if [ ! -f "../bin/project.elf" ];then
        echo "================================================================================"
        echo "                      CM4 Source Code Compile FAILED!!"
        echo "================================================================================"
        exit 1
    fi
    popd &> /dev/null
fi

#/----------------------------------------
if [ ${TIMING} == "wst" ]; then
    OPTION="${OPTION} +neg_tchk"
    OPTION="${OPTION} +ncneg_tchk"
    OPTION="${OPTION} +ncmaxdelays"
    OPTION="${OPTION} +maxdelays"
elif [ ${TIMING} == "bst" ]; then
    OPTION="${OPTION} +neg_tchk"
    OPTION="${OPTION} +ncneg_tchk"
    OPTION="${OPTION} +ncmindelays"
    OPTION="${OPTION} +mindelays"
elif [ ${TIMING} == "fnc" ]; then
    OPTION="${OPTION} +functional_mode"
fi
#\----------------------------------------

#/----------------------------------------
# define & check rom files
if [ -d "src.${DUV}" ];then
    if [ -f "src.${DUV}/rom/rom64x0.dat" ];then
        ROMDEFINES="\
			+define+CM_ROM=\"src.${DUV}/m4_src/rom/rom32.dat\"\
            +define+CM_ROM_L=\"src.${DUV}/m4_src/rom/rom64x0.dat\" \
            +define+CM_ROM_H=\"src.${DUV}/m4_src/rom/rom64x1.dat\" \
            +define+ROMFILE_L=\"src.${DUV}/rom/rom64x0.dat\"\
            +define+ROMFILE_H=\"src.${DUV}/rom/rom64x1.dat\"\
            +define+TROMFILE_L=\"src.${DUV}/rom/rom64x0.dat\"\
            +define+TROMFILE_H=\"src.${DUV}/rom/rom64x1.dat\"\
            +define+TROMFILE=\"src.${DUV}/rom/rom32.dat\"\
            +define+TRAMFILE_L=\"src.${DUV}/rom/rom64x0.dat\"\
            +define+TRAMFILE_H=\"src.${DUV}/rom/rom64x1.dat\"\
		    +define+TRAM_SIZE=`wc -l src.${DUV}/rom/rom64x0.dat | awk '{ print $1 }'` \
            +define+MONFILE=\"src.${DUV}/out/project.sym\"\
            "
    elif [ -f "src.${DUV}/out/rom/8970boot0.dat" ];then
        #bootcode
        ROMDEFINES="\
			+define+CM_ROM=\"src.${DUV}/m4_src/rom/rom32.dat\"\
            +define+CM_ROM_L=\"src.${DUV}/m4_src/rom/rom64x0.dat\" \
            +define+CM_ROM_H=\"src.${DUV}/m4_src/rom/rom64x1.dat\" \
            +define+ROMFILE_L=\"src.${DUV}/out/rom/8935boot0.dat\"\
            +define+ROMFILE_H=\"src.${DUV}/out/rom/8935boot1.dat\"\
            +define+TROMFILE_L=\"src.${DUV}/rom/rom64x0.dat\"\
            +define+TROMFILE_H=\"src.${DUV}/rom/rom64x1.dat\"\
            +define+TROMFILE=\"src.${DUV}/rom/rom32.dat\"\
            +define+TRAMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+TRAMFILE_H=\"src/rom/rom64x1.dat\"\
		    +define+TRAM_SIZE=`wc -l src.cmbus/src.${DUV}/rom/rom64x0.dat | awk '{ print $1 }'` \
            +define+MONFILE=\"src.${DUV}/out//rom/8935boot.sym\"\
            "
    else
        if [ "${NO_SRC}" == "0" ] && [ "${LEVEL}" != "after" ];then
            echo "src.duv ROMFILE not found!"
            exit 1
        else
            ROMDEFINES="\
                +define+ROMFILE_L=\"\"\
                +define+ROMFILE_H=\"\"\
                +define+TROMFILE_L=\"\"\
                +define+TROMFILE_H=\"\"\
                +define+TROMFILE=\"\"\
                +define+TRAMFILE_L=\"\"\
                +define+TRAMFILE_H=\"\"\
                +define+TRAM_SIZE=0\
                +define+MONFILE=\"\"\
                "
        fi
    fi
elif [ -d "src" ];then
    if [ -f "src/rom/rom64x0.dat" ];then
        ROMDEFINES="\
            +define+ROMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+ROMFILE_H=\"src/rom/rom64x1.dat\"\
            +define+TROMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+TROMFILE_H=\"src/rom/rom64x1.dat\"\
            +define+TROMFILE=\"src/rom/rom32.dat\"\
            +define+TRAMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+TRAMFILE_H=\"src/rom/rom64x1.dat\"\
		    +define+TRAM_SIZE=`wc -l src/rom/rom64x0.dat | awk '{ print $1 }'` \
            +define+MONFILE=\"src/out/project.sym\"\
            "
    elif [ -f "src/out/rom/8935boot0.dat" ];then
        #bootcode
        ROMDEFINES="\
            +define+ROMFILE_L=\"src/out/rom/8935boot0.dat\"\
            +define+ROMFILE_H=\"src/out/rom/8935boot1.dat\"\
            +define+TROMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+TROMFILE_H=\"src/rom/rom64x1.dat\"\
            +define+TROMFILE=\"src/rom/rom32.dat\"\
            +define+TRAMFILE_L=\"src/rom/rom64x0.dat\"\
            +define+TRAMFILE_H=\"src/rom/rom64x1.dat\"\
		    +define+TRAM_SIZE=`wc -l src/rom/rom64x0.dat | awk '{ print $1 }'` \
            +define+MONFILE=\"src/out//rom/8935boot.sym\"\
            "
    else
        if [ "${NO_SRC}" == "0" ] && [ "${LEVEL}" != "after" ];then
            echo "src ROMFILE not found!"
            exit 1
        else
            ROMDEFINES="+define+ROMFILE_L=\"\" +define+ROMFILE_H=\"\" +define+TROMFILE_L=\"\" +define+TROMFILE_H=\"\" +define+TROMFILE=\"\" +define+TRAMFILE_L=\"\" +define+TRAMFILE_H=\"\" +define+TRAM_SIZE=0 +define+MONFILE=\"\""
        fi
    fi
else
    if [ "${NO_SRC}" == "0" ] && [ "${LEVEL}" != "after" ];then
        echo "Source Dir not found!"
        exit 1
    else
        ROMDEFINES="+define+ROMFILE_L=\"\" +define+ROMFILE_H=\"\" +define+TROMFILE_L=\"\" +define+TROMFILE_H=\"\" +define+TROMFILE=\"\" +define+TRAMFILE_L=\"\" +define+TRAMFILE_H=\"\" +define+TRAM_SIZE=0 +define+MONFILE=\"\""
    fi
fi
#\----------------------------------------

#/----------------------------------------
# define dump file name
DUMPDEFINS="+define+DUMP_FILE=\"./dump/${DUV}.${LEVEL}.${TIMING}.fsdb\""
if [ -f "./dump.${DUV}.v" ];then
    DUMPDEFINS="${DUMPDEFINS} +define+DUMP_MODULE=\"./dump.${DUV}.v\""
elif [ -f "./inc/dump.${DUV}.v" ];then
    DUMPDEFINS="${DUMPDEFINS} +define+DUMP_MODULE=\"./inc/dump.${DUV}.v\""
elif [ -f "./dump.v" ];then
    DUMPDEFINS="${DUMPDEFINS} +define+DUMP_MODULE=\"./dump.v\""
elif [ -f "./inc/dump.v" ];then
    DUMPDEFINS="${DUMPDEFINS} +define+DUMP_MODULE=\"./inc/dump.v\""
else
    echo "Error! Dump Module not found!"
    exit 1
fi
#\----------------------------------------

#/----------------------------------------
# 
SIMLEVEL="+define+`echo ${LEVEL} | tr '[:lower:]' '[:upper:]'`"
SIMTIMING="+define+`echo ${TIMING} | tr '[:lower:]' '[:upper:]'`"
SIMDUV="+define+`echo ${DUV} | tr '[:lower:]' '[:upper:]'`"
#\----------------------------------------

#/----------------------------------------
# compile library dir
LIBDIR="libs_${SIMULATION}"
mkdir -p ${LIBDIR}
#\----------------------------------------

#/----------------------------------------
# Level specific forcing
FORCE="./force/${LEVEL}/force.v"
if [ ! -f "${FORCE}" ];then
    echo "Error! - File (${FORCE}) not found!"
    exit 1
fi
#\----------------------------------------

#------\/--------  Insert by tcc8910.sukhyun @ 2013-02-08_14:03:58  --------\/--------
# Log File Backup
if [ -e "./log/${SIMULATION}.log" ];then
    LOG_DATE=`stat -c %y "./log/${SIMULATION}.log" | cut -d. -f 1 | awk '{print $1 "_" $2}'`
    mv "./log/${SIMULATION}.log" "./log/autobackup/${SIMULATION}.${LOG_DATE}.log"
    gzip "./log/autobackup/${SIMULATION}.${LOG_DATE}.log" &   # background job - gzip
elif [ -e "./log/${SIMULATION}.log.gz" ];then
    LOG_DATE=`stat -c %y "./log/${SIMULATION}.log.gz" | cut -d. -f 1 | awk '{print $1 "_" $2}'`
    mv "./log/${SIMULATION}.log.gz" "./log/autobackup/${SIMULATION}.${LOG_DATE}.log.gz"
fi
#------/\--------  Insert by tcc8910.sukhyun @ 2013-02-08_14:03:58  --------/\--------

export eis_dont_generate=1
#OPTION="${OPTION} +nowarn+AFASBT +nowarn+SDFNEP +nowarn+SDFNSB +nowarn+NTCNNC +nowarn+SDFNDP +nowarn+SDFNET +nowarn+SDFANS" # Insert by tcc8910.sukhyun @ 2013-02-06_12:36:41

#------\/--------  Insert by tcc8970.sukhyun @ 2014-07-15_14:52:43  --------\/--------
# NOVAS options
# +fsdb+autoflush   # Enable the automatic flush function when the simulation is stopped with the $stop dumping command or by pressing the Ctrl-C key.
OPTION="${OPTION} +fsdb+autoflush"
# +fsdb+no_warning  # Filter the warning message.
OPTION="${OPTION} +fsdb+no_warning"
# +fsdb+dump_log[=on|off]   # Enable/disable novas_dump.log. The default is on.
OPTION="${OPTION} +fsdb+dump_log=off"
# +fsdb+writer_mem_limit=num    # Specify the limit for the FSDB writer to flush value changes in memory.
#OPTION="${OPTION} +fsdb+writer_mem_limit=2048"
#------/\--------  Insert by tcc8970.sukhyun @ 2014-07-15_14:52:43  --------/\--------

export  display_unit=NS # Insert by sukhyun @ 2014-04-03_22:56:33

if [ "${RERUN}" == "1" ];then
    OPTION="${OPTION} -R"
fi

PLUGIN=""

#${NCVERILOG} \
        #+delay_mode_distributed \
        #+notimingcheck \
        #+define+DWC_ADD_PHY_DELAY \

CM_ROM=src.${DUV}/m4_src/rom/rom32.dat
echo ${CM_ROM}
cmrom_size=`wc ${CM_ROM} -l | cut -d " " -f 1`
echo ${cmrom_size}

ncverilog \
	+define+SEED="${NS_seed}" \
	+define+CMROM_SIZE="${cmrom_size}" \
    +nc64bit \
    +access+r \
    +ncnokey \
    +define+check_dbgen_out \
    +define+SIMULATION=\"${SIMULATION}\" \
    +nclibdirname+${LIBDIR} \
    -l ./log/${SIMULATION}.log \
    +mixedlang \
    +fsdb+autoflush \
    +fsdb+no_warning \
    ${ARMPLI} \
    ${M4PLI} \
    ${verdi_pli} \
    ${OPTION} \
    ${PLUGIN} \
    ${SIMLEVEL} \
    ${SIMDUV} \
    ${SIMTIMING} \
    ${DUMPDEFINS} \
    ${ROMDEFINES} \
    ${STI_FILE} \
    -f ${CFG} \
    ${FORCE} \
    ${TOP_NET_FILE} \
    ${PT_OPT}

echo "Simulation @ `hostname`" >> ./log/${SIMULATION}.log

if [ "${LIB_CLEAR}" == "1" ];then
    sleep 1;rm -rf "./${LIBDIR}"
fi
#------\/--------  Insert by tcc8910.sukhyun @ 2013-02-06_14:21:09  --------\/--------
if [ "${LOG_GZIP}" == "1" ];then
    sleep 1;gzip -v "./log/${SIMULATION}.log"
fi
#------/\--------  Insert by tcc8910.sukhyun @ 2013-02-06_14:21:09  --------/\--------
#rm -rf ./INCA_libs
#rm *.log
