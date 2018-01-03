#| Tom Collins
   Wednesday 3 March 2010
   Incomplete |#

#| The purpose is to check patterns suggested by JT
in Scarlatti's Sonata in C Minor, L 10. |#

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
  "/Scarlatti sonatas/L 10.lisp"))
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
 (maximal-translatable-pattern
  '(6 -12 0) dataset-1-1-0-1-0))

(translators-of-pattern-in-dataset
 A dataset-1-1-0-1-0)

(setq
 J
 (maximal-translatable-pattern
  '(93 -10) dataset-1-0-1-0-0))

(translators-of-pattern-in-dataset
 J dataset-1-0-1-0-0)

(setq
 N
 (maximal-translatable-pattern
  '(803/4 0) dataset-1-0-1-0-0))

(translators-of-pattern-in-dataset
 N dataset-1-0-1-0-0)

(setq
 N3*
 '((7/2 74) (4 71) (9/2 69)))

(translators-of-pattern-in-dataset
 N3* dataset-1-0-1-0-0)

(setq
 B
 (maximal-translatable-pattern
  '(36 -12) dataset-1-0-1-0-0))

(translators-of-pattern-in-dataset
 B dataset-1-0-1-0-0)

(setq
 H
 '((49/4 79) (25/2 81) (51/4 83) (13 84)))

(translators-of-pattern-in-dataset
 H dataset-1-1-0-0-0)

(setq
 C
 '((13 67 1) (14 67 1)))

(translators-of-pattern-in-dataset
 C dataset-1-1-0-1-0)

(setq
 D
 '((51/2 69 1/2) (103/4 71 1/4) (26 70 1/2)
   (105/4 72 1/4) (53/2 68 1/2) (107/4 70 1/4)
   (27 69 1/2) (109/4 71 1/4) (55/2 66 1/2)
   (111/4 68 1/4) (28 67 1/2) (113/4 69 1/4)))

(translators-of-pattern-in-dataset
 D dataset-1-0-1-1-0)

(setq
 D*
 '((51/2 69 1/2) (103/4 71 1/4) (26 70 1/2)
   (105/4 72 1/4)))

(translators-of-pattern-in-dataset
 D* dataset-1-0-1-1-0)

(setq
 D**
 '((53/2 68 1/2) (107/4 70 1/4) (27 69 1/2)
   (109/4 71 1/4) (55/2 66 1/2) (111/4 68 1/4)
   (28 67 1/2) (113/4 69 1/4)))

(translators-of-pattern-in-dataset
 D** dataset-1-0-1-1-0)

(setq
 B2
 '((79/2 71 1/2) (40 65 1/2) (40 70 1/2)
   (81/2 64 1/2) (81/2 69 1/2) (41 65 1/2)
   (41 70 1/2) (83/2 64 1/2) (83/2 69 1/2)
   (42 65 1/2) (42 70 1/2)))

(translators-of-pattern-in-dataset
 B2 dataset-1-0-1-1-0)

(setq
 B2*
 '((13 69) (13 74) (27/2 68) (27/2 73) (14 69)
   (14 74) (29/2 68) (29/2 73) (15 69) (15 74)))

(translators-of-pattern-in-dataset
 B2* dataset-1-0-1-0-0)

(setq
 K
 '((103/2 64) (103/2 69) (52 64) (52 69) (105/2 63)
   (105/2 68) (53 63) (53 68) (107/2 62)
   (107/2 67)))

(translators-of-pattern-in-dataset
 K dataset-1-0-1-0-0)

(setq
 C2
 '((52 41 1) (52 53 1)))

(translators-of-pattern-in-dataset
 C2 dataset-1-1-0-1-0)

(setq
 E-maybe
 '((65 67) (65 69) (131/2 66) (131/2 68) (263/4 65)
   (263/4 67) (66 66)))

(setq
 E
 '((65 72 1/2) (65 75 1/2) (131/2 71 1/4)
   (131/2 74 1/4) (263/4 69 1/4) (263/4 72 1/4)
   (66 71 1/2)))

(translators-of-pattern-in-dataset
 E dataset-1-1-0-1-0)

(setq
 F
 (maximal-translatable-pattern
  '(7 -12) dataset-1-1-0-0-0))

(translators-of-pattern-in-dataset
 F dataset-1-1-0-0-0)

(setq
 K2
 '((127/2 70) (64 70) (129/2 69) (65 69) (131/2 68)
   (263/4 67) (66 66) (66 68)))

(translators-of-pattern-in-dataset
 K2 dataset-1-0-1-0-0)

(setq G '((25/2 81) (51/4 83) (13 84)))

(translators-of-pattern-in-dataset
 G dataset-1-1-0-0-0)

(setq
 L
 '((241/2 64) (121 65) (122 66) (123 67)))

(translators-of-pattern-in-dataset
 L dataset-1-0-1-0-0)

(setq
 L2
 '((127 56 1) (128 57 1/2) (257/2 58 1/2)
   (129 59 1)))

(translators-of-pattern-in-dataset
 L2 dataset-1-0-1-1-0)

(setq
 Linv
 '((127 70 1) (128 69 1) (129 68 1/2)))

(translators-of-pattern-in-dataset
 Linv dataset-1-0-1-1-0)

(setq
 K3
 '((253/2 63 1/2) (127 63 1/2) (255/2 62 1/2)
   (128 62 1) (129 61 1)))

(translators-of-pattern-in-dataset
 K3 dataset-1-0-1-1-0)

(setq
 I
 '((87 1) (349/4 1) (175/2 5) (351/4 5) (88 3)
   (353/4 3) (177/2 1)))

(translators-of-pattern-in-dataset-mod-2nd-n
 I dataset-1-0-1*-0-0 7)


