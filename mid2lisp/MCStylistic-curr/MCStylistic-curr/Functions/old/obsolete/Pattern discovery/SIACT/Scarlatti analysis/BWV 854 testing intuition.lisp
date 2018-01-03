#| Tom Collins
   Monday 1 March 2010
   Incomplete |#

#| The purpose is to check patterns suggested by JT
in Bach's Prelude in E Major, BWV 854. |#

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
(setq
 A
 '((0 64 1/2) (1/2 68 1/2) (1 71 1/2) (3/2 76 1/2)))

(translators-of-pattern-in-dataset
 A dataset-1-1-0-1-0)

(setq
 A*
 '((12 68) (25/2 71) (13 76) (27/2 80)))

(translators-of-pattern-in-dataset
 A* dataset-1-1-0-0-0)

(setq A** '((27 64) (55/2 66) (28 68) (57/2 69)))

(translators-of-pattern-in-dataset
 A** dataset-1-0-1-0-0)

(setq A*** '((30 63) (61/2 65) (31 67) (63/2 69)))

(translators-of-pattern-in-dataset
 A*** dataset-1-0-1-0-0)

(setq Ainv '((60 68) (121/2 66) (61 64) (123/2 62)))

(translators-of-pattern-in-dataset
 Ainv dataset-1-0-1-0-0)

(setq
 Am
 '((0 62 1/2) (1/2 64 1/2) (1 66 1/2) (3/2 69 1/2)))

(translators-of-pattern-in-dataset
 Am dataset-1-0-1-1-0)

(setq
 AB
 '((0 62 1/2) (1/2 64 1/2) (1 66 1/2) (3/2 69 1/2)
   (2 68 1/2) (5/2 69 1/2)))

(translators-of-pattern-in-dataset
 AB dataset-1-0-1-1-0)

(setq
 B
 '((3/2 69 1/2) (2 68 1/2) (5/2 69 1/2)))

(translators-of-pattern-in-dataset
 B dataset-1-0-1-1-0)

(setq
 C '((3 67) (7/2 66) (4 67) (9/2 69)))

(translators-of-pattern-in-dataset
 C dataset-1-0-1-0-0)

(setq
 D '((5 57 1/2) (11/2 56 1/2) (6 57 2)))

(translators-of-pattern-in-dataset
 D dataset-1-0-1-1-0)

(setq
 D2 '((8 58) (17/2 57) (9 56)))

(translators-of-pattern-in-dataset
 D2 dataset-1-0-1-0-0)

(setq
 D3 '((0 58) (1/2 57) (1 57)))

(translators-of-pattern-in-dataset
 D3 dataset-1-0-1-0-0)

(setq
 E '((9 65) (19/2 66) (10 67)))

(translators-of-pattern-in-dataset
 E dataset-1-0-1-0-0)

(setq
 E* '((87/2 67 1/4) (175/4 68 1/4) (44 69 1/2)))

(translators-of-pattern-in-dataset
 E* dataset-1-0-1-1-0)

(setq
 E*ext
 '((87/2 67) (175/4 68) (44 69) (89/2 65) (45 66)))

(translators-of-pattern-in-dataset
 E*ext dataset-1-0-1-0-0)

(setq
 F '((21/2 66 1/2) (11 67 1/2) (23/2 65 1/2)))

(translators-of-pattern-in-dataset
 F dataset-1-0-1-1-0)

(setq G '((55 72 1) (56 70 1/2) (113/2 71 1)))

(translators-of-pattern-in-dataset
 G dataset-1-0-1-1-0)

(setq G2 '((17 69) (35/2 67) (18 68)))

(translators-of-pattern-in-dataset
 G2 dataset-1-0-1-0-0)

(setq
 H
 '((77 66) (309/4 65) (155/2 64) (311/4 63) (78 64)))

(translators-of-pattern-in-dataset
 H dataset-1-0-1-0-0)

(setq
 H2
 '((157/2 62 1/4) (315/4 63 1/4) (79 64 1/4)
   (317/4 65 1/4) (159/2 66 1/4)))

(translators-of-pattern-in-dataset
 H2 dataset-1-0-1-1-0)

(setq
 H3
 '((163/2 71) (327/4 69) (82 68) (329/4 66)
   (165/2 64)))

(translators-of-pattern-in-dataset
 H3 dataset-1-1-0-0-0)

(setq
 H3*
 '((325/4 73) (163/2 71) (327/4 69) (82 68)
   (329/4 66) (165/2 64)))

(translators-of-pattern-in-dataset
 H3* dataset-1-1-0-0-0)

(setq
 I
 '((78 64 1/4) (313/4 63 1/4) (157/2 62 1/4)
   (315/4 63 1/4) (79 64 1/4) (317/4 65 1/4)))

(translators-of-pattern-in-dataset
 I dataset-1-0-1-1-0)

(setq
 J
 (maximal-translatable-pattern-mod-2nd-n
  '(84 5 0) dataset-1-1*-0-0-0 12))

(translators-of-pattern-in-dataset-mod-2nd-n
 J dataset-1-1*-0-0-0 12)

(setq
 J*
 (maximal-translatable-pattern
  '(84 5 0) dataset-1-1-0-1-0))

(translators-of-pattern-in-dataset
 J* dataset-1-1-0-1-0)

(setq
 J**
 (maximal-translatable-pattern
  '(84 -7) dataset-1-1-0-0-0))

(translators-of-pattern-in-dataset
 J** dataset-1-1-0-0-0)

(setq K '((3 58 2) (5 57 1/2) (11/2 56 1/2)))

(translators-of-pattern-in-dataset
 K dataset-1-0-1-1-0)

(setq L '((31 67 1/2) (63/2 69 1/2) (32 68 1/2)))

(translators-of-pattern-in-dataset
 L dataset-1-0-1-1-0)

(setq M '((31 67 1/2) (63/2 69 1/2) (32 68 1/2)))

(translators-of-pattern-in-dataset
 M dataset-1-0-1-1-0)

