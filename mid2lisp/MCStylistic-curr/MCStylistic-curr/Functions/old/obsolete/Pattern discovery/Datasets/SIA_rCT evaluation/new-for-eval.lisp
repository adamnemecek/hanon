#| Tom Collins
   Wednesday 8 September 2010
   Incomplete

\noindent These functions allow for the comparative
evaluation of the algorithms SIA, SIACT, and SIA_rCT
in terms of recall, precision, and runtime. |#

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
  "/Applications/CCL/Lisp code/File conversion"
  "/csv-files.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/set-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-induction-merge.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/superdiagonals.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))

#|
\noindent Example:
\begin{verbatim}
(setq fname "mini-dataset")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq benchmark-labels '("A" "B" "C" "E" "F"))
(setq
 benchmark-probes
 '(((1 3) (1 4) (1 5) (1 6) (1 7) (2 2) (2 6) (3 2)
    (3 6) (4 1) (4 2) (4 4) (4 5) (5 2) (5 6) (6 2))
   ((1 6) (2 6) (3 6) (4 4) (4 5) (5 6))
   ((8 13) (9 14) (10 15) (12 16) (13 15) (13 16)
    (14 14) (15 14) (17 14) (18 14) (18 15) (18 16)
    (19 13))
   ((22 61) (23 59) (24 59) (24 60) (25 58) (25 61)
    (25 63) (26 57) (26 62) (27 53) (27 55) (27 58)
    (27 61) (27 63) (27 65) (27 67) (27 68) (28 58)
    (28 59) (29 60) (29 62) (30 61) (31 60)
    (31 62))
   ((23 59) (24 59) (24 60) (25 61) (25 63) (26 62)
    (27 61) (27 63))))
(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)
--> all sorts!
\end{verbatim}

\noindent Evalutes SIA, SIACT, SIA_r, and SIA_rCT on a
dataset. Three files are created for the output of
each of these algorithms. A file called benchmark-
details.txt will be updated with the details of which
benchmark probes (patterns) were discovered by which
algorithm. A list of numbers is returned. The first,
fourth, seventh, and tenth numbers are the
respective recalls; the second, fifth, eighth, and
elevnth are the precisions; the third, sixth, nineth,
and twelfth the runtimes. |#

(defun evaluate-SIACT-SIA_rCT-on-dataset
       (fname path-origin path-destination
        compactness-threshold cardinality-threshold
        region-type r-superdiagonals benchmark-labels
        benchmark-probes &optional
        (dataset
         (csv2dataset
          (concatenate
           'string path-origin fname ".csv")))
        (time-SIA
         (abs
          (- (get-internal-real-time)
             (progn
               (SIA-reflected-merge-sort
                dataset
                (concatenate
                 'string
                 path-destination fname "-SIA"))
               (get-internal-real-time)))))
        (output-SIA
         (read-from-file
          (concatenate
           'string
           path-destination fname "-SIA.txt")))
        (true-pos-SIA
         (benchmark-labels-discovered-rassoc
          benchmark-labels benchmark-probes
          output-SIA))
        (recall-SIA
         (/
          (length true-pos-SIA)
          (length benchmark-labels)))
        (precision-SIA
         (/
          (length true-pos-SIA)
          (length output-SIA)))
        (time-CT1
         (abs
          (- (get-internal-real-time)
             (progn
               (compactness-trawler
                output-SIA dataset
                (concatenate
                 'string
                 path-destination fname "-SIACT.txt")
                compactness-threshold
                cardinality-threshold region-type)
               (get-internal-real-time)))))
        (output-SIACT
         (read-from-file
          (concatenate
           'string
           path-destination fname "-SIACT.txt")))
        (true-pos-SIACT
         (benchmark-labels-discovered-assoc
          benchmark-labels benchmark-probes
          output-SIACT))
        (recall-SIACT
         (/
          (length true-pos-SIACT)
          (length benchmark-labels)))
        (precision-SIACT
         (/
          (length true-pos-SIACT)
          (length output-SIACT)))
        (time-SIA_r
         (abs
          (- (get-internal-real-time)
             (progn
               (structural-induction-algorithm-r
                dataset r-superdiagonals
                (concatenate
                 'string
                 path-destination fname "-SIA_r.txt"))
               (get-internal-real-time)))))
        (output-SIA_r
         (read-from-file
          (concatenate
           'string
           path-destination fname "-SIA_r.txt")))
        (true-pos-SIA_r
         (benchmark-labels-discovered-rassoc
          benchmark-labels benchmark-probes
          output-SIA_r))
        (recall-SIA_r
         (/
          (length true-pos-SIA_r)
          (length benchmark-labels)))
        (precision-SIA_r
         (/
          (length true-pos-SIA_r)
          (length output-SIA_r)))
        (time-CT2
         (abs
          (- (get-internal-real-time)
             (progn
               (compactness-trawler
                output-SIA_r dataset
                (concatenate
                 'string
                 path-destination fname
                 "-SIA_rCT.txt")
                compactness-threshold
                cardinality-threshold region-type)
               (get-internal-real-time)))))
        (output-SIA_rCT
         (read-from-file
          (concatenate
           'string
           path-destination fname "-SIA_rCT.txt")))
        (true-pos-SIA_rCT
         (benchmark-labels-discovered-assoc
          benchmark-labels benchmark-probes
          output-SIA_rCT))
        (recall-SIA_rCT
         (/
          (length true-pos-SIA_rCT)
          (length benchmark-labels)))
        (precision-SIA_rCT
         (/
          (length true-pos-SIA_rCT)
          (length output-SIA_rCT))))
  (progn
    (write-to-file-append
     (list
      (cons
       (concatenate
        'string fname "-SIA") true-pos-SIA))
     (concatenate
      'string
      path-destination "benchmark-details.txt"))
    (write-to-file-append
     (list
      (cons
       (concatenate
        'string fname "-SIACT") true-pos-SIACT))
     (concatenate
      'string
      path-destination "benchmark-details.txt"))
    (write-to-file-append
     (list
      (cons
       (concatenate
        'string fname "-SIA_r") true-pos-SIA_r))
     (concatenate
      'string
      path-destination "benchmark-details.txt"))
    (write-to-file-append
     (list
      (cons
       (concatenate
        'string fname "-SIA_rCT") true-pos-SIA_rCT))
     (concatenate
      'string
      path-destination "benchmark-details.txt"))
    (list
     (float recall-SIA) (float precision-SIA)
     (float
      (/ time-SIA internal-time-units-per-second))
     (float recall-SIACT) (float precision-SIACT)
     (float
      (/ (+ time-SIA time-CT1)
         internal-time-units-per-second))
     (float recall-SIA_r) (float precision-SIA_r)
     (float
      (/ time-SIA_r internal-time-units-per-second))
     (float recall-SIA_rCT) (float precision-SIA_rCT)
     (float
      (/ (+ time-SIA_r time-CT2)
         internal-time-units-per-second)))))

#|
\noindent Example:
\begin{verbatim}
(setq
 SIACT-output
 '((((71 1/2) (143/2 1/2) (72 1/2) (145/2 1/2))
    26/37 (1 0))
   (((71 1/2) (143/2 1/2) (72 1/2) (145/2 1/2)
     (73 1/2) (147/2 1/2) (74 1/2) (149/2 1/2))
    4/5 (37/4 -1/4) 4/5 (9 -1/4) 8/11 (15/4 -1/4))
   (((55 1) (56 1/2) (113/2 1)) 3/4 (14 1/2))
   (((65/2 1/2) (33 1/2) (67/2 1/2) (34 1/2))
    3/4 (179/4 -1/4) 3/4 (89/2 -1/4))))
(benchmark-labels-discovered-assoc
 '("A" "B" "C" "E")
 '(((60 1) (61 1/2) (123/2 1))
   ((124 1) (125 1) (126 1)) ((5/2 1/2) (7/2 1/2))
   ((71 1/2) (143/2 1/2) (72 1/2) (145/2 1/2)
    (73 1/2) (147/2 1/2) (74 1/2) (149/2 1/2)))
 SIACT-output)
--> ("A" "E").
\end{verbatim}

\noindent The only difference between this function
and the function benchmark-labels-discovered-rassoc is
the use of assoc. Some benchmark labels and patterns
to which the labels correspond are the first two
arguments to this function. The third argument is the
output of some pattern discovery algorithm, which is
probed for the presence of the patterns, up to
translational equivalence. Labels are returned for the
patterns that are present in the output. |#

(defun benchmark-labels-discovered-assoc
       (benchmark-labels benchmark-probes
        output-to-probe)
  (if (null benchmark-labels) ()
    (append
     (if (assoc
          (first benchmark-probes)
          output-to-probe :test #'test-translation)
       (list (first benchmark-labels)))
     (benchmark-labels-discovered-assoc
      (rest benchmark-labels) (rest benchmark-probes)
      output-to-probe))))

#|
\noindent Example:
\begin{verbatim}
(setq
 SIA-output
 '(((8 0 0 0) (1/2 72 67 1/2) (1 76 69 1/2)
    (3/2 79 71 1/2) (2 84 74 2) (5/2 67 64 1/2))
   ((16 0 0 0) (2 84 74 2) (5/2 67 64 1/2)
    (3 64 62 1/2) (7/2 60 60 1/2) (8 36 46 2))
   ((17 2 1 0) (124 55 57 1) (125 55 57 1)
    (126 55 57 1))))
(benchmark-labels-discovered-rassoc
 '("A" "B" "C" "E")
 '(((1/2 72 67 1/2) (1 76 69 1/2) (3/2 79 71 1/2))
   ((124 55 57 1) (125 55 57 1) (126 55 57 1))
   ((5/2 67 64 1/2) (7/2 60 60 1/2))
   ((9/2 67 64 1/2) (5 71 66 1/2) (11/2 74 68 1/2)
    (6 79 71 2) (13/2 62 61 1/2)))
 SIA-output)
--> ("B" "E").
\end{verbatim}

\noindent Some benchmark labels and patterns to which
the labels correspond are the first two arguments to
this function. The third argument is the output of
some pattern discovery algorithm, which is probed for
the presence of the patterns, up to translational
equivalence. Labels are returned for the patterns
that are present in the output. |#

(defun benchmark-labels-discovered-rassoc
       (benchmark-labels benchmark-probes
        output-to-probe)
  (if (null benchmark-labels) ()
    (append
     (if (rassoc
          (first benchmark-probes)
          output-to-probe :test #'test-translation)
       (list (first benchmark-labels)))
     (benchmark-labels-discovered-rassoc
      (rest benchmark-labels) (rest benchmark-probes)
      output-to-probe))))

