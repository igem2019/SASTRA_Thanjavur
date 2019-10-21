import sys

coeff=[16.5035,-32.7378,19.2554,5.3538,-294.238,68.5986]
intercept=-163.3120
effic=0.0

for i in range(0,6):
	effic+=coeff[i]*float(sys.argv[i+1])

effic+=intercept
print effic
