#| Tom Collins
   Tuesday 8 December 2009
   Incomplete |#

#| The purpose is to find patterns and check them in
Bach's Prelude in E Major, BWV 854. |#

(in-package :common-lisp-user)
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
  "/Bach preludes/BWV 854.lisp"))
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
   MTP-135-19-0
   (maximal-translatable-pattern
    '(135 -19 0) dataset-1-1-0-1-0))
  (setq A* MTP-135-19-0))

(translators-of-pattern-in-dataset
 A dataset-1-1-0-1-0)

(progn
  (setq
   MTP-135-11-0
   (maximal-translatable-pattern
    '(135 -11 0) dataset-1-0-1-1-0))
  (setq B* MTP-135-11-0))

(translators-of-pattern-in-dataset
 B dataset-1-0-1-1-0)

(progn
  (setq
   MTP-84-5-0
   (maximal-translatable-pattern
    '(84 5 0) dataset-1-1-0-1-0))
  (setq C* MTP-84-5-0))

(translators-of-pattern-in-dataset
 C dataset-1-1-0-1-0)

(progn
  (setq
   MTP-84-7
   (maximal-translatable-pattern
    '(84 -7) dataset-1-1-0-0-0))
  (setq D* MTP-84-7))

(translators-of-pattern-in-dataset
 D dataset-1-1-0-0-0)

(progn
  (setq
   MTP-84-5
   (maximal-translatable-pattern-mod-2nd-n
    '(84 5) dataset-1-1*-0-0-0 12))
  (setq
   E* MTP-84-5))
   
(translators-of-pattern-in-dataset-mod-2nd-n
 E dataset-1-1*-0-0-0 12)

(progn
  (setq
   MTP-21-7
   (maximal-translatable-pattern
    '(21 7) dataset-1-1-0-0-0))
  (setq F* MTP-21-7))

(translators-of-pattern-in-dataset
 F dataset-1-1-0-0-0)

(progn
  (setq
   MTP-21-4
   (maximal-translatable-pattern
    '(21 4) dataset-1-0-1-0-0))
  (setq G* MTP-21-4))

(translators-of-pattern-in-dataset
 G dataset-1-0-1-0-0)

(progn
  (setq
   MTP-96-10
   (maximal-translatable-pattern
    '(96 -10) dataset-1-0-1-0-0))
  (setq H* MTP-96-10))

(translators-of-pattern-in-dataset
 H dataset-1-0-1-0-0)

(progn
  (setq
   MTP-15-0
   (maximal-translatable-pattern
    '(15 0) dataset-1-0-0-1-0))
  (setq
   MTP-21-0
   (maximal-translatable-pattern
    '(21 0) dataset-1-0-0-1-0))
  (setq
   MTP-67/2-0
   (maximal-translatable-pattern
    '(67/2 0) dataset-1-0-0-1-0))
  (setq
   MTP-34-0
   (maximal-translatable-pattern
    '(34 0) dataset-1-0-0-1-0))
  (setq
   MTP-84-0
   (maximal-translatable-pattern
    '(84 0) dataset-1-0-0-1-0))
  (setq
   I*
   (intersections-multidimensional
    (list
     MTP-15-0 MTP-21-0 MTP-67/2-0 MTP-34-0
     MTP-84-0))))

(translators-of-pattern-in-dataset
 I dataset-1-0-0-1-0)

(setq J* '((3 58 2) (5 57 1/2) (11/2 56 1/2)))

(translators-of-pattern-in-dataset
 J* dataset-1-0-1-1-0)

(setq K* '((2 68 1/2) (5/2 69 1/2) (3 67 1/2)))

(translators-of-pattern-in-dataset
 K* dataset-1-0-1-1-0)

(setq L* '((31 67 1/2) (63/2 69 1/2) (32 68 1/2)))

(translators-of-pattern-in-dataset
 L* dataset-1-0-1-1-0)

(setq M* '((96 67 1/2) (193/2 65 1/2) (97 66 1/2)))

(translators-of-pattern-in-dataset
 M* dataset-1-0-1-1-0)

(setq N* '((3/2 69 1/2) (2 68 1/2) (5/2 69 1/2)))

(translators-of-pattern-in-dataset
 N* dataset-1-0-1-1-0)

(setq O* '((6 57 2) (8 58 1/2) (17/2 57 1/2)))

(translators-of-pattern-in-dataset
 O* dataset-1-0-1-1-0)

