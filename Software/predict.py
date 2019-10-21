import sys

coeff=[16.3896,-32.8087,19.2099,5.2441,-327.3249,68.2131]
intercept=-160.7405
effic=0.0

for i in range(0,6):
	effic+=coeff[i]*float(sys.argv[i+1])

effic+=intercept
print effic
