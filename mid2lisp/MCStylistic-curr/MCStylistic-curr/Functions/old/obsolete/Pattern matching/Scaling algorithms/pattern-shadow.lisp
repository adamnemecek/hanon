#| Example:
(events-with-these-ontime-finger-heights
 '((7 96 69) (17/2 109 75)) 
 '((23/4 86 74 1/4) (6 55 57 1/2) (6 63 62 1/3)
   (6 63 62 1/2) (7 95 69 1) (7 96 69 1/2) (7 96 70 1)
   (7 108 74 3/2) (17/2 109 75 1/2) (9 95 68 1)
   (9 98 69 1) (9 102 71 1) (9 112 78 3/4)))
gives
((7 1/2) (17/2 1/2)).

This function is only called in the situation where
the projection-indicator variable equals (1 1 1 0).
It performs an analogous role to the function
events-with-this-ontime-other. |#

(defun events-with-these-ontime-finger-heights
       (projected-datapoints unprojected-dataset
        &optional (finger-index 1) (height-index 2)
	(return-index 3) (ontime-index 0)
        (ontimes (nth-list-of-lists
                  ontime-index
                  unprojected-dataset))
        (relevant-start
         (index-1st-sublist-item>=
          (first (first projected-datapoints))
          ontimes))
        (relevant-finish
         (index-1st-sublist-item>=
          (+ (first (my-last projected-datapoints))
	     0.01)
          ontimes))
        (relevant-dataset
         (subseq
          unprojected-dataset
          (if (null relevant-start)
             (identity 0)
             (identity relevant-start))
          (if (null relevant-finish)
             (length ontimes)
             (identity relevant-finish)))))
  (if (null projected-datapoints) ()
    (append
     (events-with-this-ontime-finger-height
      (first projected-datapoints)
      relevant-dataset
      finger-index height-index
      return-index ontime-index)
     (events-with-these-ontime-finger-heights
      (rest projected-datapoints)
      unprojected-dataset
      finger-index height-index
      return-index ontime-index
      ontimes
      relevant-start relevant-finish
      relevant-dataset))))

#| Example:
(events-with-these-ontime-others
 '((6 63) (7 96) (9 112))
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/3 1 37) (6 63 1/2 2 34) (7 91 1 1 56)
   (7 96 1/2 1 73) (7 96 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73))
 1 2)
gives
((6 1/3) (6 1/2) (7 1/2) (7 1) (9 3/4)).

The first argument to this function is a pattern,
under the projection of ontime and MIDI note number
(in which case other-index = 1) or morphetic pitch
(in which case other-index = 2). The corresponding
members of the full dataset are sought out and
returned as ontime-other pairs. |#

(defun events-with-these-ontime-others
       (projected-datapoints unprojected-dataset
        &optional (other-index 1)
	(return-index 3) (ontime-index 0)
        (ontimes (nth-list-of-lists
                  ontime-index
                  unprojected-dataset))
        (relevant-start
         (index-1st-sublist-item>=
          (first (first projected-datapoints))
          ontimes))
        (relevant-finish
         (index-1st-sublist-item>=
          (+ (first (my-last projected-datapoints))
	     0.01)
          ontimes))
        (relevant-dataset
         (subseq
          unprojected-dataset
          (if (null relevant-start)
             (identity 0)
             (identity relevant-start))
          (if (null relevant-finish)
             (length ontimes)
             (identity relevant-finish)))))
  (if (null projected-datapoints) ()
    (append
     (events-with-this-ontime-other
      (first projected-datapoints)
      relevant-dataset
      other-index return-index ontime-index)
     (events-with-these-ontime-others
      (rest projected-datapoints)
      unprojected-dataset
      other-index return-index ontime-index
      ontimes
      relevant-start relevant-finish
      relevant-dataset))))

#| Example:
(events-with-this-ontime-finger-height
 '(7 96 69)
 '((23/4 86 74 1/4) (6 55 57 1/2) (6 63 62 1/3)
   (6 63 62 1/2) (7 95 69 1) (7 96 69 1/2) (7 96 70 1)
   (7 108 74 3/2) (17/2 109 75 1/2) (9 95 68 1)
   (9 98 69 1) (9 102 71 1) (9 112 78 3/4)))
gives
((7 1/2)).

This function is only called in the situation where
the projection-indicator variable equals (1 1 1 0).
It performs an analogous role to the function
events-with-this-ontime-other. |#

(defun events-with-this-ontime-finger-height
       (projected-datapoint relevant-dataset
        &optional (finger-index 1) (height-index 2)
	(return-index 3) (ontime-index 0))
  (if (null projected-datapoint) ()
    (if (null relevant-dataset) ()
      (append
       (if (equalp
            (list (nth
                   ontime-index
                   (first relevant-dataset))
                  (nth
                   finger-index
                   (first relevant-dataset))
		  (nth
                   height-index
                   (first relevant-dataset)))
            projected-datapoint)
         (list
	  (list
	   (nth 0 (first relevant-dataset))
	   (nth return-index
		(first relevant-dataset)))))
       (events-with-this-ontime-finger-height
        projected-datapoint
        (rest relevant-dataset)
        finger-index height-index
	return-index ontime-index)))))

#| Example:
(events-with-this-ontime-other
 '(7 96)
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/3 1 37) (6 63 1/2 2 34) (7 91 1 1 56)
   (7 96 1/2 1 73) (7 96 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73))
 1 2)
gives
((7 1/2) (7 1)).

The first argument to this function is a datapoint,
under the projection of ontime and MIDI note number
(in which case other-index = 1) or morphetic pitch
(in which case other-index = 2). The corresponding
members of the full dataset are sought out and
returned as ontime-other pairs. |#

(defun events-with-this-ontime-other
       (projected-datapoint relevant-dataset
        &optional (other-index 1)
	(return-index 3) (ontime-index 0))
  (if (null projected-datapoint) ()
    (if (null relevant-dataset) ()
      (append
       (if (equalp
            (list (nth
                   ontime-index
                   (first relevant-dataset))
                  (nth
                   other-index
                   (first relevant-dataset)))
            projected-datapoint)
         (list
	  (list
	   (nth 0 (first relevant-dataset))
	   (nth return-index
		(first relevant-dataset)))))
       (events-with-this-ontime-other
        projected-datapoint
        (rest relevant-dataset)
        other-index return-index ontime-index)))))

#| Example:
(nth-lists-of-lists
 '(0 2)
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/3 1 37) (6 63 1/2 2 34) (7 91 1 1 56)
   (7 96 1/2 1 73) (7 96 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73)))
gives
((23/4 1/4) (6 1/2) (6 1/3) (6 1/2) (7 1) (7 1/2)
 (7 1) (7 3/2) (17/2 1/2) (9 1) (9 1) (9 1) (9 3/4)).

The first argument to this function is a list of
indices; the second argument is a list of lists. The
function nth-list is applied to each element of the
second argument and returned as a list. |#

(defun nth-lists-of-lists (a-list b-list)
  (if (null b-list) ()
    (cons (nth-list a-list (first b-list))
	  (nth-lists-of-lists a-list (rest b-list)))))

#| Example:
(ontime-durations2on-offs
 '((6 1/3) (6 1/2) (7 1/2) (7 1) (9 3/4)))
gives
((6 1) (19/3 0) (6 1) (13/2 0) (7 1) (15/2 0) (7 1)
 (8 0) (9 1) (39/4 0)).

The only argument to this function is a list of pairs,
each consisting of an ontime and duration. These are
converted to a list of pairs consisting of a time
whose on-ness or off-ness is indicated by a one or
zero respectively. |#

(defun ontime-durations2on-offs
       (ontime-durations &optional
	(first-ontime-durations
	 (first ontime-durations)))
  (if (null first-ontime-durations) ()
    (append
     (list
      (list (first first-ontime-durations) 1)
      (list (+ (first first-ontime-durations)
	       (second first-ontime-durations)) 0))
     (ontime-durations2on-offs
      (rest ontime-durations)))))

#| Example:
(ontime-durations-for-projected-pattern
 '((6 63 62) (7 96 69) (9 112 78))
 '((23/4 86 74 1/4) (6 55 57 1/2) (6 63 62 1/3)
   (6 63 62 1/2) (7 95 69 1) (7 96 69 1/2) (7 96 70 1)
   (7 108 74 3/2) (17/2 109 75 1/2) (9 95 68 1)
   (9 98 69 1) (9 102 71 1) (9 112 78 3/4))
 '(1 1 1 0))
gives
((6 1/3) (6 1/2) (7 1/2) (9 3/4)).

The first argument to this function is a projected
pattern, which may or may not include the projection
of duration. This function recovers that dimension
for the pattern using the dataset (its second
argument) and the projection indicator (its third
argument), returning pairs of ontimes and durations
that correspond to members of the pattern. |#

(defun ontime-durations-for-projected-pattern
       (pattern dataset projection-indicator
	&optional (ontime-index 0) (finger-index 1)
	(height-index 2) (duration-index 3))
  (if (equal
       (nth duration-index projection-indicator) 1)
    (nth-lists-of-lists
     (list ontime-index duration-index)
     pattern)
    (if (and
	 (equal
	  (nth finger-index
	       projection-indicator) 1)
	 (equal
	  (nth height-index
	       projection-indicator) 1))
      (events-with-these-ontime-finger-heights
       pattern dataset
       finger-index height-index duration-index)
      (if (equal
	   (nth finger-index
		projection-indicator) 1)
	(events-with-these-ontime-others
	 pattern dataset finger-index duration-index)
	(events-with-these-ontime-others
	 pattern dataset
	 height-index duration-index)))))

#| Example:
(pattern-shadow
 '((6 63 62) (7 96 69) (9 112 78))
 '((23/4 86 74 1/4) (6 55 57 1/2) (6 63 62 1/3)
   (6 63 62 1/2) (7 95 69 1) (7 96 69 1/2) (7 96 70 1)
   (7 108 74 3/2) (17/2 109 75 1/2) (9 95 68 1)
   (9 98 69 1) (9 102 71 1) (9 112 78 3/4))
 '(1 1 1 0))
gives
7/15.

Indeed. |#

(defun pattern-shadow
       (pattern dataset projection-indicator &optional
	(ontime-index 0) (finger-index 1)
	(height-index 2) (duration-index 3)
	(sorted-on-offs
	 (sort-by
	  (list
	   (list 0 "asc")
	   (list 1 "desc"))
	  (ontime-durations2on-offs
	   (ontime-durations-for-projected-pattern
	    pattern dataset projection-indicator
	    ontime-index finger-index
	    height-index duration-index)))))
  (/ (shadow-numerator sorted-on-offs)
     (- (first (my-last sorted-on-offs))
	(first (first sorted-on-offs)))))

#| Example:
(shadow-numerator
 '((6 1) (6 1) (19/3 0) (13/2 0) (7 1) (7 1) (15/2 0)
   (8 0) (9 1) (39/4 0)))
gives
9/4.

Indeed. |#

(defun shadow-numerator
       (sorted-on-offs &optional
	(n (length sorted-on-offs)) (m 0)
	(i 0) (j 0)
	(x (first (first sorted-on-offs)))
	(numerator 0))
  (if (> m n) (identity numerator)
    (if (and (> i 0) (equal i j))
      (shadow-numerator
       sorted-on-offs n (+ m 1) (+ i 1) j
       (first (nth m sorted-on-offs))
       (+ numerator
	  (- (first (nth (- m 1) sorted-on-offs))
	     x)))
      (if (equal (second (nth m sorted-on-offs)) 1)
	(shadow-numerator
	 sorted-on-offs n (+ m 1) (+ i 1) j
	 x numerator)
	(shadow-numerator
	 sorted-on-offs n (+ m 1) i (+ j 1)
	 x numerator)))))



