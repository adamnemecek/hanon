#| Tom Collins
   Tuesday 8 December 2009
   Incomplete |#

#| The purpose is to find patterns and check them in
Scarlatti's Sonata in C Major, L. 1 (K. 514). |#

(in-package :common-lisp-user)
(load
 "/Applications/CCL/Lisp code/list-processing.lisp")
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/set-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))


#| Step 1 - load the dataset. |#
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
   dataset-1-0-1-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 1 1 0)))
  (setq
   dataset-1-1-0-0-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 0 0)))
  (setq
   dataset-1-0-1-0-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 1 0 0)))
  (setq
   dataset-1-0-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 0 1 0)))
  (identity "Yes!"))
(progn
  (setq
   dataset-1-1*-0-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-0 12 1)))
  (setq
   dataset-1-0-1*-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-0-1-1-0 7 1)))
  (setq
   dataset-1-1*-0-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-0-0 12 1)))
  (setq
   dataset-1-0-1*-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-0-1-0-0 7 1)))
  (identity "Yes!"))


#| Step 2 |#
(progn
  (setq
   MTP-4-0-0
   (maximal-translatable-pattern
    '(4 0 0) dataset-1-1-0-1-0))
  (setq
   MTP-8-0-0
   (maximal-translatable-pattern
    '(8 0 0) dataset-1-1-0-1-0))
  (setq
   MTP-16-0-0
   (maximal-translatable-pattern
    '(16 0 0) dataset-1-1-0-1-0))
  (setq
   A*
   (intersections-multidimensional
    (list
     MTP-4-0-0 MTP-8-0-0 MTP-16-0-0))))

(progn
  (setq
   MTP-4-0*-0
   (maximal-translatable-pattern-mod-2nd-n
    '(4 0 0) dataset-1-1*-0-1-0 12))
  (setq
   MTP-8-0*-0
   (maximal-translatable-pattern-mod-2nd-n
    '(8 0 0) dataset-1-1*-0-1-0 12))
  (setq
   MTP-16-0*-0
   (maximal-translatable-pattern-mod-2nd-n
    '(16 0 0) dataset-1-1*-0-1-0 12))
  (setq
   B*
   (intersections-multidimensional
    (list
     MTP-4-0*-0 MTP-8-0*-0 MTP-16-0*-0))))

(setq
 C*
 (maximal-translatable-pattern
  '(8 0) dataset-1-1-0-0-0))

(progn
  (setq
   MTP-8-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(8 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-72-7*
   (maximal-translatable-pattern-mod-2nd-n
    '(72 7) dataset-1-1*-0-0-0 12))
  (setq
   MTP-96-7*
   (maximal-translatable-pattern-mod-2nd-n
    '(96 7) dataset-1-1*-0-0-0 12))
  (setq
   MTP-104-7*
   (maximal-translatable-pattern-mod-2nd-n
    '(104 7) dataset-1-1*-0-0-0 12))
  (setq
   MTP-220-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(220 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-244-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(244 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-252-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(252 0) dataset-1-1*-0-0-0 12))
  (setq
   D*
   (intersections-multidimensional
    (list
     MTP-8-0* MTP-72-7* MTP-96-7* MTP-104-7* MTP-220-0*
     MTP-244-0* MTP-252-0*))))

(progn
  (setq
   MTP-24-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(24 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-32-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(32 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-148-5*
   (maximal-translatable-pattern-mod-2nd-n
    '(148 5) dataset-1-1*-0-0-0 12))
  (setq
   MTP-172-5*
   (maximal-translatable-pattern-mod-2nd-n
    '(172 5) dataset-1-1*-0-0-0 12))
  (setq
   MTP-180-5*
   (maximal-translatable-pattern-mod-2nd-n
    '(180 5) dataset-1-1*-0-0-0 12))
  (setq
   E*
   (intersections-multidimensional
    (list
     MTP-24-0* MTP-32-0* MTP-148-5* MTP-172-5*
     MTP-180-5*))))

(progn
  (setq
   MTP-4-1-0
   (maximal-translatable-pattern
    '(4 -1 0) dataset-1-0-1-1-0))
  (setq
   MTP-8-2-0
   (maximal-translatable-pattern
    '(8 -2 0) dataset-1-0-1-1-0))
  (setq
   F*
   (intersections-multidimensional
    (list MTP-4-1-0 MTP-8-2-0))))

(progn
  (setq
   MTP-4-0
   (maximal-translatable-pattern
    '(4 0) dataset-1-1-0-0-0))
  (setq
   MTP-8-0
   (maximal-translatable-pattern
    '(8 0) dataset-1-1-0-0-0))
  (setq
   G*
   (intersections-multidimensional
    (list MTP-4-0 MTP-8-0))))

(progn
  (setq
   MTP-2-2-0
   (maximal-translatable-pattern
    '(2 -2 0) dataset-1-0-1-1-0))
  (setq
   MTP-4-4-0
   (maximal-translatable-pattern
    '(4 -4 0) dataset-1-0-1-1-0))
  (setq
   H*
   (intersections-multidimensional
    (list MTP-2-2-0 MTP-4-4-0))))

(setq
 I*
 (maximal-translatable-pattern
  '(148 0) dataset-1-0-0-1-0))

