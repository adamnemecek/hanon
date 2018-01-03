#| Tom Collins
   Monday 4 January 2010
   Incomplete Tuesday 19 January 2010

These functions are useful for determining whether a
discovered pattern is noticeable/important.
Compactness and coverage are as defined in Meredith
et al. (2003), and the function likelihood-of-
translations-reordered helps to adapt a formula from
Conklin and Bergeron (2008) for expected
occurrences. |#

; REQUIRED PACKAGES
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/geometric-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/pattern-importance-preliminaries"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/set-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))

#|
\noindent Example:
\begin{verbatim}
(compactness
 '((1 2) (2 4)) '((1 2) (2 -1) (2 4) (3 6) (5 2))
 "lexicographic")
--> 2/3

(setq
 dataset-sorted
 '((-4.13 -2.62) (-3.89 -4.13) (-3.82 2.71)
   (-2.67 0.32) (-2.65 -3.48) (-1.71 -1.13)
   (-1.33 0.3) (-1.3 -4.0) (0.83 1.41) (1.27 -3.95)
   (1.4 -2.94) (1.53 0.51) (1.83 2.89) (1.85 -0.94)
   (2.22 -2.93) (2.34 2.81) (2.4 -0.15) (2.49 -2.71)
   (3.66 -2.05) (4.7 -3.99)))
(setq
 pattern-sorted
 '((-2.67 0.32) (-2.65 -3.48) (-1.71 -1.13)
   (1.27 -3.95) (1.4 -2.94) (1.53 0.51) (3.66 -2.05)))
(compactness
 pattern-sorted dataset-sorted "lexicographic")
--> 7/16.

(compactness
 pattern-sorted dataset-sorted "convex hull")
--> 7/11.
\end{verbatim}

\noindent The ratio of the number of points in the
pattern to the number of points in the region spanned
by the pattern. Both pattern and dataset are assumed
to be sorted ascending. At present two definitions of
region ("lexicographic" and "convex hull") are
admissible.

There is a plot for the above example in the Example
Files folder, entitled convex_hull.pdf. NB we define
region as the lexicographic region first, as a point
is in the convex hull of the pattern only if it is in
its lexicographic region (ought to prove this
assertion). This avoids determining in-polygonp for
each point in the dataset, which would require more
time I think. |#

(defun compactness
       (pattern projected-dataset &optional
	(region-type "lexicographic")
        (length-pattern (length pattern))
        (region
         (subseq
          projected-dataset
          (index-item-1st-occurs
           (first pattern) projected-dataset)
          (+ (index-item-1st-occurs
              (my-last pattern) projected-dataset)
             1))))
  (if (string= region-type "lexicographic")
    (/ length-pattern (length region))
    (/
     length-pattern
     (+
      length-pattern
      (length
       (points-in-convex-hull
        pattern
        (set-difference-multidimensional-sorted-asc
         region pattern)))))))

#| Old version
(defun compactness
       (pattern projected-dataset &optional
	(region "straight down")
        (length-pattern (length pattern))
	(span
	 (if (equalp region "straight down")
	   (+
	    (-
	     (index-item-1st-occurs
	      (my-last pattern) projected-dataset)
	     (index-item-1st-occurs
	      (first pattern)
              projected-dataset)) 1))))
  (/ length-pattern span))
|#

#|
\noindent Example:
\begin{verbatim}
(coverage
 '((1 2) (2 4)) '((0 0) (1 2))
 '((1 2) (2 4) (3 6) (5 2) (6 1)) t t)
--> 3.
\end{verbatim}

\noindent The number of datapoints in the dataset that
are members of occurrences of the pattern. |#

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

#|
\noindent Example:
\begin{verbatim}
(coverage-mod-2nd-n
 '((1 2) (2 4)) '((0 0) (1 2))
 '((1 2) (2 4) (3 6) (5 2) (6 1)) 12 t t)
--> 3.
\end{verbatim}

\noindent The number of datapoints in the dataset that
are members of occurrences of the pattern.
Translations are carried out modulo the fourth
argument. |#

(defun coverage-mod-2nd-n
       (pattern translators
	projected-dataset n &optional
	(membership-assumption nil)
	(first-sorted nil))
  (if membership-assumption
    (length
     (unions-multidimensional-sorted-asc
      (translations-mod-2nd-n pattern translators n)
      first-sorted))
    (length
     (intersection-multidimensional
      (unions-multidimensional-sorted-asc
       (translations-mod-2nd-n pattern translators n)
       first-sorted)
      projected-dataset))))

#|
\noindent Example:
\begin{verbatim}
(index-two-lists-1st-not-equalp
 '((1 2) (2 4) (3 6)) '((1 2) (2 4) (2 5) (3 6)))
--> 2.
\end{verbatim}

\noindent The arguments to this function are two
lists. Element by element, the lists are checked
using equalp, and the index at which they first
differ is returned, or nil otherwise. |#

(defun index-two-lists-1st-not-equalp
       (a-list b-list &optional (i 0))
  (if (not (and a-list b-list))
    (if (or a-list b-list) (identity i))
    (if (equalp (first a-list) (first b-list))
      (index-two-lists-1st-not-equalp
       (rest a-list) (rest b-list) (+ i 1))
      (identity i))))

#|
\noindent Example:
\begin{verbatim}
(likelihood-of-translations-reordered
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3)
   (3 60 60 1))
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1)
   (62 61 1) (64 62 1/2) (66 63 1/3) (62 61 1)
   (69 65 3) (59 59 1) (60 60 1))
 '(((60 60 1) 3/11) ((59 59 1) 1/11) ((69 65 3) 1/11)
   ((62 61 1) 2/11) ((66 63 1/3) 1/11)
   ((64 62 1/2) 1/11) ((64 62 1/3) 1/11)
   ((62 61 1/2) 1/11)))
--> 9/14641 + 4/14641 = 13/14641.
\end{verbatim}

\noindent This function takes a pattern and the
dataset in which the pattern occurs. It calculates the
potential translations of the pattern in the dataset
and returns the sum of their likelihoods. NB the order
(and mandate) of the arguments is different to the
original version of this function, which is called
likelihood-of-pattern-or-translation. |#

(defun likelihood-of-translations-reordered
       (pattern dataset-palette empirical-mass
	&optional
        (pattern-palette
         (orthogonal-projection-not-unique-equalp
          pattern
          (append
           (list 0)
           (constant-vector
            1
            (- (length (first pattern)) 1)))))
        (potential-translations
         (direct-product-of-n-sets
          (potential-n-dim-translations
           (rest (first pattern)) dataset-palette)))
        (result 0))
  (if (null potential-translations) (identity result)
    (likelihood-of-translations-reordered
     pattern dataset-palette empirical-mass
     pattern-palette (rest potential-translations)
     (+ result
        (likelihood-of-subset
         (translation pattern-palette
                      (first potential-translations))
         empirical-mass)))))

