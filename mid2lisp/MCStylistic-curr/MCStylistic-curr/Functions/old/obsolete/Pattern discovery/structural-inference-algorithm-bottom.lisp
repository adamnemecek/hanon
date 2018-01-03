; From bottom of structural-inference-algorithm.

#| These examples are for small sets, to demonstrate
the functions rassoc and time.

(in-package :common-lisp-user)
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load
 "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")

(setq
 alist
 '(((2 0 0) . ((0 60 2) (1 61 1)))
   ((4 12 0) . ((0 60 2) (3 59 1)))))

(rassoc '((4 72 2) (7 71 1))
        alist :test #'test-translation)

(rassoc '((4 72 2) (7 71 1))
        alist
        :test #'test-translation-no-length-check)

(time (rassoc '((4 72 2) (7 71 1))
              alist :test #'test-translation))
(time
 (rassoc '((4 72 2) (7 71 1))
	 alist
	 :test #'test-translation-no-length-check))
|#


#| Not sure if these functions are needed.
\noindent Example:
\begin{verbatim}
(test-equal<list-elements-mod-2nd-n
 '((0 61) (0 62) (1 61) (3 64)) '(1 1) 12)
--> T.
\end{verbatim}

\noindent This function is similar in style to the
function test-equal<list-elements. The difference is
to do with the list of sublists. The second element of
each sublist is converted to modulo n before testing
commences.

(defun test-equal<list-elements-mod-2nd-n
       (a-list a-vector n &optional
        (i 0)
	(v1 (first a-vector))	
	(ith-a-list (nth i a-list))
	(v2 (if (null ith-a-list)
	      (identity v1)
	      (first (nth i a-list)))))
  (if (< v1 v2) ()
    (if (null ith-a-list) ()
      (if (and
           (equal (first a-vector) (first ith-a-list))
           (equal
            (second a-vector)
            (mod (second ith-a-list) n))
           (equal
            (rest (rest a-vector))
            (rest (rest ith-a-list))))
	(identity T)
	(test-equal<list-elements-mod-2nd-n
	 a-list a-vector n (+ i 1) v1)))))
|#
