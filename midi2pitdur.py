import os
from music21 import *
import fnmatch
import matplotlib.pyplot as plt

path = "/Users/irisren/Dropbox/hanon"
path = "/Users/irisren/Dropbox/drumgen"
path = "/home/iris/Dropbox/hanon"

piecenum = 0
for root, dirs, files in os.walk(path):
    for CurrentFileName in files:
        address = os.path.join(root, CurrentFileName)
        pit=[]
        
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
            print(pit)
            mf.close()

            plt.figure()
            plt.plot(pit)
            plt.savefig('drum{0}'.format(piecenum))
            piecenum += 1