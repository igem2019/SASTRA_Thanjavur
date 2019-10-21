import re
import sys

bs_seq=sys.argv[1]
db_seq=sys.argv[2]

rbs_linker=""

dom = re.match('^([\.\(\)?]*)(\({9,})([\.\.?\(?\.?]{3})(\({5,6}\.?)(\.*)(\){5,6})([\.\.?\)?\.?]{3})(\).*)(\.[\.\(\)]*)$', db_seq)
#regular expression match for domains based on grammar of toehold switch
  
toehold_domain_seq = bs_seq[dom.start(1):dom.end(1)]
stemb_asc_seq = bs_seq[dom.start(2):dom.end(2)]
stemb_desc_seq = bs_seq[dom.start(8):dom.end(8)]
horizontal_linker_domain_seq = bs_seq[dom.start(9):dom.end(9)]

for i in range(5,10):
	rbs_linker+=bs_seq[dom.start(i):dom.end(i)]

bottom_reg=toehold_domain_seq+stemb_asc_seq+'&'+stemb_desc_seq+horizontal_linker_domain_seq
if (sys.argv[3]=='1'):
	print rbs_linker
elif (sys.argv[3]=='2'):
	print bottom_reg
else:
	print bs_seq+'&'+sys.argv[3]

