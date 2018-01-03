#| Tom Collins
   Monday 4 January 2010
   Incomplete Tuesday 19 January 2010

Test rating the trawled patterns. |#

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
