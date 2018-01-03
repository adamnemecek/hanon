import fnmatch
import os
from pymining import seqmining
from pymining import assocrules, itemmining

from music21 import *
import fnmatch

path = "/Users/irisren/Dropbox/drumgen"
path = "C:/Users/admin_local/Dropbox/drumgen"
path = "C:/Users/admin_local/Dropbox/hanon"
# path = "/Users/irisren/Dropbox/hanon"
path = "/home/iris/Dropbox/hanon/midi"
# path = "/home/iris/hanon/midi"

allpit = []
piecenum = 0
for root, dirs, files in os.walk(path):
    for CurrentFileName in files:
        address = os.path.join(root, CurrentFileName)
	print(CurrentFileName)
        pit = []

        if fnmatch.fnmatch(CurrentFileName, "*.mid"):
            # with open(address, 'r') as CurrentFile:
            # fp = common.getSourceFilePath()

            mf = midi.MidiFile()
            mf.open(address)
            mf.read()
            s = midi.translate.midiFileToStream(mf)
            pitches = s.parts[0].pitches

            for p in range(0, 1):
                print(p)
                pit=[]
                for pitch in pitches:
                    pit.append(int(pitch.midi) + p)
                allpit.append(pit)
            mf.close()
            
	    piecenum += 1
	    if piecenum >= 1:
		break
rulepitlens = []
ruledurlens=[]
rulepitdurlens=[]

patpitlens=[]
patdurlens=[]
patpitdurlens=[]

itempitlens=[]

inputlist = []
print(allpit[0])
# print(nonsense)
for N in range(1, len(allpit[0])):
    print("N="+str(N)+"=========================")
    grams = [allpit[0][i:i+N] for i in xrange(len(allpit[0])-N)]
    # print(grams)
    # gramsstring = [str(x)[1:-1] for x in grams]
    # print(gramsstring)
    # print(len(gramsstring))
    for things in grams:
        inputlist.append(things)

    print("input item counts:"+str(len(inputlist)))
    # for inputentry in inputlist:
    #     print(inputentry)
    # print(inputlist)
    #20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
    # ,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2
    for sup in [30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2]:
        # print(sup)


        relim_input = itemmining.get_relim_input(inputlist)
        # print("length relim_input:" + str(len(relim_input)))
        # for item in relim_input:
        #     print("length item:"+str(len(item)))
            # print(item)
        item_sets = itemmining.relim(relim_input, min_support=sup)
        # print("length item_sets:"+str(len(item_sets)))
        itempitlens.append(len(item_sets))
        # print(item_sets)

        rules = assocrules.mine_assoc_rules(item_sets, min_support=sup, min_confidence=0)

        # print(len(rules))
        # print((rules))
        rulepitlens.append(len(rules))

        # print(nonsense)
        # relim_input = itemmining.get_relim_input(durfam)
        # item_sets = itemmining.relim(relim_input, min_support=sup)
        # rules = assocrules.mine_assoc_rules(item_sets, min_support=2, min_confidence=0.5)
        #with open("Assocpit_{}.txt".format(sup),"w") as assocresults:
        #    assocresults.write("this many:" + str(len(rules)))
        #    assocresults.write(str(rules))
        # ruledurlens.append(len(rules))
        #
        # relim_input = itemmining.get_relim_input(pitdurfam)
        # item_sets = itemmining.relim(relim_input, min_support=sup)
        # rules = assocrules.mine_assoc_rules(item_sets, min_support=2, min_confidence=0.5)
        # with open("Assocpair_{}.txt".format(sup),"w") as assocpairresults:
        #     assocpairresults.write("this many:" + str(len(rules)))
        #     assocpairresults.write(str(rules))
        # rulepitdurlens.append(len(rules))

        # allpat = seqmining.freq_seq_enum(oneFamily, sup)
        # allpat  = seqmining.freq_seq_enum(pitdurfam, sup)
        # with open("Freq_{}.txt".format(sup),"w") as freqresults:
        #     freqresults.write("this many:" + str(len(allpat)))
        #     freqresults.write(str(allpat))
        # patpitlens.append(len(allpat))
        
        chrinputlist = []
        for pitlist in inputlist:
            chrinputlist.append("".join([chr(x) for x in pitlist]))
        # print(chrallpit)

        allpat = seqmining.freq_seq_enum(chrinputlist, sup)
        # print("length allpat:"+str(len(allpat)))
        # print(allpat)
        patpitlens.append(len(allpat))

        # allpat = seqmining.freq_seq_enum(durfam, sup)
        # with open("Freqpit_{}.txt".format(sup),"w") as freqresults:
        #     freqresults.write("this many:" + str(len(allpat)))
        #     freqresults.write(str(", ".join([[ord(x) for x in strings] for strings in allpat])))
        # patpitdurlens.append(len(allpat))

import numpy as np
print(len(patpitlens))
# print(len(patpitlens)/26)
print(len(allpit))
itemmatrix = np.array(itempitlens).reshape(len(allpit)-1,29)
print(itemmatrix).shape
rulematrix = np.array(rulepitlens).reshape(len(allpit)-1,29)
freqmatrix = np.array(patpitlens).reshape(len(allpit)-1,29)

import matplotlib.pyplot as plt
plt.figure()
plt.imshow(itemmatrix)
plt.colorbar()
plt.savefig('itemmatrix.png')

plt.figure()
plt.imshow(rulematrix)
plt.colorbar()
plt.savefig('rulematrix.png')

plt.figure()
plt.imshow(freqmatrix)
plt.colorbar()
plt.savefig('freqmatrix.png')
print(nonsense)


import matplotlib.pyplot as plt
plt.switch_backend('agg')

plt.figure()
# plt.plot(rulepitdurlens)
# plt.plot(ruledurlens)
plt.plot(itempitlens)
plt.savefig('statsitem.png')

plt.figure()
# plt.plot(rulepitdurlens)
# plt.plot(ruledurlens)
plt.plot(rulepitlens)
plt.savefig('statsrule.png')

plt.figure()
# plt.plot(patpitdurlens)
plt.plot(patpitlens)
# plt.plot(patpitdurlens)
plt.savefig('statspat.png')
