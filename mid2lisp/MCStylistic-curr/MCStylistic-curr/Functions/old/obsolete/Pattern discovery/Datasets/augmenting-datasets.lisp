#| Tom Collins
   Monday 16 August 2010
   Incomplete

These functions are designed to augment artificially
created datasets with unique uniformly distributed
pseudo-random numbers. |#

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
  "/set-operations.lisp"))

#|
\noindent Example:
\begin{verbatim}
(augment-dataset-with-unique-randoms
 '((1 6) (2 6) (3 6) (4 4) (4 5) (5 6))
 12 10)
--> ((1 1) (1 4) (1 6) (2 5) (2 6) (3 6) (4 4) (4 5)
     (4 10) (5 6) (7 8) (10 10)).
\end{verbatim}

\noindent This function augments a given dataset
(first argument) to a dataset of specified overall
length (second argument) by sampling without
duplication from a k-dimensional subset of the natural
numbers, the maximum value possible being the third
argument.

If the desired overall length is greater
than or equal to $(\text{max} + 1)^k$ then this will
not be possible without duplication. And if the length
of the dataset is already greater than or equal to the
overall length then no augmentation is required. In
both instances the original dataset is returned
unaltered. |#

(defun augment-dataset-with-unique-randoms
       (dataset overall-length max &optional
        (rs (make-random-state t))
        (k (length (first dataset)))
        (n (length dataset))
        (probe
         (add-to-list
          1 (runif-in-k-natural-space k max rs))))
  (if (or (>= n overall-length)
          (>= overall-length (expt (+ max 1) k)))
    (identity dataset)
    (if (index-item-1st-occurs probe dataset)
      (augment-dataset-with-unique-randoms
       dataset overall-length max rs k n)
      (augment-dataset-with-unique-randoms
       (insert-retaining-sorted-asc probe dataset)
       overall-length max rs k (+ n 1)))))

#|
\noindent Example:
\begin{verbatim}
(runif-in-k-natural-space 3 11)
--> (3 0 10).
\end{verbatim}

\noindent This function generates a uniformly
distributed pseudo-random number in k-dimensional
natural space, where k is the first argument. The
second argument specifies the range of this space, so
in the example naturals in the range [0 10] may be
returned. |#

(defun runif-in-k-natural-space
       (k max &optional (rs (make-random-state t)))
  (if (<= k 0) ()
    (cons
     (random max rs)
     (runif-in-k-natural-space (- k 1) max rs))))

#|
\noindent Example:
\begin{verbatim}
(scale&round-list-by '(3 4 13/3 10) 3/2)
--> (4 6 6 15).
\end{verbatim}

\noindent This function multiplies each member of a
list (the first argument) by a constant (the second
argument), and then rounds the answer to the nearest
integer. Halves are rounded to the nearest even
integer. |#

(defun scale&round-list-by (a-list scale-factor)
  (mapcar
   #'(lambda (x) (round (* x scale-factor))) a-list))

#|
\noindent Example:
\begin{verbatim}
(scale&round-lists-by '((3 4 13/3 10) (1 2 3)) 3/2)
--> ((4 6 6 15) (2 3 4)).
\end{verbatim}

\noindent This function applies the function
scale&round-list-by recursively to a list of lists. |#

(defun scale&round-lists-by
       (a-list-of-lists scale-factor)
  (mapcar
   #'(lambda (x)
       (scale&round-list-by x scale-factor))
   a-list-of-lists))
