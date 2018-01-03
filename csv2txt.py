import csv
from fractions import Fraction
import re
for i in range(1,10):
	with open('iris_point_sets/Hanon {0}.csv'.format(i), 'rb') as f:
		with open("hanon{0}.txt".format(i), "w") as text_file:
			reader = csv.reader(f, delimiter=',', quoting=csv.QUOTE_NONE)
			for row in reader:
				num1 = str(Fraction(row[0]))
				num2 = str(Fraction(row[1]))
				num3 = str(Fraction(row[2]))
				num4 = str(Fraction(row[3]))
				num5 = str(Fraction(row[4]))
				nums1 = " ".join([num1, num2, num3, num4, num5])

				nums = tuple((num1,num2,num3,num4,num5))
				num1 = re.sub("'",'',nums1)
				print(nums1)
				text_file.write('('+str(num1)+')'+'\n')
