import os
from music21 import *
import fnmatch
import matplotlib.pyplot as plt

path = "/Users/irisren/Dropbox/hanon"
path = "/Users/irisren/Dropbox/drumgen"
path = "/home/iris/Dropbox/hanon/midi"

plt.figure()
piecenum = 0
for root, dirs, files in os.walk(path):
    for CurrentFileName in files:
        address = os.path.join(root, CurrentFileName)
        pit=[]
        
        if fnmatch.fnmatch(CurrentFileName, "*.mid"):
            # with open(address, 'r') as CurrentFile:
            # fp = common.getSourceFilePath()
            print(CurrentFileName, "*.mid")

            mf = midi.MidiFile()
            mf.open(address)
            mf.read()
            s = midi.translate.midiFileToStream(mf)
            pitches = s.parts[0].pitches
            for p in range(-10, 10):
                print(p)
                pit=[]
                for pitch in pitches:
                    pit.append(int(pitch.midi) + p)
                plt.plot(pit, alpha = 0.5)
                # print(pit)
            mf.close()
            
            piecenum += 1

plt.savefig('hanontrans.png')
            