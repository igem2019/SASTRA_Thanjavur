#!/bin/bash

if [ $# -lt 2 ]; then echo "Provide the sequences of both toehold switch and trigger"; exit; fi

COL='\033[0;36m'
NC='\033[0m'

switch_seq=$(awk '/>/{nr[NR+1]}; NR in nr' $1)
trig=$(awk '/>/{nr[NR+1]}; NR in nr' $2)

fold=( $(RNAfold $1) )
switch_mfe=$(RNAfold $1 | grep -oP "\-\d{1,2}\.\d{1,2}")

echo -e "$COL Toehold switch sequence: $NC $switch_seq"
echo -e "$COL Trigger sequence: $NC $trig" 
echo -e "$COL Dot-bracket Notation: $NC ${fold[2]}"

trig_mfe=$(RNAfold $2| grep -oP "\-\d{1,2}\.\d{1,2}")
dimer_mfe=$(python domain_parser.py $switch_seq ${fold[2]} $trig | RNAcofold | grep -oP "\-\d{1,2}\.\d{1,2}")

net_mfe=`echo $switch_mfe + $trig_mfe - $dimer_mfe| bc`

rbs_linker_mfe=$(python domain_parser.py $switch_seq ${fold[2]} 1 | RNAfold | grep -oP "\-\d{1,2}\.\d{1,2}")
bottom_reg_mfe=$(python domain_parser.py $switch_seq ${fold[2]} 2 | RNAcofold | grep -oP "\-\d{1,2}\.\d{1,2}")

freq_in_ensembl=$(RNAfold -p --MEA $1| grep -oP "ensemble\s\K\d{1,}\.\d{1,}")

sp_heat=$(RNAheat --Tmin=37 --Tmax=37 $1| grep -oP "\s\K\d{1,}\.\d{1,}")

effi=$(python predict.py $switch_mfe $bottom_reg_mfe $rbs_linker_mfe $net_mfe $freq_in_ensembl $sp_heat)
echo -e "$COL Predicted ON/OFF ratio: $NC $effi"
