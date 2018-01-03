#| Tom Collins
   Tuesday 7 September 2010
   Incomplete

\noindent This code runs three pattern discovery
algorithms (SIA, SIACT and SIA_rCT) on various
datasets and evaluates their output in terms of
recall, precision and runtime. |#

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
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation"
  "/new-for-eval.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation"
  "/random&embedded.lisp"))
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

#| These are the filenames of the datasets that will
be analysed. |#
(progn
  (setq
   path-origin
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/Datasets/SIA_rCT evaluation/embeddings/"))
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
  (setq
   fnames
   '("D-250"
     "D-ca-300-1" "D-ca-300-2" "D-ca-300-3"
     "D-ca-300-4" "D-ca-300-5" "D-ca-300-6"
     "D-ca-300-7" "D-ca-300-8" "D-ca-300-9"
     "D-ca-300-10" "D-ca-300-11" "D-ca-300-12"
     "D-ca-300-13" "D-ca-300-14" "D-ca-300-15"
     "D-ca-300-16" "D-ca-300-17" "D-ca-300-18"
     "D-ca-300-19" "D-ca-300-20"
     "D-ca-350-1" "D-ca-350-2" "D-ca-350-3"
     "D-ca-350-4" "D-ca-350-5" "D-ca-350-6"
     "D-ca-350-7" "D-ca-350-8" "D-ca-350-9"
     "D-ca-350-10" "D-ca-350-11" "D-ca-350-12"
     "D-ca-350-13" "D-ca-350-14" "D-ca-350-15"
     "D-ca-350-16" "D-ca-350-17" "D-ca-350-18"
     "D-ca-350-19" "D-ca-350-20"
     "D-ca-500-1" "D-ca-500-2" "D-ca-500-3"
     "D-ca-500-4" "D-ca-500-5" "D-ca-500-6"
     "D-ca-500-7" "D-ca-500-8" "D-ca-500-9"
     "D-ca-500-10" "D-ca-500-11" "D-ca-500-12"
     "D-ca-500-13" "D-ca-500-14" "D-ca-500-15"
     "D-ca-500-16" "D-ca-500-17" "D-ca-500-18"
     "D-ca-500-19" "D-ca-500-20"
     "D-ca-750-1" "D-ca-750-2" "D-ca-750-3"
     "D-ca-750-4" "D-ca-750-5" "D-ca-750-6"
     "D-ca-750-7" "D-ca-750-8" "D-ca-750-9"
     "D-ca-750-10" "D-ca-750-11" "D-ca-750-12"
     "D-ca-750-13" "D-ca-750-14" "D-ca-750-15"
     "D-ca-750-16" "D-ca-750-17" "D-ca-750-18"
     "D-ca-750-19" "D-ca-750-20"
     "D-ca-1000-1" "D-ca-1000-2" "D-ca-1000-3"
     "D-ca-1000-4" "D-ca-1000-5" "D-ca-1000-6"
     "D-ca-1000-7" "D-ca-1000-8" "D-ca-1000-9"
     "D-ca-1000-10" "D-ca-1000-11" "D-ca-1000-12"
     "D-ca-1000-13" "D-ca-1000-14" "D-ca-1000-15"
     "D-ca-1000-16" "D-ca-1000-17" "D-ca-1000-18"
     "D-ca-1000-19" "D-ca-1000-20"
     "D-250-sf2"
     "D-cd-650-1" "D-cd-650-2" "D-cd-650-3"
     "D-cd-650-4" "D-cd-650-5" "D-cd-650-6"
     "D-cd-650-7" "D-cd-650-8" "D-cd-650-9"
     "D-cd-650-10" "D-cd-650-11" "D-cd-650-12"
     "D-cd-650-13" "D-cd-650-14" "D-cd-650-15"
     "D-cd-650-16" "D-cd-650-17" "D-cd-650-18"
     "D-cd-650-19" "D-cd-650-20"))
  "Yes!")

#| These are the patterns in the benchmark. Remember
to adjust this for the D-cd-650 datasets. |#
(progn
  (setq
   benchmark-labels
   (list "A" "B" "C" "E" "F" "G" "H" "I" "J" "K"))
  (setq
   benchmark-probes
   (list A1 B1 C1 E1 F1 G1 H1 I1 J1 K1))
  "Yes!")

#| Each file is analysed and the results written
to a csv file called results.csv. |#

(progn
  (setq
   results-path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/Datasets/SIA_rCT evaluation/results"))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (evaluate-SIACT-SIA_rCT-on-dataset
         x path-origin path-destination
         compactness-threshold cardinality-threshold
         region-type r-superdiagonals benchmark-labels
         benchmark-probes))
    (subseq fnames 0 101))
   (concatenate 'string results-path&name ".txt"))
  (dataset2csv 
   (concatenate 'string results-path&name ".txt")
   (concatenate 'string results-path&name ".csv")))

#| Adjusting for the D-cd-650 datasets. |#

(progn
  (setq
   benchmark-probes
   (list
    A1-650 B1-650 C1-650 E1-650 F1-650 G1-650 H1-650
    I1-650 J1-650 K1-650))
  "Yes!")
(progn
  (setq
   results-path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/Datasets/SIA_rCT evaluation/results"))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (evaluate-SIACT-SIA_rCT-on-dataset
         x path-origin path-destination
         compactness-threshold cardinality-threshold
         region-type r-superdiagonals benchmark-labels
         benchmark-probes))
    (subseq fnames 101 122))
   (concatenate 'string results-path&name ".txt"))
  (dataset2csv 
   (concatenate 'string results-path&name ".txt")
   (concatenate 'string results-path&name ".csv")))
