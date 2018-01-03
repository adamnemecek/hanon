inputpath = "C:/Users/admin_local/Dropbox/2017Pattern/MeredithTLF1MIREX2016/hanon/"

import os
import matplotlib.pyplot as plt
import patutils
import numpy

# rootdir = '/Users/irisren/Dropbox/PatternJ/data'
# rootdir =  "C:\Users/admin_local\Dropbox\PatternJ/data".replace("\\","/")

plt.figure()
height = 50
for subdir, dirs, files in os.walk(inputpath):
    for file in files:
        if file[-4:] == "tlf1":
            print os.path.join(os.path.join(subdir, file))
            s = open(os.path.join(subdir, file))

            startendpat = patutils.outputtimes(s.readlines())

            c=numpy.random.rand(3,)
            for patterns in startendpat:
                height = height + 10
                for occur in patterns:
                    plt.plot((occur[0], occur[1]), (height, height), color = c, lw=2, alpha=0.5)
            plt.plot((0,0), (0,0), color=c, label=subdir[-5:])

plt.xlabel('Time')
plt.legend(loc='best')
plt.title('Visualisation')
plt.tight_layout()
# plt.show()
plt.savefig('vis.png')