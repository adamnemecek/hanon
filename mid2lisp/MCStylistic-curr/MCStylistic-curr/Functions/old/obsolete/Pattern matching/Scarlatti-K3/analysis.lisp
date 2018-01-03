
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-preliminaries.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-scaling.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-specific.lisp")


(reflected-SIA-scaling
 dataset '(1 1 0 0) 1000
 "//Applications/CCL/Lisp code/Pattern matching/Write to files")

(reflect-files
 "reflected SIA (1 1 0 0)"
 "SIA (1 1 0 0)"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 52)

(scaling-SIATEC
 "SIA (1 1 0 0)" "SIATEC (1 1 0 0)"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 52 1000)



