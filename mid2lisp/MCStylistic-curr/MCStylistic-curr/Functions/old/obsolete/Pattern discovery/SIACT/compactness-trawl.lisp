#| Tom Collins
   Tuesday 12 January 2010
   Complete Saturday 30 January 2010

These functions are designed to trawl through already-
discovered patterns (usually MTPs) from beginning to
end. They return subpatterns that have compactness
and cardinality greater than thresholds that can be
specified. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/evaluation-preliminaries.lisp"))
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
(compact-subpatterns
 '((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2)
   (2 84 74 2) (7/2 60 60 1/2) (5 76 69 1/2)
   (11/2 79 71 1/2) (6 84 74 2) (13/2 67 64 1/2)
   (15/2 60 60 1/2))
 '((0 48 53 2) (1/2 72 67 1/2) (1 76 69 1/2)
   (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2)
   (3 64 62 1/2) (7/2 60 60 1/2) (4 36 46 2)
   (9/2 72 67 1/2) (5 76 69 1/2) (11/2 79 71 1/2)
   (6 84 74 2) (13/2 67 64 1/2) (7 64 62 1/2)
   (15/2 60 60 1/2) (8 36 46 2) (17/2 72 67 1/2))
 2/3 3)
--> (((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2)
      (2 84 74 2) (7/2 60 60 1/2))
     ((5 76 69 1/2) (11/2 79 71 1/2) (6 84 74 2)
      (13/2 67 64 1/2) (15/2 60 60 1/2))).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern for subpatterns that have
compactness and cardinality greater than certain
thresholds, which are optional arguments. In this
version, just the subpatterns are returned. |#

(defun compact-subpatterns
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (result nil)
        (catch (list (first pattern)))
        (catch-compactness
         (if (my-last catch)
           (compactness
            catch dataset region-type))))
  (if (null pattern)
    (if (>= (length (butlast catch))
            cardinality-threshold)
      (append result (list (butlast catch)))
      (identity result))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns
       (rest pattern) dataset compactness-threshold
       cardinality-threshold region-type result
       (append catch (list (second pattern))))
      (compact-subpatterns
       pattern dataset compactness-threshold
       cardinality-threshold region-type
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append result (list (butlast catch)))
         (identity result))))))

#| Old versions. 29/7/2010 The only change between the
current version and second version below is in the
line fourth from bottom in the above code. Previously
the length of the catch was checked, but actually l-1
is what should be checked, as the catch is
artificially extended and it is the penultimate
subpattern that is being considered. Code for testing
this is as follows.

(setq
 dataset
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3)))
(setq
 pattern
 '((1 1) (1 3) (2 3) (4 3)))
(compact-subpatterns pattern dataset 2/3 3)
(compact-subpatterns pattern dataset 2/3 4)

Previously both of these produced output, which is a
mistake in the latter case.

(defun compact-subpatterns
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (result nil)
        (catch (list (first pattern)))
        (catch-compactness
         (if (my-last catch)
           (compactness
            catch dataset "straight down"))))
  (if (null pattern)
    (if (>= (length (butlast catch))
            cardinality-threshold)
      (append result (list (butlast catch)))
      (identity result))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns
       (rest pattern) dataset compactness-threshold
       cardinality-threshold result
       (append catch (list (second pattern))))
      (compact-subpatterns
       pattern dataset compactness-threshold
       cardinality-threshold
       (if (>= (length catch) cardinality-threshold)
         (append result (list (butlast catch)))
         (identity result))))))

(defun compact-subpatterns
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (result nil)
        (catch (list (first pattern)))
        (catch-compactness
         (if (my-last catch)
           (compactness
            catch dataset region-type))))
  (if (null pattern)
    (if (>= (length (butlast catch))
            cardinality-threshold)
      (append result (list (butlast catch)))
      (identity result))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns
       (rest pattern) dataset compactness-threshold
       cardinality-threshold region-type result
       (append catch (list (second pattern))))
      (compact-subpatterns
       pattern dataset compactness-threshold
       cardinality-threshold region-type
       (if (>= (length catch) cardinality-threshold)
         (append result (list (butlast catch)))
         (identity result))))))
|#

#|
\noindent Example:
\begin{verbatim}
(compact-subpatterns-more-output
 '((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2)
   (2 84 74 2) (7/2 60 60 1/2) (5 76 69 1/2)
   (11/2 79 71 1/2) (6 84 74 2) (13/2 67 64 1/2)
   (15/2 60 60 1/2))
 '((0 48 53 2) (1/2 72 67 1/2) (1 76 69 1/2)
   (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2)
   (3 64 62 1/2) (7/2 60 60 1/2) (4 36 46 2)
   (9/2 72 67 1/2) (5 76 69 1/2) (11/2 79 71 1/2)
   (6 84 74 2) (13/2 67 64 1/2) (7 64 62 1/2)
   (15/2 60 60 1/2) (8 36 46 2) (17/2 72 67 1/2))
 2/3 3)
--> ((((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2)
       (2 84 74 2) (7/2 60 60 1/2))
      ((5 76 69 1/2) (11/2 79 71 1/2) (6 84 74 2)
       (13/2 67 64 1/2) (15/2 60 60 1/2)))
     (5/7 5/6)).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern for subpatterns that have
compactness and cardinality greater than certain
thresholds, which are optional arguments. In this
version, the subpatterns and corresponding compactness
values are returned. |#

(defun compact-subpatterns-more-output
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (subpatterns nil)
	(compactnesses nil)
	(last-compactness nil)
        (catch (list (first pattern)))
        (catch-compactness
         (if (my-last catch)
           (compactness
            catch dataset region-type))))
  (if (null pattern)
    (if (>= (length (butlast catch))
            cardinality-threshold)
      (append
       (list
	(append subpatterns (list (butlast catch))))
       (list
	(append
	 compactnesses (list last-compactness))))
      (append
       (list subpatterns) (list compactnesses)))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns-more-output
       (rest pattern) dataset compactness-threshold
       cardinality-threshold region-type subpatterns
       compactnesses catch-compactness
       (append catch (list (second pattern))))
      (compact-subpatterns-more-output
       pattern dataset compactness-threshold
       cardinality-threshold region-type
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append subpatterns (list (butlast catch)))
         (identity subpatterns))
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append
	  compactnesses (list last-compactness))
         (identity compactnesses))
       last-compactness))))

#| Old version
(defun compact-subpatterns-more-output
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (subpatterns nil)
	(compactnesses nil)
	(last-compactness nil)
        (catch (list (first pattern)))
        (catch-compactness
         (if (my-last catch)
           (compactness
            catch dataset "straight down"))))
  (if (null pattern)
    (if (>= (length (butlast catch))
            cardinality-threshold)
      (append
       (list
	(append subpatterns (list (butlast catch))))
       (list
	(append
	 compactnesses (list last-compactness))))
      (append
       (list subpatterns) (list compactnesses)))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns-more-output
       (rest pattern) dataset compactness-threshold
       cardinality-threshold subpatterns compactnesses
       catch-compactness
       (append catch (list (second pattern))))
      (compact-subpatterns-more-output
       pattern dataset compactness-threshold
       cardinality-threshold
       (if (>= (length catch) cardinality-threshold)
         (append subpatterns (list (butlast catch)))
         (identity subpatterns))
       (if (>= (length catch) cardinality-threshold)
         (append
	  compactnesses (list last-compactness))
         (identity compactnesses))
       last-compactness))))
|#

#|
\noindent Example:
\begin{verbatim}
(setq
 SIA-output
 '(((8 0 0 0) (1/2 72 67 1/2) (1 76 69 1/2)
    (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2)
    (3 64 62 1/2) (7/2 60 60 1/2) (8 36 46 2))
   ((16 0 0 0) (1/2 72 67 1/2) (1 76 69 1/2)
    (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2)
    (3 64 62 1/2) (7/2 60 60 1/2) (8 36 46 2)
    (46 38 47 2) (62 81 72 3/2) (127/2 79 71 1/4)
    (255/4 81 72 1/4) (72 79 71 2) (88 31 43 2)
    (96 31 43 2) (136 69 65 1) (137 69 65 1)
    (138 67 64 1) (139 67 64 1) (140 65 63 1)
    (141 65 63 1))
   ((17 2 1 0) (20 41 49 1) (74 65 63 1) (75 65 63 1)
    (124 55 57 1) (125 55 57 1) (126 55 57 1)
    (143 57 58 1) (148 60 60 1) (149 60 60 1)
    (150 60 60 1) (151 60 60 1) (152 60 60 1)
    (153 60 60 1) (154 60 60 1) (156 62 61 1)
    (159 65 63 1) (160 65 63 1) (163 65 63 1)
    (164 65 63 1) (222 70 66 1) (223 70 66 1))))
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 1.lisp"))
(progn
  (setq
   projected-dataset
   (orthogonal-projection-unique-equalp
    dataset '(1 1 1 1 0)))
  (setq
   path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/SIACT/Write to files"
    "/CT example.txt")))
(compactness-trawler
 SIA-output projected-dataset path&name 1/2 5)
--> ((((148 60 60 1) (149 60 60 1) (150 60 60 1)
       (151 60 60 1) (152 60 60 1) (153 60 60 1)
       (154 60 60 1))
      (7/13 (17 2 1 0)))
     (((136 69 65 1) (137 69 65 1) (138 67 64 1)
       (139 67 64 1) (140 65 63 1) (141 65 63 1))
      (6/11 (16 0 0 0)))
     (((1/2 72 67 1/2) (1 76 69 1/2)
       (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2)
       (3 64 62 1/2) (7/2 60 60 1/2))
      (1 (16 0 0 0)))).
\end{verbatim}

\noindent This function applies the function compact-
subpatterns-more-output recursively to the output of
the function SIA-reflected. |#

(defun compactness-trawler
       (SIA-output dataset path&name &optional
	(compactness-threshold 2/3)
	(cardinality-threshold 5)
        (region-type "lexicographic")
	(growing-list nil)
	(subpatterns&compactness
	 (compact-subpatterns-more-output
	  (cdr (first SIA-output)) dataset
	  compactness-threshold
	  cardinality-threshold region-type))
	(probes
	 (first subpatterns&compactness))
	(compactness-values
	 (second subpatterns&compactness))
	(probe (first probes))
	(compactness-value (first compactness-values))
	(result
	 (if probe
	   (assoc
	    probe growing-list
	    :test #'test-translation))))
  (if (null SIA-output)
    (write-to-file growing-list path&name)
    (if (null probes)
      (compactness-trawler
       (rest SIA-output) dataset path&name
       compactness-threshold cardinality-threshold
       region-type growing-list)
      (if result
	(compactness-trawler
	 SIA-output dataset path&name
	 compactness-threshold cardinality-threshold
         region-type
	 (progn
	   (rplacd
	    (assoc
	     probe growing-list
	     :test #'test-translation)
	    (append
	     (cdr result)
	     (list compactness-value
		   (car (first SIA-output)))))
	   (identity growing-list))
	 subpatterns&compactness
	 (rest probes)
	 (rest compactness-values))
	(compactness-trawler
	 SIA-output dataset path&name
	 compactness-threshold cardinality-threshold
         region-type
	 (cons
	  (cons
	   probe
	   (list compactness-value
		 (car (first SIA-output))))
	  growing-list)
	 subpatterns&compactness (rest probes)
	 (rest compactness-values))))))

#| Old version
(defun compactness-trawler
       (SIA-output dataset path&name &optional
	(compactness-threshold 2/3)
	(cardinality-threshold 5)
	(growing-list nil)
	(subpatterns&compactness
	 (compact-subpatterns-more-output
	  (cdr (first SIA-output)) dataset
	  compactness-threshold
	  cardinality-threshold))
	(probes
	 (first subpatterns&compactness))
	(compactness-values
	 (second subpatterns&compactness))
	(probe (first probes))
	(compactness-value (first compactness-values))
	(result
	 (if probe
	   (assoc
	    probe growing-list
	    :test #'test-translation))))
  (if (null SIA-output)
    (write-to-file growing-list path&name)
    (if (null probes)
      (compactness-trawler
       (rest SIA-output) dataset path&name
       compactness-threshold cardinality-threshold
       growing-list)
      (if result
	(compactness-trawler
	 SIA-output dataset path&name
	 compactness-threshold cardinality-threshold
	 (progn
	   (rplacd
	    (assoc
	     probe growing-list
	     :test #'test-translation)
	    (append
	     (cdr result)
	     (list compactness-value
		   (car (first SIA-output)))))
	   (identity growing-list))
	 subpatterns&compactness
	 (rest probes)
	 (rest compactness-values))
	(compactness-trawler
	 SIA-output dataset path&name
	 compactness-threshold cardinality-threshold
	 (cons
	  (cons
	   probe
	   (list compactness-value
		 (car (first SIA-output))))
	  growing-list)
	 subpatterns&compactness (rest probes)
	 (rest compactness-values))))))
|#










