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

allpit = []
piecenum = 0
for root, dirs, files in os.walk(path):
    for CurrentFileName in files:
        address = os.path.join(root, CurrentFileName)
        pit = []

        if fnmatch.fnmatch(CurrentFileName, "*.mid"):
            # with open(address, 'r') as CurrentFile:
            # fp = common.getSourceFilePath()

            mf = midi.MidiFile()
            mf.open(address)
            mf.read()
            s = midi.translate.midiFileToStream(mf)
            pitches = s.parts[0].pitches
            for pitch in pitches:
                pit.append(pitch.midi)
            # print(pit)
            mf.close()
            allpit.append(pit)

rulepitlens = []
ruledurlens=[]
rulepitdurlens=[]

patpitlens=[]
patdurlens=[]
patpitdurlens=[]
#20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
for sup in [30,29,28,27,26,25,24,23,22]:
    print(sup)

    relim_input = itemmining.get_relim_input(allpit)
    print(relim_input)
    item_sets = itemmining.relim(relim_input, min_support=sup)
    # print(item_sets)
    rules = assocrules.mine_assoc_rules(item_sets, min_support=2, min_confidence=0.5)
    with open("Assocpic_{}.txt".format(sup),"w") as assocpitresults:
        assocpitresults.write("this many:"+str(len(rules)))
        assocpitresults.write(str(rules))
    rulepitlens.append(len(rules))

    # print(nonsense)
    # relim_input = itemmining.get_relim_input(durfam)
    # item_sets = itemmining.relim(relim_input, min_support=sup)
    # rules = assocrules.mine_assoc_rules(item_sets, min_support=2, min_confidence=0.5)
    # with open("Assocdur_{}.txt".format(sup),"w") as assocdurresults:
    #     assocdurresults.write("this many:" + str(len(rules)))
    #     assocdurresults.write(str(rules))
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
    #
    allpat = seqmining.freq_seq_enum(allpit, sup)
    print(allpat)
    with open("Freqpit_{}.txt".format(sup),"w") as freqresults:
        freqresults.write("this many:" + str(len(allpat)))
        freqresults.write(str(allpat))
    patdurlens.append(len(allpat))


    # allpat = seqmining.freq_seq_enum(durfam, sup)
    # with open("Freqdur_{}.txt".format(sup),"w") as freqresults:
    #     freqresults.write("this many:" + str(len(allpat)))
    #     freqresults.write(str(allpat))
    # patpitdurlens.append(len(allpat))

import matplotlib.pyplot as plt
plt.figure()
plt.plot(rulepitdurlens)
plt.plot(ruledurlens)
plt.plot(rulepitlens)
plt.savefig('statsrule.png')

plt.figure()
plt.plot(patpitdurlens)
plt.plot(patpitlens)
plt.plot(patpitdurlens)
plt.savefig('statspat.png')