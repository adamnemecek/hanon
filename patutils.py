from __future__ import division
import numpy
from fractions import Fraction

def fromLisptoTuple(text):
    pitchlist = []
    timelist = []
    durlist = []
    for line in text:
        nums = line.split()
        pitch = nums[1]
        time = float(Fraction(nums[0][1:]))
        dur = float(Fraction(nums[3]))
        pitchlist.append(pitch)
        timelist.append(time)
        durlist.append(dur)
    return timelist, pitchlist, durlist

def outputtimes(text):
    pitches=[]
    pairs=[]
    occurtimes=[]
    pattimes=[]
    times=[]
    total=[]
    for line in text:
        if "," in line:
            pairs.append([float(i) for i in line.split(',')])
            total.append([float(i) for i in line.split(',')])

        if "o" in line:
            total.append('o')
            if pairs != []:
                times=zip(*pairs)[0]
                occurtimes.append(times)
                pairs=[]

        if "p" in line:
            total.append('p')
            pattimes.append(occurtimes)
            # print(len(occurtimes))
            occurtimes=[]

    # print(total)

    olist=[]
    plist=[]
    for index in range(0,len(total)):
        item = total[index]
        if item == 'p':
            plist.append(index)
        if item == 'o':
            olist.append(index)

    occurtimes=[]
    pattimes=[]
    record=0
    for pindex in range(1,len(plist)):
        for oindex in range(0,len(olist)-1):
            if plist[pindex]-olist[oindex+1]>1 and oindex>=record:
                occurtimes.append(zip(*total[olist[oindex]+1:olist[oindex+1]])[0])
            if plist[pindex]-olist[oindex+1]==-1:
                occurtimes.append(zip(*total[olist[oindex]+1:olist[oindex+1]-1])[0])
                record=oindex+1
                # print(record)
        sub=[]
        pattimes.append(occurtimes)
        occurtimes=[]

    # print(olist)
    # print(plist)
    # print(plist)
    # print(len(plist))
    if len(plist) == 0:
        return []

    pindex=plist[-1]
    occurtimes=[]
    for oindex in range(0,len(olist)-1):
        if olist[oindex]>pindex:
            occurtimes.append(zip(*total[olist[oindex]+1:olist[-1]])[0])


    oindex=olist[-1]
    occurtimes.append(zip(*total[oindex+1:])[0])
    pattimes.append(occurtimes)

    # print(pattimes[1])
    # taking the onset and offset
    startend=[]
    startendpat=[]
    for occtime in pattimes:
        for time in occtime:
            start=time[0]
            end=time[-1]
            startend.append([start,end])
        startendpat.append(startend)
        startend=[]
    # print(startendpat[-1])
    return startendpat

def getDist(startendpat, reso):
    import numpy
    flattened_list = [y for x in startendpat for y in x]

    if flattened_list == []:
        print("no pattern")
        return []

    if type(flattened_list[0]) is not float:
        startflat = list(zip(*flattened_list))[0]
        endflat = list(zip(*flattened_list))[1]
    else:
        startflat = flattened_list[0:][::2]
        endflat = flattened_list[1:][::2]
    totallist = []
    totallist = totallist + flattened_list
    totalstartlist = []
    totalstartlist = totalstartlist + list(startflat)
    totalendlist = []
    totalendlist = totalendlist + list(endflat)

    dist = {}
    print(totalendlist)
    for time in [x * reso for x in range(0, int(max(totalendlist)))]:
        dist[time] = 0
        for j in range(0, len(startflat)):
            if time >= startflat[j] and time <= endflat[j]:
                dist[time] = dist[time] + 1
    return dist

def getCue(path):
    from fractions import Fraction
    PathCue = path
    CueFile = open(PathCue, 'r')
    Cues = []
    for i, CRaw in enumerate(CueFile):
        CueI = CRaw.split('\t')[0]
        Filename = CRaw.split('\t')[1]

        try:
            CueT = float(CueI)
        except:
            CueT = float(Fraction(CueI))

        Cues.append(CueT)
    return Cues

def BDfreePats(startendpat, Cues):

    validpat = []
    flag = True
    for patterns in startendpat:
        valid = []
        for occur in patterns:
            for cue in Cues:
                # check all the occurrences against the cues, if there's a violation, move to the next occurrences, preserving at the occurrence level, not at the pattern level
                if (occur[0] < cue and occur[1] > cue):
                    flag = False
                    # no more checking, next occur
                    break
                else:
                    flag = True
            # after checking against all cues, if the flag remains True, then it's valid
            if flag:
                valid.append((occur[0], occur[1]))


        if len(valid) > 1:
            validpat.append(valid)
        else:
            continue
    if len(validpat) == 0:
        return False

    return validpat

def eval1(cornertime, GTbd, thre):
    import operator

    gap = {}
    right = 0
    for cor in cornertime:
        for y in range(0, len(GTbd)):
            gap[y] = (abs(cor - GTbd[y]))

        sortedgap = sorted(gap.items(), key=operator.itemgetter(1))

        smallest = GTbd[sortedgap[0][0]]
        if abs(smallest - cor) <= thre:
            right = right + 1

    assert right <= len(cornertime)
    pre = right / len(cornertime)

    gap = {}
    right = 0
    for GT in GTbd:
        for y in range(0, len(cornertime)):
            gap[y] = (abs(cornertime[y] - GT))

        assert max(gap.keys()) <= len(cornertime)
        assert len(gap) == len(cornertime)
        sortedgap = sorted(gap.items(), key=operator.itemgetter(1))
        smallest = cornertime[sortedgap[0][0]]
        if abs(smallest - GT) <= thre:
            right = right + 1

    assert right <= len(GTbd)
    rec = right / len(GTbd)

    if rec + pre == 0:
        f1=0
    else:
        f1=(2 * (pre * rec) / (pre + rec))

    return pre, rec, f1

def smoothing(winsize, order, dist):
    import numpy as np
    from math import factorial

    def savitzky_golay(y, window_size, order, deriv=0, rate=1):
        try:
            window_size = np.abs(np.int(window_size))
            order = np.abs(np.int(order))
        except ValueError, msg:
            raise ValueError("window_size and order have to be of type int")
        if window_size % 2 != 1 or window_size < 1:
            raise TypeError("window_size size must be a positive odd number")
        if window_size < order + 2:
            raise TypeError("window_size is too small for the polynomials order")
        order_range = range(order+1)
        half_window = (window_size -1) // 2
        # precompute coefficients
        b = np.mat([[k**i for i in order_range] for k in range(-half_window, half_window+1)])
        m = np.linalg.pinv(b).A[deriv] * rate**deriv * factorial(deriv)
        # pad the signal at the extremes with
        # values taken from the signal itself
        firstvals = np.array(y[0] - np.abs(y[1:half_window+1][::-1][0] - y[0] ))
        lastvals = np.array(y[-1] + np.abs(y[-half_window-1:-1][::-1][0] - y[-1]))
        y = np.append(np.append(firstvals, y), lastvals)
        # y = np.concatenate((firstvals, y, lastvals))
        return np.convolve(m[::-1], y, mode='valid')
    return savitzky_golay(dist, winsize, order)

def mean(hist):
    mean = 0.0;
    for i in hist:
        mean += i;
    mean /= len(hist);
    return mean;

def pc2dist(pc):
    print(pc)
    if pc != 0:
        norm = [float(i) / sum(pc) for i in pc]
        return norm
    else:
        return 0
    # norm = [float(i) / max(pc) for i in pc]


def bhatta ( hist1,  hist2):
    import math
    # calculate mean of hist1
    h1_ = mean(hist1);

    # calculate mean of hist2
    h2_ = mean(hist2);
    # if h1_ == 0:
    #     print(hist1)
    # if h2_ ==0:
    #     print(hist2)

    # calculate score
    score = 0;
    for i in range(len(hist1)):
        score += math.sqrt( hist1[i] * hist2[i] );
    # print h1_,h2_,score;
    # try:
    #     score = -np.log(score)
    #     # score = math.sqrt( 1 - ( 1 / math.sqrt(h1_*h2_*len(hist1)*len(hist2)) ) * score );
    # except ValueError:
    #     score = 1
    return score;

def eval2(dist1, dist2, dist):
    from sklearn.metrics.pairwise import pairwise_distances, manhattan_distances, euclidean_distances
    from scipy.stats import pearsonr

    if dist == "bhatta":
        similarity = bhatta(dist1, dist2)
        return similarity

    if dist == "euclidean":
        similarity = euclidean_distances(dist1, dist2)
        return similarity

    if dist == "pearson":
        similarity = pearsonr(dist1, dist2)[0]
        similarityp = pearsonr(dist1, dist2)[1]
        return similarity, similarityp

    if dist == "kl":
        import scipy.stats
        similarity = scipy.stats.entropy(dist1, qk=dist2)
        return similarity

    if dist == "ws":
        import scipy.stats
        similarity = scipy.stats.wasserstein_distance(dist1, dist2)
        return similarity

def tableall(precision3, recall3, F13, alglist, outname, algnummap):

    avgpre = []
    for index in range(0, len(zip(*precision3))):
        avgpre.append(numpy.mean(zip(*precision3)[index]))

    avgf1 = []
    for index in range(0, len(zip(*F13))):
        avgf1.append(numpy.mean(zip(*F13)[index]))

    avgrec = []
    for index in range(0, len(zip(*recall3))):
        avgrec.append(numpy.mean(zip(*recall3)[index]))

    variance = []
    for tp in zip(*precision3):
        norm = [float(i) / max(tp) for i in tp]
        variance.append(numpy.var(norm))
        # variance.append(numpy.var(tp))
        # print('var: '+str(numpy.var(norm)))

    variancerec = []
    for tp in zip(*recall3):
        norm = [float(i) / max(tp) for i in tp]
        variancerec.append(numpy.var(norm))
        # variancerec.append(numpy.var(tp))
        # print('var: '+str(numpy.var(norm)))

    variancef1 = []
    for tp in zip(*F13):
        norm = [float(i) / max(tp) for i in tp]
        variancef1.append(numpy.var(norm))
        # print('var: '+str(numpy.var(norm)))
        # variancef1.append(numpy.var(tp))

    textfile = open(outname, "w")
    for alg in alglist:
        textfile.write('\hline\n')
        if alg == "SC":
            index = algnummap[alg]
            # textfile.write("SYMCHM & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "SC & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       1:6] + ")\\\\" + "\n")
        if alg == "SIAF1":
            index = algnummap[alg]
            # textfile.write("SIAF1 & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "SIAF1 & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                   :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       :5] + ")\\\\" + "\n")
        if alg == "SIAR":
            index = algnummap[alg]
            # textfile.write("SIAR & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "SIAR & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                  :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       :5] + ")\\\\" + "\n")
        if alg == "SIAP":
            index = algnummap[alg]
            # textfile.write("SIAP & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "SIAP & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                  :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       :5] + ")\\\\" + "\n")
        if alg == "VM1":
            index = algnummap[alg]
            # textfile.write("VM1 & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "VM1 & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                 :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       :5] + ")\\\\" + "\n")
        if alg == "VM2":
            index = algnummap[alg]
            # textfile.write("VM2 & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
            textfile.write(
                "VM2 & (" + str(avgpre[index])[:5] + ", " + str(variance[index])[:5] + ") & (" + str(avgrec[index])[
                                                                                                 :5] + ", " + str(
                    variancerec[index])[:5] + ") & (" + str(avgf1[index])[:5] + ", " + str(variancef1[index])[
                                                                                       :5] + ")\\\\" + "\n")
        # if index==9:
        #     # textfile.write("SIARCT-CFP & "+ str(avgpre[index])[:5]+" & "+ str(variance[index])[:5] +"\\\\"+"\n")
        #     textfile.write("SIACFP & ("+ str(avgpre[index])[:5]+", "+ str(variance[index])[:5] +") & ("+str(avgrec[index])[:5]+", "+str(variancerec[index])[:5]+") & ("+str(avgf1[index])[:5]+", "+str(variancef1[index])[:5]+")\\\\"+"\n")

        # if index == 9:
        #     norm = [float(i) / max(allproppre) for i in allproppre]
        #     normf1 = [float(i) / max(allpropF1) for i in allpropF1]
        #     normrec = [float(i) / max(allproprec) for i in allproprec]
        #
        #     normm = [float(i) / max(allmaxprecision) for i in allmaxprecision]
        #     normf1m = [float(i) / max(allmaxF1) for i in allmaxF1]
        #     normrecm = [float(i) / max(allmaxrecall) for i in allmaxrecall]
        #
        #     # textfile.write("PPA & "+ str(numpy.mean(allproppre))[:5]+" & "+ str(numpy.var(norm))[:5] +"\\\\"+"\n")
        #     # textfile.write("PPA & ("+ str(numpy.mean(allproppre))[:5]+", "+ str(numpy.var(norm))[:5] +") & ("+str(numpy.mean(allproprec))[:5]+", "+str(numpy.var(normrec))[:5]+") & ("+str(numpy.mean(allpropF1))[:5]+", "+str(numpy.var(normf1))[:5]+")\\\\"+"\n")
        #     # textfile.write("PPA & ("+ str(maxprecision)[:5]+", "+ str(numpy.var(norm))[:5] +") & ("+str(maxrecall)[:5]+", "+str(numpy.var(normrec))[:5]+") & ("+str(maxF1)[:5]+", "+str(numpy.var(normf1))[:5]+")\\\\"+"\n")
        #
        #     textfile.write(
        #         "PPA & (" + str(numpy.mean(allmaxprecision))[:5] + ", " + str(numpy.var(normm))[:5] + ") & (" + str(
        #             numpy.mean(allmaxrecall))[:5] + ", " + str(numpy.var(normrecm))[:5] + ") & (" + str(
        #             numpy.mean(allmaxF1))[:5] + ", " + str(numpy.var(normf1m))[:5] + ")\\\\" + "\n")
            # textfile.write("PPA dp & ("+ str(numpy.mean(allmaxprecision))[:5]+", "+ str(numpy.var(allmaxprecision))[:5] +") & ("+str(numpy.mean(allmaxrecall))[:5]+", "+str(numpy.var(allmaxrecall))[:5]+") & ("+str(numpy.mean(allmaxF1))[:5]+", "+str(numpy.var(allmaxF1))[:5]+")\\\\"+"\n")
            # textfile.write("PPA & ("+ str(numpy.mean(allproppre))[:5]+", "+ str(numpy.var(allproppre))[:5] +") & ("+str(numpy.mean(allproprec))[:5]+", "+str(numpy.var(allproprec))[:5]+") & ("+str(numpy.mean(allpropF1))[:5]+", "+str(numpy.var(allpropF1))[:5]+")\\\\"+"\n")

        # if index == 10:
        #     textfile.write("PPA fp& (" + str(numpy.mean(allproppre))[:5] + ", " + str(numpy.var(norm))[:5] + ") & (" + str(
        #         numpy.mean(allproprec))[:5] + ", " + str(numpy.var(normrec))[:5] + ") & (" + str(numpy.mean(allpropF1))[
        #                                                                                      :5] + ", " + str(
        #         numpy.var(normf1))[:5] + ")\\\\" + "\n")

def getDeri(dist):
    deri=[]
    deri2=[]
    deri2normal=[]
    for i in range(0,len(dist)-1):
        deri.append(dist[i+1] - dist[i])

    for i in range(0,len(deri)-1):
        # deri2.append((deri[i+1] - deri[i])*5-50)
        deri2normal.append(deri[i+1] - deri[i])
    return deri, deri2normal

def getcornertime(deri, deri2, thre, thre2):
    count=0
    cornertime=[]
    cornernumeric=[]
    for i in range(0,len(deri2)-1):
        if (deri[i+1] > thre and deri[i] < -thre) or (deri[i+1]<-thre and deri[i] >thre) or \
            (deri2[i+1]>thre2 and deri2[i] < -thre2) or (deri2[i+1]<-thre2 and deri2[i] >thre2):
            cornertime.append(i)
            cornernumeric.append(1)
            count=count+1
        else:
            cornernumeric.append(0)
    return cornertime

def getCombi(distlist):
    import itertools
    gt = distlist[0]

    # print("combi input = " + str(distlist))
    combilist=[]
    combilist.append(gt)
    lenlist = [len(dist) for dist in distlist]
    padded = []
    if list(set(lenlist)) != 1:
        maxlen = max(lenlist)
        for dist in distlist:
            dist += [0] * (maxlen - len(dist))
            padded.append(dist)

    combilabel=[]
    for r in range(1,7):
        # print(r)
        combidist = list(itertools.combinations(distlist[1:], r))
        algnum = len(combidist)
        print(str(algnum)+": should be the combination number of algorithm")
        for comb in combidist:
            comblabelindi = len(comb)
            combilabel.append(len(comb))
            averagedist = [sum(x)/r for x in zip(*comb)]
            combilist.append(averagedist)
    print(str(len(combilist))+": returned combilist length")

    return combilist, combilabel