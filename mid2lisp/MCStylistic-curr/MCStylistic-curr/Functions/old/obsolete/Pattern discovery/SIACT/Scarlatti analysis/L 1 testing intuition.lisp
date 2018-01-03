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

(setq
 A
 '((1/2 72 1/2) (1 76 1/2) (3/2 79 1/2) (2 84 2)))

(translators-of-pattern-in-dataset
 A dataset-1-1-0-1-0)

(setq
 A2
 '((5/2 67 1/2) (3 64 1/2) (7/2 60 1/2) (4 36 2)))

(translators-of-pattern-in-dataset
 A2 dataset-1-1-0-1-0)

(setq
 A3
 '((21/2 67 1/2) (11 64 1/2) (23/2 60 1/2)
   (12 41 1)))

(translators-of-pattern-in-dataset
 A3 dataset-1-1-0-1-0)

(setq
 B
 '((12 5) (12 9) (13 5) (14 2) (14 7) (15 7)
   (16 0)))

(translators-of-pattern-in-dataset-mod-2nd-n
 B dataset-1-1*-0-0-0 12)

(setq C '((24 67) (25 74) (26 64)))

(translators-of-pattern-in-dataset
 C dataset-1-0-1-0-0)

(setq
 C2
 '((28 59 1) (28 61 1) (29 52 1) (29 75 1) (30 59 2)
   (30 61 2)))

(translators-of-pattern-in-dataset
 C2 dataset-1-0-1-1-0)

(setq C3 '((26 60 2) (26 62 2) (28 59 1) (28 61 1)))

(translators-of-pattern-in-dataset
 C3 dataset-1-0-1-1-0)

(setq
 H
 '((14 68) (16 67)))

(translators-of-pattern-in-dataset
 H dataset-1-0-1-0-0)

(setq
 D
 '((127/3 84) (128/3 83) (43 81) (130/3 83)
   (131/3 84) (44 83) (133/3 84) (134/3 86)
   (45 86)))

(translators-of-pattern-in-dataset
 D dataset-1-1-0-0-0)

(setq
 D
 '((127/3 84) (128/3 83) (43 81) (130/3 83)
   (131/3 84) (44 83) (133/3 84) (134/3 86)
   (45 86)))

(translators-of-pattern-in-dataset
 D dataset-1-1-0-0-0)

(setq
 D2 '((43 73 1/3) (130/3 74 1/3) (131/3 75 1/3)))

(translators-of-pattern-in-dataset
 D2 dataset-1-0-1-1-0)

(setq E '((40 79 1) (41 43 1) (42 38 2)))

(translators-of-pattern-in-dataset
 E dataset-1-1-0-1-0)

(setq E0 '((22 55) (23 43) (24 36)))

(translators-of-pattern-in-dataset
 E0 dataset-1-1-0-0-0)

(setq
 F
 '((54 78 1/3) (163/3 77 1/3) (164/3 76 1/3)
   (55 75 1/3) (166/3 74 1/3) (167/3 73 1/3)))

(translators-of-pattern-in-dataset
 F dataset-1-0-1-1-0)

(setq
 G
 '((52 43 2) (54 31 2)))

(translators-of-pattern-in-dataset
 G dataset-1-1-0-1-0)

(setq
 Ginv
 '((56 36 2) (58 48 2)))

(translators-of-pattern-in-dataset
 Ginv dataset-1-1-0-1-0)

(setq
 H2
 '((62 72 3/2) (127/2 71 1/4) (255/4 72 1/4)
   (64 71 2)))

(translators-of-pattern-in-dataset
 H2 dataset-1-0-1-1-0)

(setq
 H2
 '((62 72) (127/2 71) (255/4 72) (64 71)))

(translators-of-pattern-in-dataset
 H2 dataset-1-0-1-0-0)

(setq
 I
 '((66 55 57 1 1) (66 65 63 1 1)
     (67 55 57 1 1) (67 65 63 1 1) (68 55 57 1 1)
     (68 64 62 1 1) (69 55 57 1 1) (69 64 62 1 1)
      (70 66 63 1 1) (72 67 64 2 1)))

(setq
 I
 '((66 55) (66 65) (67 55) (67 65) (68 55) (68 64)
   (69 55) (69 64) (70 66) (72 67)))

(translators-of-pattern-in-dataset
 I dataset-1-1-0-0-0)

(setq
 A3
 '((241/3 7) (242/3 2) (81 11) (244/3 7) (245/3 2)
   (82 7) (247/3 2) (248/3 11) (83 7) (250/3 2)
   (251/3 7) (84 0)))

(translators-of-pattern-in-dataset-mod-2nd-n
 A3 dataset-1-1*-0-0-0 12)

(setq
 I2
 '((124 57) (124 64) (125 57) (125 64) (126 57)
   (126 63) (127 57) (127 63) (128 57) (128 62)
   (129 57) (129 62) (130 57) (130 61) (131 57)
   (131 61) (132 57) (132 58) (132 60)))

(translators-of-pattern-in-dataset
 I2 dataset-1-0-1-0-0)

(setq C4 '((132 81 1) (133 69 2)))

(translators-of-pattern-in-dataset
 C4 dataset-1-1-0-1-0)

(setq C4inv '((172 72 1) (173 84 1)))

(translators-of-pattern-in-dataset
 C4inv dataset-1-1-0-1-0)

(setq
 D2inv '((176 83) (529/3 81) (530/3 79) (177 79)))

(translators-of-pattern-in-dataset
 D2inv dataset-1-1-0-0-0)

(setq
 I3
 '())


















































