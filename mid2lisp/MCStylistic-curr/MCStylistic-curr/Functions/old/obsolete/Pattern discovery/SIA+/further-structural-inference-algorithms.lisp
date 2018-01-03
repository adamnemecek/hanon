#| Tom Collins
   Monday 25 January 2010
   Incomplete

\noindent The functions below implement the SIATEC
(structural inference algorithm transational
equivalence classes) and COSIATEC (cover strucutral
inference algorithm equivalence classes) algorithms
(Meredith, 2006). |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIA+/evaluation-for-SIA+.lisp"))
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
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))

#|
\noindent Example:
\begin{verbatim}
(COSIATEC
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60)
   (8 64) (9 63) (12 56) (13 69) (15 65) (16 57)
   (16 59) (17 64) (19 63))
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery/SIA+"
  "/Write to files/Fantasia"))
--> Files in the specified location, especially
((((0 65)
   (4 66) (8 64)) (0 -4) (0 0) (1 -1))
 (((16 59))
  (-4 -3) (-3 10) (-1 6) (0 -2) (0 0) (1 5) (3 4))).
\end{verbatim}

\noindent Implementation of the COSIATEC algorithm. It
can be verified that the output above (pattern-
translators pairs) constitutes a cover of the Fantasia
dataset. |#

(defun COSIATEC
       (dataset prefix &optional (counter 1)
	(growing-list nil)
	(SIA-path&name
	 (concatenate
	  'string
	  prefix " SIA " (write-to-string counter)
	  ".txt"))
	(SIATEC-path&name
	 (concatenate
	  'string
	  prefix " SIATEC " (write-to-string counter)
	  ".txt"))
	(SIATEC-output
	 (if dataset
	   (progn
	     (SIA-reflected-for-COSIATEC
	      dataset SIA-path&name)
	     (SIATEC
	      (read-from-file SIA-path&name) dataset
	      SIATEC-path&name)
	     (read-from-file SIATEC-path&name))))
	(pattern&translators
	 (if SIATEC-output
	   (nth
	    (argmax-of-threeCs
	     (threeCs-pattern-translators-pairs
	      SIATEC-output dataset))
	    SIATEC-output))))
  (if (null pattern&translators)
    (write-to-file
     growing-list
     (concatenate 'string prefix " COSIATEC.txt"))
    (progn
      (print counter)
      (COSIATEC
       (remove-pattern-occurrences-from-dataset
	pattern&translators dataset)
       prefix (+ counter 1)
       (append
	growing-list (list pattern&translators))))))

#|
\noindent Example:
\begin{verbatim}
(COSIATEC-mod-2nd-n
 '((0 1) (0 5) (1 4) (4 2) (4 6) (5 5) (8 0)
   (8 4) (9 3) (12 8) (13 9) (15 5) (16 9)
   (16 11) (17 4) (19 3))
 12
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation"
  "/Example files/Fantasia-mod"))
--> Files in the specified location, especially
((((0 5) (4 6) (8 4))
  (0 8) (0 0) (1 11))
 (((16 11))
  (-4 9) (-3 10) (-1 6) (0 10) (0 0) (1 5) (3 4))).
\end{verbatim}

\noindent Implementation of the COSIATEC algorithm,
where translations in the second dimension are
performed modulo the second argument. It can be
verified that the output above (pattern-translators
pairs) constitutes a cover of the Fantasia dataset. |#

(defun COSIATEC-mod-2nd-n
       (dataset n prefix &optional (counter 1)
	(growing-list nil)
	(SIA-path&name
	 (concatenate
	  'string
	  prefix " SIA " (write-to-string counter)
	  ".txt"))
	(SIATEC-path&name
	 (concatenate
	  'string
	  prefix " SIATEC " (write-to-string counter)
	  ".txt"))
	(SIATEC-output
	 (if dataset
	   (progn
	     (SIA-reflected-for-COSIATEC-mod-2nd-n
	      dataset n SIA-path&name)
	     (SIATEC-mod-2nd-n
	      (read-from-file SIA-path&name) dataset n
	      SIATEC-path&name)
	     (read-from-file SIATEC-path&name))))
	(pattern&translators
	 (if SIATEC-output
	   (nth
	    (argmax-of-threeCs
	     (threeCs-pattern-trans-pairs-mod-2nd-n
	      SIATEC-output dataset n))
	    SIATEC-output))))
  (if (null pattern&translators)
    (write-to-file
     growing-list
     (concatenate 'string prefix " COSIATEC.txt"))
    (progn
      (print counter)
      (COSIATEC-mod-2nd-n
       (remove-pattern-occs-from-dataset-mod-2nd-n
	pattern&translators dataset n)
       n prefix (+ counter 1)
       (append
	growing-list (list pattern&translators))))))

#|
\noindent Example:
\begin{verbatim}
(remove-pattern-occurrences-from-dataset
 '(((0 60) (1 61)) (0 0) (1 1) (4 -1))
 '((0 60) (1 61) (2 62) (3 60) (4 59) (5 60) (6 57)))
--> ((3 60) (6 57)).
\end{verbatim}

\noindent All of the datapoints that are members of
occurrences of a given pattern are calculated. These
datapoints are then removed from the dataset (calling
the function set-difference-multidimensional-sorted-
asc), and the new dataset returned. |#

(defun remove-pattern-occurrences-from-dataset
       (pattern&translators dataset &optional
	(to-be-removed
	 (unions-multidimensional-sorted-asc
	  (translations
	   (car pattern&translators)
	   (cdr pattern&translators)))))
  (set-difference-multidimensional-sorted-asc
   dataset to-be-removed))

#|
\noindent Example:
\begin{verbatim}
(remove-pattern-occs-from-dataset-mod-2nd-n
 '(((0 0) (1 1)) (0 0) (1 1) (4 11))
 '((0 0) (1 1) (2 2) (3 0) (4 11) (5 0) (6 9))
 12)
--> ((3 0) (6 9)).
\end{verbatim}

\noindent All of the datapoints that are members of
occurrences of a given pattern are calculated, where
translations in the second dimension are carried out
modulo the third argument. These datapoints are then
removed from the dataset (calling the function set-
difference-multidimensional-sorted-asc), and the new
dataset returned. |#

(defun remove-pattern-occs-from-dataset-mod-2nd-n
       (pattern&translators dataset n &optional
	(to-be-removed
	 (unions-multidimensional-sorted-asc
	  (translations-mod-2nd-n
	   (car pattern&translators)
	   (cdr pattern&translators) n))))
  (set-difference-multidimensional-sorted-asc
   dataset to-be-removed))

#|
\noindent Example:
\begin{verbatim}
(SIA-reflected-for-COSIATEC
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60)
   (8 64) (9 63) (12 56) (13 69) (15 65) (16 57)
   (16 59) (17 64) (19 63))
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation"
  "/Example files/Fantasia SIA4COSIATEC.txt"))
--> gives files in the specified location.
\end{verbatim}

\noindent This function is a version of the SIA
algorithm. It is called `SIA-reflected-for-COSIATEC'
because it is a slight variant on SIA-reflected. In
particular it does not allow a partition size to be
set. |#

(defun SIA-reflected-for-COSIATEC
       (dataset path&name &optional
        (growing-list nil)
	(first-dataset (first dataset))
	(rest-dataset (rest dataset))
	(probe
	 (if (null rest-dataset) ()
	   (subtract-two-lists
	    (first rest-dataset) (first dataset))))
	(result-recent
	 (assoc probe growing-list :test #'equalp)))
  (if (null dataset)
    (write-to-file growing-list path&name)
    (if (null probe)
      (SIA-reflected-for-COSIATEC
       (rest dataset) path&name growing-list)
      (if result-recent
	(SIA-reflected-for-COSIATEC
	 dataset path&name
	 (progn
	   (rplacd
	    (assoc probe
		   growing-list
		   :test #'equalp)
	    (append
	     (cdr result-recent)
	     (list first-dataset)))
	   (identity growing-list))
	 first-dataset (rest rest-dataset))
	(SIA-reflected-for-COSIATEC
	 dataset path&name
	 (append
	  (list
	   (cons probe
		 (list first-dataset)))
	  growing-list)
	 first-dataset
	 (rest rest-dataset))))))

#|
\noindent Example:
\begin{verbatim}
(SIA-reflected-for-COSIATEC-mod-2nd-n
 '((0 1) (0 5) (1 4) (4 2) (4 6) (5 5) (8 0)
   (8 4) (9 3) (12 8) (13 9) (15 5) (16 9)
   (16 11) (17 4) (19 3))
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation"
  "/Example files/Fantasia-mod SIA4COSIATEC.txt"))
--> gives files in the specified location.
\end{verbatim}

\noindent This function is a version of the SIA
algorithm. It is called `SIA-reflected-for-COSIATEC'
because it is a slight variant on SIA-reflected. In
particular it does not allow a partition size to be
set. Also in the mod-2nd-n version, translations in
the second dimension are made modulo the second
argument. |#

(defun SIA-reflected-for-COSIATEC-mod-2nd-n
       (dataset n path&name &optional
        (growing-list nil)
	(first-dataset (first dataset))
	(rest-dataset (rest dataset))
	(probe
	 (if (null rest-dataset) ()
	   (subtract-two-lists-mod-2nd-n
	    (first rest-dataset) (first dataset) n)))
	(result-recent
	 (assoc probe growing-list :test #'equalp)))
  (if (null dataset)
    (write-to-file growing-list path&name)
    (if (null probe)
      (SIA-reflected-for-COSIATEC-mod-2nd-n
       (rest dataset) n path&name growing-list)
      (if result-recent
	(SIA-reflected-for-COSIATEC-mod-2nd-n
	 dataset n path&name
	 (progn
	   (rplacd
	    (assoc probe
		   growing-list
		   :test #'equalp)
	    (append
	     (cdr result-recent)
	     (list first-dataset)))
	   (identity growing-list))
	 first-dataset (rest rest-dataset))
	(SIA-reflected-for-COSIATEC-mod-2nd-n
	 dataset n path&name
	 (append
	  (list
	   (cons probe
		 (list first-dataset)))
	  growing-list)
	 first-dataset
	 (rest rest-dataset))))))

#|
\noindent Example:
\begin{verbatim}
(setq
 SIA-output
 '(((8 0 0) (1/2 72 1/2) (1 76 1/2) (3/2 79 1/2)
    (2 84 2) (5/2 67 1/2) (3 64 1/2) (7/2 60 1/2)
    (8 36 2))
   ((13 13 13) (33/2 72 1/2) (17 76 1/2) (35/2 79 1/2)
    (18 84 2) (37/2 67 1/2) (19 64 1/2) (39/2 60 1/2)
    (24 36 2))
   ((17 2 0) (20 41 1) (74 65 1) (75 65 1) (124 55 1)
    (125 55 1) (126 55 1) (143 57 1) (148 60 1)
    (149 60 1) (150 60 1) (151 60 1) (152 60 1)
    (153 60 1) (154 60 1) (156 62 1) (159 65 1)
    (160 65 1) (163 65 1) (164 65 1) (222 70 1)
    (223 70 1))))
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 1.lisp"))
(progn
  (setq
   projected-dataset
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (setq
   path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp documentation"
    "/Example files/SIATEC example.txt")))
(SIATEC SIA-output projected-dataset path&name)
--> ((((20 41 1) (74 65 1) (75 65 1) (124 55 1)
       (125 55 1) (126 55 1) (143 57 1) (148 60 1)
       (149 60 1) (150 60 1) (151 60 1) (152 60 1)
       (153 60 1) (154 60 1) (156 62 1) (159 65 1)
       (160 65 1) (163 65 1) (164 65 1) (222 70 1)
       (223 70 1))
      (0 0 0) (17 2 0))
     (((1/2 72 1/2) (1 76 1/2) (3/2 79 1/2) (2 84 2)
       (5/2 67 1/2) (3 64 1/2) (7/2 60 1/2) (8 36 2))
      (0 0 0) (8 0 0) (16 0 0))).
\end{verbatim}

\noindent This function applies the SIATEC algorithm
to the output of the function SIA-reflected. |#

(defun SIATEC
       (SIA-output dataset path&name &optional
	(growing-list nil)
	(probe
	 (cdr (first SIA-output)))
	(result
	 (if probe
	   (assoc
	    probe growing-list
	    :test #'test-translation))))
  (if (null SIA-output)
    (write-to-file growing-list path&name)
    (if result
      (SIATEC
       (rest SIA-output) dataset path&name
       growing-list)
      (SIATEC
       (rest SIA-output) dataset path&name
       (cons
	(cons
	 probe
	 (translators-of-pattern-in-dataset
	  probe dataset))
	growing-list)))))

#|
\noindent Example:
\begin{verbatim}
(setq
 SIA-mod-2nd-n-output
 '(((8 0 0) (1/2 0 1/2) (1 4 1/2) (3/2 7 1/2) (2 0 2)
    (5/2 7 1/2) (3 4 1/2) (7/2 0 1/2) (8 36 2))
   ((13 13 13) (33/2 0 1/2) (17 4 1/2) (35/2 7 1/2)
    (18 0 2) (37/2 7 1/2) (19 4 1/2) (39/2 0 1/2)
    (24 36 2))
   ((17 2 0) (20 5 1) (74 5 1) (75 5 1) (124 7 1)
    (125 7 1) (126 7 1) (143 9 1) (148 0 1) (149 0 1)
    (150 0 1) (151 0 1) (152 0 1) (153 0 1) (154 0 1)
    (156 2 1) (159 5 1) (160 5 1) (163 5 1) (164 5 1)
    (222 10 1) (223 10 1))))
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 1.lisp"))
(progn
  (setq
   dataset-1-1-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (setq
   dataset-1-1*-0-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-0 12 1)))
  (setq
   path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp documentation"
    "/Example files/SIATEC-mod example.txt")))
(SIATEC-mod-2nd-n
 SIA-mod-2nd-n-output dataset-1-1*-0-1-0 12 path&name)
--> ((((20 5 1) (74 5 1) (75 5 1) (124 7 1) (125 7 1)
       (126 7 1) (143 9 1) (148 0 1) (149 0 1)
       (150 0 1) (151 0 1) (152 0 1) (153 0 1)
       (154 0 1) (156 2 1) (159 5 1) (160 5 1)
       (163 5 1) (164 5 1) (222 10 1) (223 10 1))
      (0 0 0) (17 2 0))
     (((1/2 0 1/2) (1 4 1/2) (3/2 7 1/2) (2 0 2)
       (5/2 7 1/2) (3 4 1/2) (7/2 0 1/2) (8 36 2))
      (0 0 0) (8 0 0) (16 0 0))).
\end{verbatim}

\noindent This function applies the SIATEC algorithm
to the output of the function SIA-reflected, where
translations in the second dimension are carried out
modulo the third argument. |#

(defun SIATEC-mod-2nd-n
       (SIA-output dataset n path&name &optional
	(growing-list nil)
	(probe
	 (cdr (first SIA-output)))
	(result
	 (if probe
	   (assoc
	    probe growing-list
	    :test #'test-translation-mod-2nd-n))))
  (if (null SIA-output)
    (write-to-file growing-list path&name)
    (if result
      (SIATEC-mod-2nd-n
       (rest SIA-output) dataset n path&name
       growing-list)
      (SIATEC-mod-2nd-n
       (rest SIA-output) dataset n path&name
       (cons
	(cons
	 probe
	 (translators-of-pattern-in-dataset-mod-2nd-n
	  probe dataset n))
	growing-list)))))
