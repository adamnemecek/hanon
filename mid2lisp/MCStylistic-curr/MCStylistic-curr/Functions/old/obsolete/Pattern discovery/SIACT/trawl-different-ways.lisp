#| Tom Collins
   Friday 3 September 2010
   Incomplete

These functions are designed to trawl backwards (as
well as forwards) through already-discovered patterns
(usually MTPs). They return subpatterns that have
compactness and cardinality greater than thresholds
that can be specified. Looking at cases of failure, it
seemed that some patterns began with high compactness
and this meant late members could still be relatively
isolated but not damage the overall compactness too
much. Trawling backwards having trawled forwards
should account for most instances of this case of
failure. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/compactness-trawl.lisp"))
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
(compact-subpatterns<-
 '((1 1) (1 3) (2 2) (3 2) (3 3) (4 3))
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3))
 3/4 3)
--> (((1 1) (1 3) (2 2)) ((3 2) (3 3) (4 3))).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern from the end to beginning for
subpatterns that have compactness and cardinality
greater than certain thresholds, which are optional
arguments. In this version, just the subpatterns are
returned. |#

(defun compact-subpatterns<-
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (result nil)
        (catch (last pattern))
        (catch-compactness
         (if (first catch)
           (compactness
            catch dataset region-type))))
  (if (null pattern)
    (if (>= (length (rest catch))
            cardinality-threshold)
      (append (list (rest catch)) result)
      (identity result))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns<-
       (butlast pattern) dataset compactness-threshold
       cardinality-threshold region-type result
       (append
	(list (my-last (butlast pattern))) catch))
      (compact-subpatterns<-
       pattern dataset compactness-threshold
       cardinality-threshold region-type
       (if (>= (length (rest catch))
               cardinality-threshold)
         (append (list (rest catch)) result)
         (identity result))))))

#|
\noindent Example:
\begin{verbatim}
(compact-subpatterns-delta
 '((1 1) (2 2) (2 3) (3 2) (4 3))
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3))
 1/3 3)
--> (((3 1) (3 2) (4 3))).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern for subpatterns. When there is a
change in compactness between consecutive subpatterns
larger than the threshold delta (an optional
argument), and the cardinality is greater than another
optional arguments, the former subpattern is
returned. |#

(defun compact-subpatterns-delta
       (pattern dataset &optional
        (delta 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (result nil)
	(last-compactness 1)
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
    (if (< (- last-compactness
	      catch-compactness) delta)
      (compact-subpatterns-delta
       (rest pattern) dataset delta
       cardinality-threshold region-type result
       catch-compactness
       (append catch (list (second pattern))))
      (compact-subpatterns-delta
       pattern dataset delta cardinality-threshold
       region-type
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append result (list (butlast catch)))
         (identity result))))))

#|
\noindent Example:
\begin{verbatim}
(compact-subpatterns<-more-output
 '((1 1) (1 3) (2 2) (3 2) (3 3) (4 3))
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3))
 3/4 3)
--> ((((1 1) (1 3) (2 2)) ((3 2) (3 3) (4 3))) (1 1)).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern from the end to beginning for
subpatterns that have compactness and cardinality
greater than certain thresholds, which are optional
arguments. In this version, the subpatterns and
corresponding compactness values are returned. |#

(defun compact-subpatterns<-more-output
       (pattern dataset &optional
        (compactness-threshold 2/3)
        (cardinality-threshold 5)
        (region-type "lexicographic")
        (subpatterns nil)
	(compactnesses nil)
	(last-compactness nil)
        (catch (last pattern))
        (catch-compactness
         (if (first catch)
           (compactness
            catch dataset region-type))))
  (if (null pattern)
    (if (>= (length (rest catch))
            cardinality-threshold)
      (append
       (list
	(append (list (rest catch)) subpatterns))
       (list
	(append
	 (list last-compactness) compactnesses)))
      (append
       (list subpatterns) (list compactnesses)))
    (if (>= catch-compactness compactness-threshold)
      (compact-subpatterns<-more-output
       (butlast pattern) dataset compactness-threshold
       cardinality-threshold region-type subpatterns
       compactnesses catch-compactness
       (append
	(list (my-last (butlast pattern))) catch))
      (compact-subpatterns<-more-output
       pattern dataset compactness-threshold
       cardinality-threshold region-type
       (if (>= (length (rest catch))
               cardinality-threshold)
         (append (list (rest catch)) subpatterns)
         (identity subpatterns))
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append
	  (list last-compactness) compactnesses)
         (identity compactnesses))
       last-compactness))))

#|
\noindent Example:
\begin{verbatim}
(compact-subpatterns-delta-more-output
 '((1 1) (2 2) (2 3) (3 2) (4 3) (6 0) (7 0) (8 1))
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3)
   (4 7) (4 8) (5 0) (5 1) (5 5) (5 6) (6 0) (7 0)
   (8 1))
 7/25 3)
--> (((2 2) (2 3) (3 2) (4 3)) ((6 0) (7 0) (8 1)))
     (2/3 1)).
\end{verbatim}

\noindent This function takes a pattern and looks
within that pattern for subpatterns. When there is a
change in compactness between consecutive subpatterns
larger than the threshold delta (an optional
argument), and the cardinality is greater than another
optional arguments, the former subpattern is
returned.  In this version, the subpatterns and
corresponding compactness values are returned. |#

(defun compact-subpatterns-delta-more-output
       (pattern dataset &optional
        (delta 1/3) (cardinality-threshold 5)
        (region-type "lexicographic")
        (subpatterns nil)
	(compactnesses nil)
	(last-compactness 1)
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
    (if (< (- last-compactness
	      catch-compactness) delta)
      (compact-subpatterns-delta-more-output
       (rest pattern) dataset delta
       cardinality-threshold region-type subpatterns
       compactnesses catch-compactness
       (append catch (list (second pattern))))
      (compact-subpatterns-delta-more-output
       pattern dataset delta cardinality-threshold
       region-type
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append subpatterns (list (butlast catch)))
         (identity subpatterns))
       (if (>= (length (butlast catch))
               cardinality-threshold)
         (append
	  compactnesses (list last-compactness))
         (identity compactnesses))))))

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
    "/CT-delta example.txt")))
(compactness-trawler-delta
 SIA-output projected-dataset path&name 1/4 5)
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
subpatterns-delta-more-output recursively to the
output of the function SIA-reflected. |#

(defun compactness-trawler-delta
       (SIA-output dataset path&name &optional
	(delta 1/3)
	(cardinality-threshold 5)
        (region-type "lexicographic")
	(growing-list nil)
	(subpatterns&compactness
	 (compact-subpatterns-delta-more-output
	  (cdr (first SIA-output)) dataset
	  delta cardinality-threshold region-type))
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
       (rest SIA-output) dataset path&name delta
       cardinality-threshold region-type growing-list)
      (if result
	(compactness-trawler-delta
	 SIA-output dataset path&name
	 delta cardinality-threshold region-type
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
	(compactness-trawler-delta
	 SIA-output dataset path&name delta
	 cardinality-threshold region-type
	 (cons
	  (cons
	   probe
	   (list compactness-value
		 (car (first SIA-output))))
	  growing-list)
	 subpatterns&compactness (rest probes)
	 (rest compactness-values))))))

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
    "/CT<-> example.txt")))
(compactness-trawler<->
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
subpatterns<-more-output recursively to the output of
the function SIA-reflected. So it trawls through a
pattern (usually an MTP) from beginning to end, which
is no different to the function compactness-trawler.
It then trawls through each output pattern from end to
beginning using the function 
compact-subpatterns<-more-output. It takes the first
pattern from each application of this function, which
should be the pattern pruned of any `overhanging'
datapoints. |#

(defun compactness-trawler<->
       (SIA-output dataset path&name &optional
	(compactness-threshold 2/3)
	(cardinality-threshold 5)
        (region-type "lexicographic")
	(growing-list nil)
	(subpatterns
	 (compact-subpatterns
	  (cdr (first SIA-output)) dataset
	  compactness-threshold cardinality-threshold
	  region-type))
	(nested-subpatterns&compactness
	 (mapcar
	  #'(lambda (x)
	      (compact-subpatterns<-more-output
	       x dataset compactness-threshold
	       cardinality-threshold region-type))
	  subpatterns))
	(subpatterns&compactness
	 (mapcar
	  #'(lambda (x)
	      (append
	       (list (first (first x)))
	       (list (first (second x)))))
	  nested-subpatterns&compactness))
	(probes
	 (mapcar
	  #'(lambda (x) (first x))
	  subpatterns&compactness))
	(compactness-values
	 (mapcar
	  #'(lambda (x) (second x))
	  subpatterns&compactness))
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
      (compactness-trawler<->
       (rest SIA-output) dataset path&name
       compactness-threshold cardinality-threshold
       region-type growing-list)
      (if (null probe)
        (compactness-trawler<->
         SIA-output dataset path&name
         compactness-threshold cardinality-threshold
         region-type growing-list subpatterns
         nested-subpatterns&compactness
         subpatterns&compactness (rest probes)
         (rest compactness-values))
        (if result
          (compactness-trawler<->
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
           subpatterns nested-subpatterns&compactness
           subpatterns&compactness
           (rest probes) (rest compactness-values))
          (compactness-trawler<->
           SIA-output dataset path&name
           compactness-threshold cardinality-threshold
           region-type
           (cons
            (cons
             probe
             (list compactness-value
                   (car (first SIA-output))))
            growing-list)
           subpatterns nested-subpatterns&compactness
           subpatterns&compactness (rest probes)
           (rest compactness-values)))))))





