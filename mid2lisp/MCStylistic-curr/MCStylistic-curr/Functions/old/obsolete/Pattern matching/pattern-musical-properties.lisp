#| Tom Collins
   Monday 19 October 2009
   Incomplete

Written to aid the calculation of explanatory
variables for analysis of Cambridge 09 study
results. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/sort-by.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/vector-operations.lisp"))

#| Example:
(cons-ith-while-floor-jth-constantp
 '((13 55) (13 60) (13 64) (27/2 63) (14 55) (15 55)
   (15 59) (15 65) (16 55) (17 72) (18 55) (19 55)
   (22 55) (23 60) (24 55) (24 59) (25 55)) 1 0)
gives
(55 60 64 63).

This function makes a list from the ith item of each
list in a list of lists, so long as the floor of the
jth item is constant. |#

(defun cons-ith-while-floor-jth-constantp
       (a-list i j &optional
	(probe
	 (floor (nth j (first a-list))))
	(result nil))
  (if (or
       (null a-list)
       (not (equalp (floor (nth j (first a-list)))
		    probe)))
    (identity result)
    (cons-ith-while-floor-jth-constantp
     (rest a-list) i j probe
     (append result (list (nth i (first a-list)))))))

#| Example:
(cons-ith-while-jth-constantp
 '((13 55) (13 60) (13 64) (14 55) (15 55) (15 59)
   (15 65) (16 55) (17 72) (18 55) (19 55) (22 55)
   (23 60) (24 55) (24 59) (25 55) (25 67)) 1 0)
gives
(55 60 64).

This function makes a list from the ith item of each
list in a list of lists, so long as the jth item is
constant. |#

(defun cons-ith-while-jth-constantp
       (a-list i j &optional
	(probe
	 (nth j (first a-list)))
	(result nil))
  (if (or
       (null a-list)
       (not (equalp (nth j (first a-list)) probe)))
    (identity result)
    (cons-ith-while-jth-constantp
     (rest a-list) i j probe
     (append result (list (nth i (first a-list)))))))

#| Example:
(density
 '((13 55) (13 60) (13 64) (27/2 63) (14 55)) 13)
gives
4.

In a pattern P = p1, p2,..., pm, let pi have ontime 
xi, i = 1, 2,..., m. The tactus beats are then the
integers from a = floor(x1) to b = floor(xm), assuming
that beats coincide with integer ontimes and that the
bottom number in the time signature does not change
over the course of the pattern. The rhythmic density
of the pattern at beat c in [a, b], denoted rho(P, c),
is given by the cardinality of the set of all pattern
points such that floor(xi) = c. |#

(defun density (sub-pattern integer)
  (length (cons-ith-while-floor-jth-constantp
	   sub-pattern 1 0 integer)))

#| Example:
(intervallic-leaps
 '((13 57) (13 60) (13 62) (14 57) (15 57) (15 59)
   (15 63) (16 57) (17 67) (18 57) (19 57) (22 57)
   (23 60) (24 57) (24 59) (25 57) (25 64)))
gives
7.

This variable counts the number of intervallic leaps
present in the melody line of a pattern, the intuition
being that leaping melodies may be rated as more
noticeable or important. Any interval larger than a
major third counts, and the same `top-line' rule as in
the function small-intervals is observed. |#

(defun intervallic-leaps
       (pattern &optional (leap 2) (index 1)
	(intervals
	 (spacing-of-items
	  (top-line pattern index))) (counter 0))
  (if (null intervals) (identity counter)
    (intervallic-leaps
     pattern leap index (rest intervals)
     (if (> (abs (first intervals)) leap)
       (+ counter 1) (identity counter)))))

#| Example:
(max-pitch-centre
 '(((0 60) (1 61)) ((3 48) (4 49))) 1
 '((0 60) (1 61) (2 62) (3 48) (3 57) (4 49)))
gives
23/3.

Pitch centre is defined as `the absolute distance, in
semitones, of the mean pitch of a [pattern]...from the
mean pitch of the dataset' (Pearce and Wiggins 2007,
p. 78). By taking the maximum pitch centre over all
occurrences of a pattern, I hope to isolate either
unusually high, or unusually low occurrences. |#

(defun max-pitch-centre
       (TEC-with-MIDI-note-numbers index dataset
	&optional
	(dataset-MIDI-note-numbers
	 (nth-list-of-lists 1 dataset))
	(dataset-MIDI-note-numbers-mean
	 (mean dataset-MIDI-note-numbers))
	(result nil)
	(pattern-MIDI-note-numbers
	 (if TEC-with-MIDI-note-numbers
	  (nth-list-of-lists
	   index
	   (first TEC-with-MIDI-note-numbers))))
	(pattern-MIDI-note-numbers-mean
	 (if TEC-with-MIDI-note-numbers
	   (mean pattern-MIDI-note-numbers))))
  (if (null TEC-with-MIDI-note-numbers)
    (max-item result)
    (max-pitch-centre
     (rest TEC-with-MIDI-note-numbers)
     index dataset dataset-MIDI-note-numbers
     dataset-MIDI-note-numbers-mean
     (append result
	     (list 
	      (abs
	       (- dataset-MIDI-note-numbers-mean
		  pattern-MIDI-note-numbers-mean)))))))

#| Example:
(mean '(6 5 3 3 4))
gives
21/5.

The mean of data. |#

(defun mean (data &optional (n (length data)))
  (/ (my-last (fibonacci-list data)) n))

#| Example:
(pitch-centre
 '(60 61 62)
 '((0 60) (1 61) (2 62) (3 48) (3 57)))
gives
17/5.

Pitch centre is defined as `the absolute distance, in
semitones, of the mean pitch of a [pattern]...from the
mean pitch of the dataset' (Pearce and Wiggins 2007,
p. 78). By taking the maximum pitch centre over all
occurrences of a pattern, I hope to isolate either
unusually high, or unusually low occurrences. |#

(defun pitch-centre
       (pattern-MIDI-note-numbers dataset &optional
	(dataset-MIDI-note-numbers
	 (nth-list-of-lists 1 dataset))
	(dataset-MIDI-note-numbers-mean
	 (mean dataset-MIDI-note-numbers))
	(pattern-MIDI-note-numbers-mean
	 (mean pattern-MIDI-note-numbers)))
  (abs
   (- dataset-MIDI-note-numbers-mean
      pattern-MIDI-note-numbers-mean)))

#| Example:
(pitch-range '((0 60) (1 61) (3 62)) 1)
gives
2.

Pitch range is the range in semitones of a pattern. |#

(defun pitch-range
       (pattern index &optional
	(pattern-MIDI-note-numbers
	 (nth-list-of-lists index pattern)))
  (range pattern-MIDI-note-numbers))

#| Example:
(range '(60 61 62))
gives
2.

Range is the maximum member of a list, minus the
minimum member. |#

(defun range (data)
  (- (max-item data) (min-item data)))

#| Example:
(restn '((13 55) (13 60) (13 64) (14 55) (15 55)) 3)
gives
((14 55) (15 55)).

Applies the function rest n times. |#

(defun restn (a-list n)
  (if (<= n 0) (identity a-list)
    (restn (rest a-list) (- n 1))))

#| Example:
(rhythmic-density
 '((13 55) (13 60) (13 64) (27/2 63) (14 55) (17 48)))
gives
6/5.

The rhythmic density of a pattern is defined as `the
mean number of events per tactus beat' (Pearce and
Wiggins 2007, p.~78). See the function density for
further definitions. |#

(defun rhythmic-density
       (pattern &optional
	(a (floor (first (first pattern))))
	(b (floor (first (my-last pattern))))
	(i a)
	(result 0)
	(density-summand
	 (if pattern
	   (density pattern i))))
  (if (null pattern)
    (/ result (+ (- b a) 1))
    (rhythmic-density
     (restn pattern density-summand)
     a b (+ i 1) (+ result density-summand))))

#| Example:
(rhythmic-variability
 '((0 64 1) (1 55 1/2) (1 65 1) (2 55 1/2) (2 72 1/3)
   (3 55 1) (4 55 2) (5 55 1/2) (5 60 1)
   (6 59 1/3) (6 67 1/2)) 2)
gives
.

The rhythmic variability of a pattern is defined as
`the degree of change in note duration (i.e., the
standard deviation of the log of the event durations)'
(Pearce and Wiggins 2007, p.~78). The intuition is
that patterns with much rhythmic variation are likely
to be noticeable. |#

(defun rhythmic-variability
       (pattern index &optional (base (exp 1))
	(log-rhythms
	 (mapcar #'(lambda (z)
		     (log z base))
		 (nth-list-of-lists index pattern))))
  (sd log-rhythms))

#| Example:
(sd '(64 55 65 55 72 55 55 55 60 59 67))
gives
5.7178855.

The standard deviation of the sample (using a
denominator of n, where n is the sample size). |#

(defun sd (data &optional
	   (x-bar (mean data))
	   (square-deviations
	    (mapcar #'(lambda (x)
			(expt (- x x-bar) 2))
		    data)))
  (sqrt
   (/ (my-last (fibonacci-list square-deviations))
      (length data))))

#| Example:
(small-intervals
 '((13 57) (13 60) (13 62) (14 57) (15 57) (15 59)
   (15 63) (16 57) (17 67) (18 57) (19 57) (22 57)
   (23 60) (24 57) (24 59) (25 57) (25 64)))
gives
3.

The small intervals variable counts the number of such
intervals present in the melody line of a pattern, the
intuition being that scalic, static or stepwise
melodies may be rated as more noticeable or important.
As sometimes the melody is not obvious in polyphonic
music, I use a `top-line' rule: at each of the
pattern's distinct ontimes there will be at least one
datapoint present. At this ontime the melody takes the
value of the maximum morphetic pitch number
present. |#

(defun small-intervals
       (pattern &optional (index 1)
	(intervals
	 (spacing-of-items
	  (top-line pattern index))) (counter 0))
  (if (null intervals) (identity counter)
    (small-intervals
     pattern index (rest intervals)
     (if (find
	  (abs (first intervals)) '(0 1)
	  :test #'equalp)
       (+ counter 1) (identity counter)))))

#| Example:
(spacing-of-items '(64 55 65 55 72 55 55 55 60 59 67))
gives
(-9 10 -10 17 -17 0 0 5 -1 8).

This function is very similar to the function spacing
from chords.lisp. It takes a list of items and
returns the intervals between these items. |#

(defun spacing-of-items (list-of-items)
  (if (equal (length list-of-items) 1) ()
    (cons
     (- (second list-of-items)
	(first list-of-items))
     (spacing-of-items (rest list-of-items)))))

#| Example:
(top-line
 '((13 55) (13 60) (13 64) (14 55) (15 55) (15 59)
   (15 65) (16 55) (17 72) (18 55) (19 55) (22 55)
   (23 60) (24 55) (24 59) (25 55) (25 67)) 1)
gives
(64 55 65 55 72 55 55 55 60 59 67).

For each distinct ontime, this function returns the
maximum pitch as a member of a list. |#

(defun top-line
       (pattern index &optional (result nil)
	(ontime (first (first pattern)))
	(relevant-melody-notes
	 (if ontime
	   (cons-ith-while-jth-constantp
	    pattern index 0 ontime))))
  (if (null pattern) (identity result)
    (top-line
     (restn pattern (length relevant-melody-notes))
     index
     (append result
	     (list (max-item
		    relevant-melody-notes))))))




