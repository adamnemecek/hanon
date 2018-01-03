
(in-package :common-lisp-user)

(load "//Applications/CCL/Lisp code/Pattern matching/Scarlatti-K3.lisp")
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/reflexive-analyse.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/markov-compose.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/maximal-translatable-pattern.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/translational-equivalence-class.lisp")

(progn
  (write-to-file (date&time) "//Users/tec69/Desktop/beginning.txt")
  (setq D-101
        (orthogonal-projection-unique-equalp
         dataset '(1 0 1)))
  (write-to-file (date&time) "//Users/tec69/Desktop/middle.txt")
  (difference-list-unique-equalp D-101)
  (write-to-file (date&time) "//Users/tec69/Desktop/end.txt"))

#|
D-101 took 0h0m6s
Delta-101 took 0h9m55s


(load "//Applications/CCL/Lisp code/Pattern matching/vector-differences.lisp")

(progn
  (write-to-file (date&time) "//Users/tec69/Desktop/beginning.txt")
  (write-to-file
   (SIA D-101 D-101 Delta-101)
   "//Users/tec69/Desktop/SIA-out.txt")
  (write-to-file (date&time) "//Users/tec69/Desktop/end.txt"))
