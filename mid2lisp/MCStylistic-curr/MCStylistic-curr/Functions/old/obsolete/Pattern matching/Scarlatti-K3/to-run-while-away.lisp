#| Tom Collins
   Wednesday 12 August 2009
   Complete Wednesday 12 August 2009 |#

(in-package :common-lisp-user)
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-preliminaries.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-scaling.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-specific.lisp")

(load "//Applications/CCL/Lisp code/Pattern matching/Scarlatti-K3/101 (7) 0/scar-morph-mod.lisp")
(setq *nos-files*
      (reflected-SIA-scaling
       dataset '(1 0 1 0) 5000
       "K3 (1 0 1 (7) 0) prep" "txt"
       "//Applications/CCL/Lisp code/Pattern matching/Write to files/"))
(reflect-files
 "K3 (1 0 1 (7) 0) prep"
 "K3 (1 0 1 (7) 0) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files*)
(scaling-SIATEC
 dataset "K3 (1 0 1 (7) 0) SIA" "K3 (1 0 1 (7) 0) SIATEC"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files* 5000)

(load "//Applications/CCL/Lisp code/Pattern matching/Scarlatti-K3/1011/scar-1011.lisp")
(setq *nos-files*
      (reflected-SIA-scaling
       dataset '(1 0 1 1) 100000
       "K3 (1 0 1 1) prep" "txt"
       "//Applications/CCL/Lisp code/Pattern matching/Write to files/"))
(reflect-files
 "K3 (1 0 1 1) prep"
 "K3 (1 0 1 1) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files*)
; This is causing a stack overflow, so instead:
(progn
  (setq vector-MTP-pairs
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) prep 1.txt"))
  (identity "Read pairs."))
; Length of pairs is 88941. Split into five files:
(progn
  (write-to-file (subseq vector-MTP-pairs 0 20000)
                 "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) split 1.txt")
  (write-to-file
   (subseq vector-MTP-pairs 20000 40000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) split 2.txt")
  (write-to-file
   (subseq vector-MTP-pairs 40000 60000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) split 3.txt")
  (write-to-file
   (subseq vector-MTP-pairs 60000 80000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) split 4.txt")
  (write-to-file
   (subseq vector-MTP-pairs 80000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) split 5.txt"))
(reflect-files
 "K3 (1 0 1 1) split"
 "K3 (1 0 1 1) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 5)
(progn
  (setq MTP-vector-pairs-1
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA 1.txt"))
  (setq MTP-vector-pairs-2
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA 2.txt"))
  (setq MTP-vector-pairs-3
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA 3.txt"))
  (setq MTP-vector-pairs-4
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA 4.txt"))
  (setq MTP-vector-pairs-5
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA 5.txt"))
  (identity "Read pairs."))
(write-to-file
 (append
  MTP-vector-pairs-1 MTP-vector-pairs-2
  MTP-vector-pairs-3 MTP-vector-pairs-4
  MTP-vector-pairs-5)
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 0 1 1) SIA.txt")
; Now rename the above file SIA 1.txt.
(scaling-SIATEC
 dataset "K3 (1 0 1 1) SIA" "K3 (1 0 1 1) SIATEC"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files* 100000)

(load "//Applications/CCL/Lisp code/Pattern matching/Scarlatti-K3/1111/scar-1111.lisp")
(setq *nos-files*
      (reflected-SIA-scaling
       dataset '(1 1 1 1) 150000
       "K3 (1 1 1 1) prep" "txt"
       "//Applications/CCL/Lisp code/Pattern matching/Write to files/"))
(reflect-files
 "K3 (1 1 1 1) prep"
 "K3 (1 1 1 1) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files*)
; This is causing a stack overflow, so instead:
(progn
  (setq vector-MTP-pairs
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) prep 1.txt"))
  (identity "Read pairs."))
; Length of pairs is 113204. Split into six files:
(progn
  (write-to-file (subseq vector-MTP-pairs 0 20000)
                 "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 1.txt")
  (write-to-file
   (subseq vector-MTP-pairs 20000 40000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 2.txt")
  (write-to-file
   (subseq vector-MTP-pairs 40000 60000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 3.txt")
  (write-to-file
   (subseq vector-MTP-pairs 60000 80000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 4.txt")
  (write-to-file
   (subseq vector-MTP-pairs 80000 100000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 5.txt")
  (write-to-file
   (subseq vector-MTP-pairs 100000)
   "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) split 6.txt"))
(reflect-files
 "K3 (1 1 1 1) split"
 "K3 (1 1 1 1) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 6)
(progn
  (setq MTP-vector-pairs-1
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 1.txt"))
  (setq MTP-vector-pairs-2
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 2.txt"))
  (setq MTP-vector-pairs-3
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 3.txt"))
  (setq MTP-vector-pairs-4
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 4.txt"))
  (setq MTP-vector-pairs-5
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 5.txt"))
  (setq MTP-vector-pairs-6
        (read-from-file "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA 6.txt"))
  (identity "Read pairs."))
(write-to-file
 (append
  MTP-vector-pairs-1 MTP-vector-pairs-2
  MTP-vector-pairs-3 MTP-vector-pairs-4
  MTP-vector-pairs-5 MTP-vector-pairs-6)
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/K3 (1 1 1 1) SIA.txt")
; Now rename the above file SIA 1.txt.
(scaling-SIATEC
 dataset "K3 (1 1 1 1) SIA" "K3 (1 1 1 1) SIATEC"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" *nos-files* 150000)
