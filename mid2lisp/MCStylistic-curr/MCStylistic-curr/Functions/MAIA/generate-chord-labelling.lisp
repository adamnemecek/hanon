#| Copyright 2008-2013 Tom Collins
   Tuesday 19 April 2011
   Incomplete

\noindent An implementation of the ASSA algorithm as
described by \citet*{chuan2011}. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Harmony and metre")
   :name "chord-labelling"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "csv-files"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Maths foundation")
   :name "geometric-operations"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Harmony and metre")
   :name "inner-metric-analysis"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Maths foundation")
   :name "interpolation"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Harmony and metre")
   :name "keyscape"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Maths foundation")
   :name "list-processing"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Pattern rating")
   :name "projection"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Markov models")
   :name "segmentation"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))

(defvar
    *arff-assa-attrb-header*
  (list
   "@relation chordnotes"
   (concatenate
    'string "@attribute pc {'0','1','2','3','4','5',"
    "'6','7','8','9','10','11'}")
   "@attribute duration real"
   #| Pitch classes above. |#
   (concatenate
    'string
    "@attribute pitchsemitonesabove0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove1 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove2 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove3 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove4 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove5 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove6 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove7 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove8 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove9 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove10 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesabove11 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   #| Durations above. |#
   (concatenate
    'string
    "@attribute durationsemitonesabove0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove1 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove2 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove3 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove4 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove5 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove6 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove7 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove8 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove9 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove10 {'0','1',"
    "'2','3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesabove11 {'0','1',"
    "'2','3','4','5','6','7','8','9','10','11'}")
   #| Pitch classes below. |#
   (concatenate
    'string
    "@attribute pitchsemitonesbelow0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesbelow0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesbelow0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute pitchsemitonesbelow0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   #| Durations below. |#
   (concatenate
    'string
    "@attribute durationsemitonesbelow0 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow1 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow2 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow3 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow4 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow5 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow6 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow7 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow8 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow9 {'0','1','2',"
    "'3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow10 {'0','1',"
    "'2','3','4','5','6','7','8','9','10','11'}")
   (concatenate
    'string
    "@attribute durationsemitonesbelow11 {'0','1',"
    "'2','3','4','5','6','7','8','9','10','11'}")
   #| Approaching interval. |#
   "@attribute intleftleq2 {'0','1'}"
   "@attribute intleft2lxleq5 {'0','1'}"
   "@attribute intleftg5 {'0','1'}"
   #| Departing interval. |#
   "@attribute intrightleq2 {'0','1'}"
   "@attribute intright2lxleq5 {'0','1'}"
   "@attribute intrightg5 {'0','1'}"
   #| Metric level. |#
   "@attribute metriclevel1 {'T','NIL'}"
   "@attribute metriclevel2 {'T','NIL'}"
   "@attribute metriclevel3 {'T','NIL'}"
   "@attribute metriclevel4 {'T','NIL'}"
   #| Note on beat 1, 2,..., 6 of the bar. |#
   "@attribute noteonbeat1 {'T','NIL'}"
   "@attribute noteonbeat2 {'T','NIL'}"
   "@attribute noteonbeat3 {'T','NIL'}"
   "@attribute noteonbeat4 {'T','NIL'}"
   "@attribute noteonbeat5 {'T','NIL'}"
   "@attribute noteonbeat6 {'T','NIL'}"
   "@attribute class {'chordnote','nonchordnote'}"))

#|
\noindent Example:
\begin{verbatim}
(determine-chord-tone-train
 '(9 70 66 1 0)
 '((-1 8 0 1 1) (0 7 4 3 5) (3 5 2 3 8) (6 0 1 1 4)
   (7 5 2 1 4) (8 0 0 1 4) (9 5 6 3 8)))
--> NIL
(determine-chord-tone-train
 '(9 65 63 1 0)
 '((-1 8 0 1 1) (0 7 4 3 5) (3 5 2 3 8) (6 0 1 1 4)
   (7 5 2 1 4) (8 0 0 1 4) (9 5 6 3 8)))
--> 5
\end{verbatim}

\noindent This function returns the pitch class of the
datapoint supplied as the first argument (and nil
otherwise) if the datapoint is a chord tone of the
relevant chord datapoint. The second argument is a
chord dataset with default structure: first dimension
is ontime, second dimension is MIDI note number modulo
12 of the root of the chord, the third dimension is
class of the chord (0, major triad; 1, dom7; 2, minor
triad; 3, fully diminished 7th; 4, half diminished
7th; 5, diminished triad; 6, minor 7th), the fourth
dimension is the duration of the chord, and the
fifth dimension contains the score as assigned by the
HarmAn algorithm. The relevant chord datapoint is the
one before the first member of the chord dataset with
ontime greater than the datapoint ontime. |#

(defun determine-chord-tone-train
       (datapoint chord-dataset &optional
        (chord-templates
         *chord-templates-p&b&min7ths*)
        (ontime-index 0) (MNN-index 1)
        (chord-ons
         (nth-list-of-lists
          ontime-index chord-dataset))
        (chord-locp
         (index-1st-sublist-item>
           (nth ontime-index datapoint) chord-ons))
        (chord-loc
         (-
          (if chord-locp
            chord-locp (length chord-ons)) 1))
        (chord-datapoint
         (nth chord-loc chord-dataset))
        (chord-index
         (MNN-mod12&class2chord-index
          (subseq chord-datapoint 1 3)))
        (chord-template
         (nth chord-index chord-templates)))
  (find
   (mod (nth MNN-index datapoint) 12)
   chord-template :test #'equalp))

#|
\noindent Example:
\begin{verbatim}
(determine-chord-tones-train
 '((9 70 66 1 0) (10 68 65 1 0))
 '((-1 8 0 1 1) (0 7 4 3 5) (3 5 2 3 8) (6 0 1 1 4)
   (7 5 2 1 4) (8 0 0 1 4) (9 5 6 3 8)))
--> (NIL T)
\end{verbatim}

\noindent This function returns a list Ts and NILs,
for each datapoint in the dataset supplied as the
first argument. It checks, using the function
determine-chord-tone, whether (T returned) or not (NIL
returned) each datapoint is a chord tone of the
relevant chord datapoint. |#

(defun determine-chord-tones-train
       (dataset chord-dataset &optional
        (chord-templates
         *chord-templates-p&b&min7ths*)
        (ontime-index 0) (MNN-index 1)
        (chord-ons
         (nth-list-of-lists
          ontime-index chord-dataset)))
  (mapcar
   #'(lambda (x)
       (if (determine-chord-tone-train
            x chord-dataset chord-templates
            ontime-index MNN-index chord-ons) T))
   dataset))

#|
\noindent Example:
\begin{verbatim}
(setq
 dataset
 '((-1 68 65 1 0) (0 70 66 1 0) (1 67 64 2 0)
   (3 68 65 1 0) (4 65 63 2 0) (6 64 62 3/2 0)
   (15/2 65 63 1/2 0) (8 67 64 1 0) (9 70 66 1 0)
   (10 68 65 1 0)))
(setq
 chord-dataset
 '((-1 8 0 1 1) (0 7 4 3 5) (3 5 2 3 8) (6 0 1 1 4)
   (7 5 2 1 4) (8 0 0 1 4) (9 5 6 3 8)))
(fragment&vectorise-local-semitones
 2 dataset chord-dataset)
--> (((0 70 66 1 0) (1 67 64 2 0))
     (0 0 0 1 0 0 0 0 0 0 0 0
      0 0 0 1 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0))
(fragment&vectorise-local-semitones 2 dataset)
--> (((-1 68 65 1 0) (0 70 66 1 0) (1 67 64 2 0))
     (0 1 0 1 0 0 0 0 0 0 0 0
      0 1 0 1 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0))
\end{verbatim}

\noindent This function returns four twelve-element
vectors (appended). It calculates a fragment for the
$i$th point in a dataset. It determines whether there
is a note $0, 1,\ldots, 11$ semitones higher (lower)
than the MIDI note number of the $i$th point, and also
records the duration of any such note. The output is a
list of two lists. The first list is a dataset of the
notes contained in the fragment. The order of the
second list is as follows: (1) vector of indicators
for higher semitones; (2) vector of corresponding
durations; (3) vector of indicators for lower
semitones; (4) vector of corresponding durations. |#

(defun fragment&vectorise-local-semitones
       (i dataset &optional (chord-dataset nil)
	(win-plus-minus 2) (datapoint (nth i dataset))
	(ontime-idx 0) (MNN-idx 1) (duration-idx 3)
	#| Establish time window of fragment. |#
	(chord-ons
	 (if chord-dataset
	   (nth-list-of-lists
	    ontime-idx chord-dataset)))
	(chord-locp
	 (if chord-dataset
	   (index-1st-sublist-item>
	    (nth ontime-idx datapoint) chord-ons)))
	(chord-loc
	 (if chord-dataset
	   (-
	    (if chord-locp
	      chord-locp (length chord-ons)) 1)))
	(chord-datapoint
	 (if chord-dataset
	   (nth chord-loc chord-dataset)))
	(time-window
	 (if chord-dataset
	   (list
	    (first chord-datapoint)
	    (+
	     (first chord-datapoint)
	     (fourth chord-datapoint)))
	   (list
	    (-
	     (nth ontime-idx datapoint)
             win-plus-minus)
	    (+
	     (nth ontime-idx datapoint)
	     win-plus-minus))))
	#| Calculate datapoints sounding between, and
	   lists of relevant MNNs and durations. |#
	(fragment
	 (mapcar
	  #'(lambda (x)
	      (butlast (butlast x)))
	  (datapoints-sounding-between
	   (append-offtimes dataset duration-idx)
	   (first time-window) (second time-window))))
	(relevant-datapoints
	 (remove datapoint fragment :test #'equalp))
	(relevant-MNNs
	 (nth-list-of-lists
	  MNN-idx relevant-datapoints))
	(relevant-durs
	 (nth-list-of-lists
	  duration-idx relevant-datapoints))
	(MNN-probe (nth MNN-idx datapoint))
	#| Define vectors of semitones and
           corresponding duations sounding above and
           below. |#
	(semis-durs-above
	 (vectorise-local-semitones
	  relevant-MNNs relevant-durs
	  (add-to-list
	   MNN-probe
	   (add-to-list
	    -1 (reverse (first-n-naturals 12))))))
	(semis-durs-below
	 (vectorise-local-semitones
	  relevant-MNNs relevant-durs
	  (reverse
	   (add-to-list
	    MNN-probe
	    (multiply-list-by-constant
	     (add-to-list
	      -1 (first-n-naturals 12)) -1))))))
  (list
   fragment
   (append
    (first semis-durs-above) (second semis-durs-above)
    (first semis-durs-below)
    (second semis-durs-below))))

#|
\noindent Example:
\begin{verbatim}
(interval-range-logicals
 3 '(0 2 -3 1 2 2 0 1 -1 -2 -2 2 -2 -1 1))
--> (0 1 0 1 0 0)
\end{verbatim}

\noindent This function takes the index of a note from
a melody (first argument) into a list of intervals for
that melody (second argument). So if $i$ is the index,
then the $i-1$th entry in the list is the interval
approaching the note in question, and the $i$th entry
is the interval leaving the note in question. It
returns a list of six zeros and ones as answers to the
following questions: (1) Is interval to left less than
or equal to two semitones? (2) Is interval to left
greater than two and less than or equal to five
semitones? (3) Is interval to left greater than five
semitones? (4-6) Same but for interval to right. |#

(defun interval-range-logicals
       (i ints &optional (n (length ints)))
  (append
   (if (>= i 1)
     (list
      (if (<= (abs (nth (- i 1) ints)) 2) 1 0)
      (if (and
	   (> (abs (nth (- i 1) ints)) 2)
	   (<= (abs (nth (- i 1) ints)) 5)) 1 0)
      (if (> (abs (nth (- i 1) ints)) 5) 1 0))
     (list 0 0 0))
   (if (< i n)
     (list
      (if (<= (abs (nth i ints)) 2) 1 0)
      (if (and
	   (> (abs (nth i ints)) 2)
	   (<= (abs (nth i ints)) 5)) 1 0)
      (if (> (abs (nth i ints)) 5) 1 0))
     (list 0 0 0))))

#|
\noindent Example:
\begin{verbatim}
(setq
 fpath
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Example files"))
  *MCStylistic-MonthYear-functions-path*))
(setq fname "beethovenOp2No1Mvt3")
(melody2ASSA-attributes
 '((-1 68 65 1 0) (0 70 66 1 0) (1 67 64 2 0)
   (3 68 65 1 0) (4 65 63 2 0) (6 64 62 3/2 0)
   (15/2 65 63 1/2 0) (8 67 64 1 0) (9 70 66 1 0)
   (10 68 65 1 0))
 3 fpath fname)
--> ((3 1
      0 0 1 0 0 0 0 0 0 0 0 0
      0 0 1 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 1 0 0
      2 T NIL NIL NIL
      NIL NIL T NIL NIL NIL)
     (5 1
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 1 1 0 0 0 0 0 0 0 0
      0 0 1 2 0 0 0 0 0 0 0 0
      1 0 0 0 1 0
      3 NIL NIL T NIL
      T NIL NIL NIL NIL NIL)
     (2 2
      0 1 0 1 0 0 0 0 0 0 0 0
      0 1 0 1 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 1 0 1 0 0
      3 T NIL NIL NIL
      NIL T NIL NIL NIL NIL)
     (3 1
      0 0 0 0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 0 0 0
      0 1 0 1 0 0 0 0 0 0 0 0
      0 2 0 2 0 0 0 0 0 0 0 0
      1 0 0 0 1 0
      3 NIL T NIL NIL
      T NIL NIL NIL NIL NIL)
     ...
     (3 1
      0 0 1 0 0 0 0 0 0 0 0 0
      0 0 1 0 0 0 0 0 0 0 0 0
      0 1 0 0 0 0 0 0 0 0 0 0
      0 1 0 0 0 0 0 0 0 0 0 0
      1 0 0 0 0 0
      3 NIL T NIL NIL
      NIL T NIL NIL NIL NIL))
\end{verbatim}

\noindent This function generates a list of 67
attributes for each datapoint in a given melody. It
assumes that the input dataset is a melody. The
original paper by \citet{chuan2011} lists 73
attributes, but the final eight require manual
annotation of the musical score, so have been
omitted. The final four attributes assume a time
signature of 4-4, but this has been generalised in the
implementation below to allow for 2-4, 3-4, or 6-8
time signatures. In future, it could be generalised
further to allow for passing a list of time-signature
changes.

In the paper, a melody fragment is defined as `a
series of melody notes that are harmonized by the
same chord' \citep{chuan2011}[p.~68]. In training,
this is fine, as a harmonization will be available. In
testing, however, the melody fragments are unknown,
otherwise a harmonization must already exist!
Therefore, in test phase, the argument for chord-
dataset below defaults to nil, and a melody fragment
is defined as all notes occurring two beats either
side of the current onset.

The attributes are:
\begin{enumerate}
\item Pitch class.
\item Duration.
\item[3-14.] Note $i$ semitones above in melody
fragment (twelve-element binary vector).
\item[15-26.] Duration of corresponding note.
\item[27-38.] Note $i$ semitones below in melody
fragment (twelve-element binary vector).
\item[39-50.] Duration of corresponding note.
\item[51.] Interval to left less than or equal to two
semitones.
\item[52.] Interval to left greater than two and less
than or equal to five semitones.
\item[53.] Interval to left greater than five
semitones.
\item[54-56.] Same but for interval to right.
\item[57.] Number of pitch classes in fragment
(unclear whether this is up to uniqueness, assumed
not).
\item[58-61.] Metrical level strength
\citep*{volk2002, chew2005}, a four-element vector
containing values in $\{1, 2, 3, 4\}$.
\item[62-67.] Note on beat $1, 2,\ldots, 6$ of the
bar.
\end{enumerate} |#

(defun melody2ASSA-attributes
       (melody beats-in-bar fpath fname &optional
	(chord-dataset nil) (ontime-idx 0) (MNN-idx 1)
	(duration-idx 3)
	(ons (nth-list-of-lists ontime-idx melody))
	(MNNs (nth-list-of-lists MNN-idx melody))
	(ints (spacing-items MNNs))
	(durs (nth-list-of-lists duration-idx melody))
	(pcs
	 (dataset2pcs-norm-tonic melody MNN-idx))
	(norm-metric-weights
	 (normalise-metric-weights-by-quartiles
	  (second
	   (general-metric-weights
	    melody fpath fname))))
	(n (length melody))
	(i 0)
	(fragment&semitones-vector
	 (if (< i n)
	   (fragment&vectorise-local-semitones
	    i melody chord-dataset)))
	(bar-beat
	 (if (< i n)
	   (+
	    (floor
             (mod (nth i ons) beats-in-bar)) 1))))
  (if (>= i n) ()
    (cons
     (append
      (list (nth i pcs)) (list (nth i durs))
      (second fragment&semitones-vector)
      (interval-range-logicals i ints)
      (list
       (length (first fragment&semitones-vector)))
      (list
       (equalp (nth i norm-metric-weights) 1)
       (equalp (nth i norm-metric-weights) 2)
       (equalp (nth i norm-metric-weights) 3)
       (equalp (nth i norm-metric-weights) 4))
      (list
       (equalp bar-beat 1) (equalp bar-beat 2)
       (equalp bar-beat 3) (equalp bar-beat 4)
       (equalp bar-beat 5) (equalp bar-beat 6)))
     (melody2ASSA-attributes
      melody beats-in-bar fpath fname chord-dataset
      ontime-idx MNN-idx duration-idx ons MNNs ints
      durs pcs norm-metric-weights n (+ i 1)))))

#|
\noindent Example:
\begin{verbatim}
(setq a-list '(4 7 8 2 4 3 0 2 2))
(setq b-list '(1 1 1/2 4 3 1 2 1 1))
(setq probes '(2 6 8))
(vectorise-local-semitones a-list b-list probes)
--> ((1 0 1) (4 0 1/2))
(setq a-list '(70 67))
(setq b-list '(1 2))
(setq probes '(70 69 68 67 66 65 64 63 62 61 60 59))
(vectorise-local-semitones a-list b-list probes)
--> ((0 0 0 0 0 0 0 0 0 1 0 0 0)
     (0 0 0 0 0 0 0 0 0 2 0 0 0))
\end{verbatim}

\noindent This function is intended to take a list of
pitch classes and a list of corresponding durations as
input, as well as a list of probes (must be integers
in ascending order). If probe pitch class $i$ is
present in the list of pitch classes, then this is
indicated by a 1 in the $i$th element of the first
output vector, and by the corresponding duration of
the first occurrence of this pitch class in the $i$th
element of the second output vector. |#

(defun vectorise-local-semitones
       (a-list b-list probes &optional
	(indices
	 (mapcar
	  #'(lambda (x)
	      (index-item-1st-occurs x a-list))
	  probes))
	(semitones
	 (mapcar
	  #'(lambda (x)
	      (if x (identity 1) (identity 0)))
	  indices))
	(durations
	 (mapcar
	  #'(lambda (x)
	      (if x (nth x b-list) (identity 0)))
	  indices)))
  (list semitones durations))


