#| Tom Collins
   Wednesday 13 January 2010
   Incomplete

Yes dred. |#

(in-package :common-lisp-user)

(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/markov-compose.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-preliminaries.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-specific.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-scaling.lisp")
|#

#| Example:
(compactness
 '((1 2) (2 4)) '((1 2) (2 -1) (2 4) (3 6) (5 2))
 0.2 1 "straight down")
gives
2/3.

The ratio of the number of points in the pattern to
the number of points in the region spanned by the
pattern. Both pattern and dataset are assumed to be
sorted ascending. At present the only admissible
definition of region is "straight down". |#

(defun compactness
       (pattern projected-dataset &optional
	(min 0.25) (max 1) (region "straight down")
        (length-pattern (length pattern))
	(span
	 (if (equalp region "straight down")
	   (+
	    (-
	     (index-item-1st-occurs
	      (my-last pattern) projected-dataset)
	     (index-item-1st-occurs
	      (first pattern) projected-dataset)) 1)))
	(result (/ length-pattern span)))
  (if (< result min)
    (identity 0)
    (if (< result max)
      (identity result)
      (identity max))))

#| Example:
(compactness-max
 '((1 2) (2 4)) '((0 0) (1 2) (3 -2))
 '((1 2) (2 -1) (2 0) (2 4) (3 0) (3 1) (3 3) (3 6)
   (4 0) (5 1) (5 2))
 0.2 1 "straight down" 2)
gives
2/3.

The function compactness is applied to each
occurrence of a pattern and the maximum compactness
returned. |#

(defun compactness-max
       (pattern translators projected-dataset
	&optional (min 0.25) (max 1)
	(region "straight down")
        (length-pattern (length pattern))
	(overall 0)
	(current
	 (if translators
	   (compactness
	    (translation pattern (first translators))
	    projected-dataset min max region
            length-pattern))))
  (if (null current)
    (identity overall)
    (if (>= overall max)
      (identity max)
      (compactness-max
       pattern (rest translators) projected-dataset
       min max region length-pattern
       (max current overall)))))

#| Example:
(compression-ratio
 '((1 2) (2 4)) '((0 0) (1 2) (3 -2))
 '((1 2) (2 -1) (2 0) (2 4) (3 0) (3 1) (3 3) (3 6)
   (4 0) (5 1) (5 2))
 0.2 1 5)
gives
1.

The compression ratio that can be achieved by
representing the set of points covered by all
occurrences of a pattern by specifying just one
occurrence of the pattern together with all the non-
zero vectors by which the pattern in translatable
within the dataset. |#

(defun compression-ratio
       (pattern translators projected-dataset
                &optional (min 0.25) (max 1)
                (membership-assumption nil)
                (first-sorted nil)
                (length-pattern (length pattern))
                (length-translators (length translators))
                (coverage-calculated
                 (coverage
                  pattern translators projected-dataset
                  membership-assumption first-sorted))
                (result
                 (/ coverage-calculated
                    (-
                     (+ length-pattern
                        length-translators) 1))))
  (if (< result min)
    (identity 0)
    (if (< result max)
      (identity result)
      (identity max))))

#| Example:
(cover-ratio
 '((1 2) (2 4)) '((0 0) (1 2))
 '((1 2) (2 4) (3 6) (5 2) (6 1)) 0.2 t t)
gives
3/5.

The ratio between the number of uncovered datapoints
in the dataset that are members of occurrences of the
pattern, to the total number of uncovered datapoints
in the dataset. |#

(defun cover-ratio
       (pattern translators projected-dataset
	&optional (min 0.2)
	(membership-assumption nil) (first-sorted nil)
	(coverage-calculated
	 (coverage
	  pattern translators projected-dataset
	  membership-assumption first-sorted))
	(length-dataset (length projected-dataset))
	(result
	 (/ coverage-calculated
	    length-dataset)))
  (if (< result min) (identity 0) (identity result)))

#| Example:
(coverage
 '((1 2) (2 4)) '((0 0) (1 2))
 '((1 2) (2 4) (3 6) (5 2) (6 1)) t t)
gives
3.

The number of datapoints in the dataset that are
members of occurrences of the pattern. |#

(defun coverage
       (pattern translators
	projected-dataset &optional
	(membership-assumption nil)
	(first-sorted nil))
  (if membership-assumption
    (length
     (unions-multidimensional-sorted-asc
      (translations pattern translators)
      first-sorted))
    (length
     (intersection-multidimensional
      (unions-multidimensional-sorted-asc
       (translations pattern translators)
		     first-sorted)
      projected-dataset))))

#| Example:
(COVSIATEC
 '((((0 61) (4 62)) ((0 0) (0 4) (1 3) (12 -5)))
   (((0 61) (4 62) (8 60)) ((0 0) (0 4) (1 3)))
   (((0 61) (0 65) (1 64) (8 60)) ((0 0) (8 -1)))
   (((4 62) (8 60)) ((0 0) (0 4) (1 3) (11 3)))
   (((0 65) (8 64)) ((0 -4) (0 0) (1 -1) (8 -5)))
   (((0 61) (0 65) (1 64) (12 56)) ((0 0) (4 1)))
   (((4 62) (4 66) (5 65) (15 65)) ((0 0) (4 -2)))
   (((15 65) (17 64)) ((0 0) (2 -1))))
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63)
   (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 0.2 0.25 1 0.25 1 "straight down")
gives
((((0 61) (0 65) (1 64) (8 60)) ((0 0) (8 -1)))
 (((0 61) (4 62)) ((0 0) (0 4) (1 3) (12 -5)))
 (((4 62) (8 60)) ((0 0) (0 4) (1 3) (11 3)))
 (((0 61) (4 62) (8 60)) ((0 0) (0 4) (1 3)))
 (((4 62) (4 66) (5 65) (15 65)) ((0 0) (4 -2)))
 (((0 61) (0 65) (1 64) (12 56)) ((0 0) (4 1)))).

In the example given the COVSIATEC algorithm is applied
to the Fantasia dataset. The SIATEC algorithm has been
applied already, and the first argument is the pairs from this
application, NB the equivalence class consisting of one
datapoint has been removed. |#

(defun COVSIATEC
       (pairs projected-dataset &optional
        (cover-ratio-min 0.2)
        (compression-ratio-min 0.25)
        (compression-ratio-max 1)
        (compactness-max-min 0.25)
        (compactness-max-max 1)
        (region "straight down")
        (musicological-heuristics-calculated
         (musicological-heuristics
          pairs projected-dataset
          compression-ratio-min compression-ratio-max
          compactness-max-min compactness-max-max
          region (length projected-dataset)))
        (cover nil)
        (cover-ratios
         (normalise-0-1
          (nth-list-of-lists
           0
           (heuristics-pattern-translators-pairs
            pairs projected-dataset '(nil t nil nil nil nil)
            cover-ratio-min compression-ratio-min
            compression-ratio-max compactness-max-min
            compactness-max-max region))))
        (maximiser-argmaximiser
         (max-argmax
          (multiply-two-lists
           (multiply-two-lists
            (first musicological-heuristics-calculated)
            (second musicological-heuristics-calculated))
           cover-ratios)))
        (maximiser (first maximiser-argmaximiser))
        (argmaximiser (second maximiser-argmaximiser)))
  (if (or (equal maximiser 0)
          (null projected-dataset)
          (null pairs))
    (identity cover)
    (COVSIATEC
     (remove-nth argmaximiser pairs)
     (set-difference-multidimensional
      projected-dataset
      (unions-multidimensional-sorted-asc
       (translations
        (first (nth argmaximiser pairs))
        (second (nth argmaximiser pairs))) t))
     cover-ratio-min compression-ratio-min
     compression-ratio-max compactness-max-min
     compactness-max-max region
     (list
      (remove-nth argmaximiser
                  (first musicological-heuristics-calculated))
      (remove-nth argmaximiser
                  (second musicological-heuristics-calculated)))
     (append
      cover
      (list (nth argmaximiser pairs))))))

#| Example:
(heuristics-pattern-translators-pair
 '((1 2) (2 4)) '((0 0) (1 2) (3 -2))
 '((1 2) (2 -1) (2 0) (2 4) (3 0) (3 1) (3 3) (3 6)
   (4 0) (5 1) (5 2)) '(t t t t t t)
   0.2 0.25 1 0.25 1 "straight down" 11)
gives
(5 5/11 1 2/3 2 3).

A pattern and its translators in a projected
dataset are supplied as arguments to this function,
along with an indicator vector that indicates
which heuristics out of coverage, cover-ratio,
compression-ratio, compactness, |P| and |T(P, D)|
should be calculated. |#

(defun heuristics-pattern-translators-pair
       (pattern translators projected-dataset
        heuristics-indicator &optional
        (cover-ratio-min 0.2)
        (compression-ratio-min 0.25)
        (compression-ratio-max 1)
        (compactness-max-min 0.25)
        (compactness-max-max 1)
        (region "straight down")
        (length-dataset
         (if (second heuristics-indicator)
           (length projected-dataset)))
        (coverage-calculated
         (if (or (first heuristics-indicator)
                 (second heuristics-indicator)
                 (third heuristics-indicator))
           (coverage pattern translators
                     projected-dataset nil t)))
        (length-pattern
         (if (or (third heuristics-indicator)
                 (fourth heuristics-indicator)
                 (fifth heuristics-indicator))
           (length pattern)))
        (length-translators
         (if (or (third heuristics-indicator)
                 (sixth heuristics-indicator))
           (length translators))))
  (append
   (if (first heuristics-indicator)
     (list coverage-calculated))
   (if (second heuristics-indicator)
     (list (cover-ratio
            pattern translators projected-dataset
            cover-ratio-min nil t
            coverage-calculated length-dataset)))
   (if (third heuristics-indicator)
     (list (compression-ratio
            pattern translators projected-dataset
            compression-ratio-min
            compression-ratio-max nil t
            length-pattern length-translators
            coverage-calculated)))
   (if (fourth heuristics-indicator)
     (list (compactness-max
            pattern translators projected-dataset
            compactness-max-min
            compactness-max-max region
            length-pattern)))
   (if (fifth heuristics-indicator)
     (list length-pattern))
   (if (sixth heuristics-indicator)
     (list length-translators))))

#| Example:
(heuristics-pattern-translators-pairs
 '((((1 2) (2 4)) ((0 0) (1 2) (3 -2)))
   (((1 2) (2 0)) ((0 0) (2 0))))
 '((1 2) (2 -1) (2 0) (2 4) (3 0) (3 1) (3 2) (3 6)
   (4 0) (5 1) (5 2)) '(t t t t t t)
   0.2 0.25 1 0.25 1 "straight down" 11)
gives
((5 5/11 1 2/3 2 3) (4 4/11 1 2/3 2 2)).

The function heuristics-pattern-translators-pair is
applied recursively to pairs of pattern-
translators. |#

(defun heuristics-pattern-translators-pairs
       (pairs projected-dataset
        heuristics-indicator &optional
        (cover-ratio-min 0.2)
        (compression-ratio-min 0.25)
        (compression-ratio-max 1)
        (compactness-max-min 0.25)
        (compactness-max-max 1)
        (region "straight down")
        (length-dataset
         (length projected-dataset)))
  (if (null pairs) ()
    (cons
     (heuristics-pattern-translators-pair
      (first (first pairs)) (second (first pairs))
      projected-dataset heuristics-indicator
      cover-ratio-min compression-ratio-min
      compression-ratio-max compactness-max-min
      compactness-max-max region length-dataset)
     (heuristics-pattern-translators-pairs
      (rest pairs) projected-dataset
      heuristics-indicator cover-ratio-min
      compression-ratio-min compression-ratio-max
      compactness-max-min compactness-max-max
      region length-dataset))))

#| Example:
(multiply-two-lists '(4 7 -3) '(8 -2 -3))
gives
(32 -14 9).

Multiplies two lists element-by-element. It is assumed
that elements of list arguments are numbers, and the
list arguments are of the same length. An empty
first (but not second) argument will be
tolerated. |#

(defun multiply-two-lists (a-list b-list)
  (if (null a-list) ()
    (cons (* (first a-list) (first b-list))
          (multiply-two-lists (rest a-list)
                         (rest b-list)))))

#| Example:
(musicological-heuristics
 '((((1 2) (2 4)) ((0 0) (1 2) (3 -2)))
   (((1 2) (2 0)) ((0 0) (2 0)))
   (((1 2) (2 4) (4 0)) ((0 0) (1 2) (2 -4))))
 '((1 2) (2 -1) (2 0) (2 4) (3 -2) (3 0) (3 1)
   (3 2) (3 6) (4 0) (5 1) (5 2) (6 -4))
 0.25 1 0.25 1 "straight down" 11)
gives
((1 1 1) (1 1 0)).

The function heuristics-pattern-translators-pairs
is applied to pattern-translator pairs with the
heuristics indicator set to compression ratio and
compactness (max). The values are normalised
(linearly) to [0, 1] and returned as two lists. |#

(defun musicological-heuristics
       (pairs projected-dataset &optional
        (compression-ratio-min 0.25)
        (compression-ratio-max 1)
        (compactness-max-min 0.25)
        (compactness-max-max 1)
        (region "straight down")
        (length-dataset
         (length projected-dataset))
        (heuristics-calculated
         (heuristics-pattern-translators-pairs
          pairs projected-dataset
          '(nil nil t t nil nil) 0.2
          compression-ratio-min
          compression-ratio-max
          compactness-max-min compactness-max-max
          region length-dataset)))
  (list
   (normalise-0-1
    (nth-list-of-lists 0 heuristics-calculated))
   (normalise-0-1
    (nth-list-of-lists 1 heuristics-calculated))))

#| Example:
(normalise-0-1 '(4 7 -3 2))
gives
(7/10 1 0 1/2).

Normalises data (linearly) to [0 1]. |#

(defun normalise-0-1
       (a-list &optional
        (min-a-list (min-item a-list))
        (max-a-list (max-item a-list)))
  (if (or
       (equal min-a-list max-a-list)
       (and (equal min-a-list 0)
             (equal max-a-list 1)))
    (identity a-list)
    (normalise-0-1-checks-done
     a-list min-a-list max-a-list)))

#| Example:
(normalise-0-1-checks-done '(4 7 -3 2))
gives
(7/10 1 0 1/2).

Normalises data (linearly) to [0 1], assuming that
the data is not constant and that the min and max
are not already 0, 1 respectively. |#

(defun normalise-0-1-checks-done
       (a-list min-a-list max-a-list &optional
        (denom (- max-a-list min-a-list)))
  (if (null a-list) ()
    (cons
     (/ (- (first a-list) min-a-list) denom)
     (normalise-0-1-checks-done
      (rest a-list) min-a-list max-a-list denom))))

#| Example:
(set-difference-multidimensional
 '((-3 2) (0 0) (4 7) (10 1) (10 2))
 '((4 2) (4 7) (5 6) (10 2)))
gives
((-3 2) (0 0) (10 1)).

Takes two sets A, B, as arguments (assumed ordered
ascending) of k-dimensional vectors. The set
difference
$A\backslash B = \{ x \in A \mid x \notin B \}$
is calculated. |#

(defun set-difference-multidimensional
       (a-list-of-vectors b-list-of-vectors
        &optional
        (first-vector (first a-list-of-vectors)))
  (if (null first-vector) ()
    (append
     (if (not (test-equal<list-elements
               b-list-of-vectors first-vector))
      (list first-vector))
     (set-difference-multidimensional
      (rest a-list-of-vectors)
      b-list-of-vectors))))

#| Example:
(translations
 '((1 2) (2 4)) '((0 0) (1 2)))
gives
(((1 2) (2 4)) ((2 4) (3 6))).

There are two arguments to this function, a pattern
and some translators. The pattern is translated by
each translator and the results returned. |#

(defun translations
       (pattern translators)
  (if (null translators) ()
    (cons
     (translation pattern (first translators))
     (translations pattern (rest translators)))))

#| Example:
(unions-multidimensional-sorted-asc
 '(((12 10) (0 0) (1 2)) ((0 0) (1 5)) ((6 6))))
gives
((0 0) (1 2) (1 5) (6 6) (12 10)).

The function union-multidimensional-sorted-asc is
applied recursively to a list of k-dimensional vector
sets. |#

(defun unions-multidimensional-sorted-asc
       (k-dimensional-sets &optional
	(first-sorted nil)
	(result
	 (if first-sorted
	   (first k-dimensional-sets)
	   (sort-dataset-asc
	    (first k-dimensional-sets)))))
  (if (<= (length k-dimensional-sets) 1)
    (identity result)
    (unions-multidimensional-sorted-asc
     (rest k-dimensional-sets) first-sorted
     (union-multidimensional-sorted-asc
      result (second k-dimensional-sets) t))))





