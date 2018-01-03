#| Tom Collins
   Monday 4 January 2010
   Incomplete

Rate the patterns saved in penultimate. |#

#| These opening examples are for small sets, to
demonstrate the functions rassoc and time.

(in-package :common-lisp-user)
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load
 "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/midi-save2.lisp")
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern matching"
  "/SIA-preliminaries.lisp"))
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern matching"
  "/SIA-specific.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/pattern-interest-preliminaries.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/pattern-evaluation-heuristics.lisp"))

|#

#| Example:
(setq
 lil-pattern
 '((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2)
   (2 84 74 2) (5/2 67 64 1/2) (3 64 62 1/2)
   (7/2 60 60 1/2)))
(setq
 lil-dataset
 '((0 48 53 2) (1/2 72 67 1/2) (1 76 69 1/2)
   (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2) 
   (3 64 62 1/2) (7/2 60 60 1/2) (4 36 46 2)
   (9/2 72 67 1/2) (5 76 69 1/2) (11/2 79 71 1/2)
   (6 84 74 2) (13/2 67 64 1/2) (7 64 62 1/2)
   (15/2 60 60 1/2) (8 36 46 2) (17/2 72 67 1/2)
   (9 76 69 1/2) (19/2 79 71 1/2)))
(setq
 lil-dataset-palette
 (orthogonal-projection-not-unique-equalp
  lil-dataset
  (append
   (list 0)
   (constant-vector
    1
    (- (length (first lil-pattern)) 1)))))
(setq
 lil-empirical-mass
 (empirical-mass lil-dataset-palette))

(setq
 pattern-hash
 (evaluate-variables-of-pattern
  lil-pattern lil-dataset 20 lil-dataset-palette
  lil-empirical-mass
  '(4.277867 3.422478734 -0.038536808 0.651073171)
  '(73.5383283152 0.02114878519) 1))
gives a hash table called pattern-hash.

This function evaluates variables of the supplied
pattern, such as cardinality and expected
occurrences. |#

#| Older fuller version that created a hash table.
(defun evaluate-variables-of-pattern
       (pattern dataset length-dataset dataset-palette
	empirical-mass coefficients norm-coeffs index
	&optional
	(name
	 (concatenate
	  'string "pattern " (write-to-string index)))
	(cardinality (length pattern))
	(translators
	 (translators-of-pattern-in-dataset
	  pattern dataset))
	(occurrences (length translators))
	(region
	 (subseq
	  dataset
	  (index-item-1st-occurs
	   (first pattern) dataset)
	  (+ (index-item-1st-occurs
	      (my-last pattern) dataset) 1)))
	(span (length region))
	(compactness (/ cardinality span))
	(coverage
	 (coverage pattern translators dataset t t))
	(compression-ratio
	 (/ coverage
	    (- (+ cardinality occurrences) 1)))
	(K
	 (+
	  (choose span cardinality)
	  (*
	   (- length-dataset cardinality)
	   (choose
	    (- span 1) (- cardinality 1)))))
	(expected-occurrences
	 (* (first norm-coeffs)
	    (expt
	     (*
	      K
	      (likelihood-of-pattern-or-translation
	       pattern dataset-palette
	       empirical-mass))
	     (second norm-coeffs))))
	(rating
	 (+ (first coefficients)
	    (* (second coefficients) compactness)
	    (* (third coefficients)
	       expected-occurrences)
	    (* (fourth coefficients)
	       compression-ratio)))
	(pattern-hash
	 (make-hash-table :test #'equal)))
  (setf (gethash '"index" pattern-hash) index)
  (setf (gethash '"name" pattern-hash) name)
  (setf
   (gethash '"cardinality" pattern-hash) cardinality)
  (setf
   (gethash '"occurrences" pattern-hash) occurrences)
  (setf (gethash '"rating" pattern-hash) rating)
  (setf
   (gethash '"compactness" pattern-hash) compactness)
  (setf
   (gethash '"expected occurrences" pattern-hash)
   expected-occurrences)
  (setf
   (gethash '"compression ratio" pattern-hash)
   compression-ratio)
  (setf (gethash '"pattern" pattern-hash) pattern)
  (setf (gethash '"region" pattern-hash) region)
  (setf
   (gethash '"translators" pattern-hash) translators)
  (identity pattern-hash))
|#

#| This version returns the rating only. |#
(defun evaluate-variables-of-pattern
       (pattern dataset length-dataset dataset-palette
	empirical-mass coefficients norm-coeffs index
	&optional
	(name
	 (concatenate
	  'string "pattern " (write-to-string index)))
	(cardinality (length pattern))
	(translators
	 (translators-of-pattern-in-dataset
	  pattern dataset))
	(occurrences (length translators))
	(region
	 (subseq
	  dataset
	  (index-item-1st-occurs
	   (first pattern) dataset)
	  (+ (index-item-1st-occurs
	      (my-last pattern) dataset) 1)))
	(span (length region))
	(compactness (/ cardinality span))
	(coverage
	 (coverage pattern translators dataset t t))
	(compression-ratio
	 (/ coverage
	    (- (+ cardinality occurrences) 1)))
	(K
	 (+
	  (choose span cardinality)
	  (*
	   (- length-dataset cardinality)
	   (choose
	    (- span 1) (- cardinality 1)))))
	(expected-occurrences
	 (* (first norm-coeffs)
	    (expt
	     (*
	      K
	      (likelihood-of-pattern-or-translation
	       pattern dataset-palette
	       empirical-mass))
	     (second norm-coeffs))))
	(rating
	 (+ (first coefficients)
	    (* (second coefficients) compactness)
	    (* (third coefficients)
	       expected-occurrences)
	    (* (fourth coefficients)
	       compression-ratio))))
  (list rating index))

#| Example:
(progn
  (setq
   patterns
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/Write to files"
     "/L 1 (1 1 1 1 0) penultimate 1.txt")))
  (setq
   a-few-patterns
   (firstn 5 patterns))
  (load
   (concatenate
    'string
    "/Users/tec69/Open/Music/Director musices/"
    "L 1.lisp"))
  (setq
   projected-dataset
   (orthogonal-projection-unique-equalp
    dataset '(1 1 1 1 0)))
  (identity "read."))

(time
 (setq
  patterns-hash
  (evaluate-variables-of-patterns
   a-few-patterns projected-dataset)))
gives a list consisting of hash tables.

This function applies the function evaluate-variables-
of-pattern recursively to a list of patterns. Notice
that each pattern is itself contained in a list of
length 1 because of the use of assoc by a previous
function.

Currently (5/1/2010) the example takes 31.33102 
seconds to run, so just over 6 seconds per pattern!

(setq
 a-few-patterns
 (firstn 30 patterns))
(time
 (setq
  ratings
  (evaluate-variables-of-patterns
   a-few-patterns projected-dataset)))
(setq
 results
 (sort-by '((0 "desc")) ratings))

Currently (5/1/2010) this example takes 192.2908
seconds to run. Given that there are 3434 patterns to
rate over all, we are looking at a run time of approx
6 hrs 7 mins!
|#

(defun evaluate-variables-of-patterns
       (patterns dataset &optional
	(coefficients
	 (list 4.277867 3.422478734 -0.038536808
	       0.651073171))
	(norm-coeffs
	 (list 73.5383283152 0.02114878519))
	(length-dataset (length dataset))
	(dataset-palette
	 (orthogonal-projection-not-unique-equalp
	  dataset
	  (append
	   (list 0)
	   (constant-vector
	    1
	    (- (length (first dataset)) 1)))))
	(empirical-mass
	 (empirical-mass dataset-palette))
	(index 0)
	(pattern (first (first patterns))))
  (if (null pattern) ()
    (cons
     (evaluate-variables-of-pattern
      pattern dataset length-dataset dataset-palette
      empirical-mass coefficients norm-coeffs index)
     (evaluate-variables-of-patterns
      (rest patterns) dataset coefficients norm-coeffs
      length-dataset dataset-palette empirical-mass
      (+ index 1)))))

#| Example:
(likelihood-of-pattern-or-translation
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3)
   (3 60 60 1))
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1)
   (62 61 1) (64 62 1/2) (66 63 1/3) (62 61 1)
   (69 65 3) (59 59 1) (60 60 1))
 '(((60 60 1) 3/11) ((59 59 1) 1/11) ((69 65 3) 1/11)
   ((62 61 1) 2/11) ((66 63 1/3) 1/11)
   ((64 62 1/2) 1/11) ((64 62 1/3) 1/11)
   ((62 61 1/2) 1/11)))
gives
9/14641 + 4/14641 = 13/14641.

This function takes a pattern and the dataset in which
the pattern occurs. It calculates the potential
translations of the pattern in the dataset and returns
the sum of their likelihoods. NB the order (and
mandate) of the arguments is different to the original
version of this function. |#

(defun likelihood-of-pattern-or-translation
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
    (likelihood-of-pattern-or-translation
     pattern dataset-palette empirical-mass
     pattern-palette (rest potential-translations)
     (+ result
        (likelihood-of-subset
         (translation pattern-palette
                      (first potential-translations))
         empirical-mass)))))


