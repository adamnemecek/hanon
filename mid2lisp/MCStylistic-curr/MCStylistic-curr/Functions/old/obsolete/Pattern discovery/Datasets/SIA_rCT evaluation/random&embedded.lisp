#| Tom Collins
   Friday 30 July 2010
   Incomplete

\noindent This code generates random datasets
embedded with translational patterns. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/augmenting-datasets.lisp"))
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

(setq
 A1
 '((1 3) (1 4) (1 5) (1 6) (1 7) (2 2) (2 6) (3 2)
   (3 6) (4 1) (4 2) (4 4) (4 5) (5 2) (5 6) (6 2)))
(setq A2 (translation A1 '(15 32)))
(setq A3 (translation A1 '(33 1)))

(setq B1 '((1 6) (2 6) (3 6) (4 4) (4 5) (5 6)))
(setq B2 (translation B1 '(15 32)))
(setq B3 (translation B1 '(26 -1)))
(setq B4 (translation B1 '(33 1)))
(setq B5 (translation B1 '(52 39)))
(setq B6 (translation B1 '(93 -3)))
(setq B7 (translation B1 '(93 90)))

(setq
 C1
 '((8 13) (9 14) (10 15) (12 16) (13 15) (13 16)
   (14 14) (15 14) (17 14) (18 14) (18 15) (18 16)
   (19 13)))
(setq C2 (translation C1 '(8 3)))
(setq C3 (translation C1 '(71 48)))

(setq
 E1
 '((22 61) (23 59) (24 59) (24 60) (25 58) (25 61)
   (25 63) (26 57) (26 62) (27 53) (27 55) (27 58)
   (27 61) (27 63) (27 65) (27 67) (27 68) (28 58)
   (28 59) (29 60) (29 62) (30 61) (31 60)
   (31 62)))
(setq E2 (translation E1 '(47 -26)))

(setq
 F1
 '((23 59) (24 59) (24 60) (25 61) (25 63) (26 62)
   (27 61) (27 63)))
(setq F2 (translation F1 '(4 -1)))
(setq F3 (translation F1 '(47 -26)))
(setq F4 (translation F1 '(51 -27)))

#| A little example just consisting of TECs A, B, and
C.
(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 C1 C2)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code"
  "/Pattern discovery/Datasets/SIA_rCT evaluation"
  "/very-mini-dataset.csv"))

A little example just consisting of TECs A, B, and
C, E, and F.
(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/mini-dataset.csv"))
|#

(setq
 G1
 '((51 65) (53 69) (54 71) (56 74) (58 70) (59 67)
   (60 64) (61 62) (61 64) (62 61) (63 64) (65 65)
   (66 63) (67 67) (68 65) (70 68)))
(setq G2 (translation G1 '(0 25)))

(setq
 H1
 '((20 88) (22 89) (23 89) (24 87) (24 88) (24 90)
   (24 92) (26 88) (27 88)))
(setq H2 (translation H1 '(4 -1)))
(setq H3 (translation H1 '(8 -2)))

(setq
 I1
 '((50 11) (50 18) (51 15) (53 18) (57 14) (59 16)
   (63 15)))
(setq I2 (translation I1 '(30 0)))

(setq J1
      '((1 96) (2 94) (2 95) (3 96) (4 97) (4 99)))
(setq J2 (translation J1 '(95 -93)))

(setq
 K1
 '((53 45) (54 45) (54 47) (54 48) (55 45) (55 48)
   (56 43) (56 44) (56 47) (57 45) (57 46) (58 47)
   (58 45) (58 46)))
(setq K2 (translation K1 '(41 51)))

(progn
  (setq
   union-of-patterns
   (unions-multidimensional-sorted-asc
    (list
     A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1
     F2 F3 F4 G1 G2 H1 H2 H3 I1 I2 J1 J2 K1 K2)))
  "Yes!")

#| This is how to save the original dataset to a csv
file.
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/embeddings"
  "/D-250.csv"))
|#

#| This is how to augment the original dataset (union-
of-patterns) with some random uniformly-distributed
datapoints.
(progn
  ;(defvar *rs* (make-random-state t))
  (setq
   embedded
   (augment-dataset-with-unique-randoms
    union-of-patterns 1000 100 *rs*))
  (dataset2csv
   embedded
   (concatenate
    'string
    "/Applications/CCL/Lisp code"
    "/Pattern discovery/Datasets/SIA_rCT evaluation"
    "/embeddings/D-ca-1000-20.csv")))
|#

#| Now we create the dataset for constant density and
size 650. |#
(progn
  (setq A1-650 (scale&round-lists-by A1 2))
  (setq
   A2-650
   (translation
    A1-650
    (scale&round-list-by '(15 32) 2)))
  (setq
   A3-650
   (translation
    A1-650
    (scale&round-list-by '(33 1) 2)))
  (setq B1-650 (scale&round-lists-by B1 2))
  (setq
   B2-650
   (translation
    B1-650
    (scale&round-list-by '(15 32) 2)))
  (setq
   B3-650
   (translation
    B1-650
    (scale&round-list-by '(26 -1) 2)))
  (setq
   B4-650
   (translation
    B1-650
    (scale&round-list-by '(33 1) 2)))
  (setq
   B5-650
   (translation
    B1-650
    (scale&round-list-by '(52 39) 2)))
  (setq
   B6-650
   (translation
    B1-650
    (scale&round-list-by '(93 -3) 2)))
  (setq
   B7-650
   (translation
    B1-650
    (scale&round-list-by '(93 90) 2)))
  (setq C1-650 (scale&round-lists-by C1 2))
  (setq
   C2-650
   (translation
    C1-650
    (scale&round-list-by '(8 3) 2)))
  (setq
   C3-650
   (translation
    C1-650
    (scale&round-list-by '(71 48) 2)))
  (setq E1-650 (scale&round-lists-by E1 2))
  (setq
   E2-650
   (translation
    E1-650
    (scale&round-list-by '(47 -26) 2)))
  (setq F1-650 (scale&round-lists-by F1 2))
  (setq
   F2-650
   (translation
    F1-650
    (scale&round-list-by '(4 -1) 2)))
  (setq
   F3-650
   (translation
    F1-650
    (scale&round-list-by '(47 -26) 2)))
  (setq
   F4-650
   (translation
    F1-650
    (scale&round-list-by '(51 -27) 2)))
  (setq G1-650 (scale&round-lists-by G1 2))
  (setq
   G2-650
   (translation
    G1-650
    (scale&round-list-by '(0 25) 2)))
  (setq H1-650 (scale&round-lists-by H1 2))
  (setq
   H2-650
   (translation
    H1-650
    (scale&round-list-by '(4 -1) 2)))
  (setq
   H3-650
   (translation
    H1-650
    (scale&round-list-by '(8 -2) 2)))
  (setq I1-650 (scale&round-lists-by I1 2))
  (setq
   I2-650
   (translation
    I1-650
    (scale&round-list-by '(30 0) 2)))
  (setq J1-650 (scale&round-lists-by J1 2))
  (setq
   J2-650
   (translation
    J1-650
    (scale&round-list-by '(95 -93) 2)))
  (setq K1-650 (scale&round-lists-by K1 2))
  (setq
   K2-650
   (translation
    K1-650
    (scale&round-list-by '(41 51) 2)))
  (setq
   union-of-patterns-650
   (unions-multidimensional-sorted-asc
    (list
     A1-650 A2-650 A3-650 B1-650 B2-650 B3-650
     B4-650 B5-650 B6-650 B7-650 C1-650 C2-650
     C3-650 E1-650 E2-650 F1-650 F2-650 F3-650
     F4-650 G1-650 G2-650 H1-650 H2-650 H3-650
     I1-650 I2-650 J1-650 J2-650 K1-650
     K2-650)))
  "Yes!")

#| This is how to save the size-650 original to a csv
file.
(dataset2csv
 union-of-patterns-650
 (concatenate
  'string
  "/Applications/CCL/Lisp code"
  "/Pattern discovery/Datasets/SIA_rCT evaluation"
  "/embeddings/D-250-sf2.csv"))
|#

#| This is how to augment the size-650 dataset with
some random uniformly-distributed datapoints.
(progn
  ;(defvar *rs* (make-random-state t))
  (setq
   embedded
   (augment-dataset-with-unique-randoms
    union-of-patterns-650 650 200 *rs*))
  (dataset2csv
   embedded
   (concatenate
    'string
    "/Applications/CCL/Lisp code"
    "/Pattern discovery/Datasets/SIA_rCT evaluation"
    "/embeddings/D-cd-650-20.csv")))
|#



#| 19/9/2010 Obsolete. Now we create the dataset for
constant density and size 300. |#
(progn
  (setq A1-300 (scale&round-lists-by A1 1.1))
  (setq
   A2-300
   (translation
    A1-300
    (scale&round-list-by '(15 32) 1.1)))
  (setq
   A3-300
   (translation
    A1-300
    (scale&round-list-by '(33 1) 1.1)))
  (setq B1-300 (scale&round-lists-by B1 1.1))
  (setq
   B2-300
   (translation
    B1-300
    (scale&round-list-by '(15 32) 1.1)))
  (setq
   B3-300
   (translation
    B1-300
    (scale&round-list-by '(26 -1) 1.1)))
  (setq
   B4-300
   (translation
    B1-300
    (scale&round-list-by '(33 1) 1.1)))
  (setq
   B5-300
   (translation
    B1-300
    (scale&round-list-by '(52 39) 1.1)))
  (setq
   B6-300
   (translation
    B1-300
    (scale&round-list-by '(93 -3) 1.1)))
  (setq
   B7-300
   (translation
    B1-300
    (scale&round-list-by '(93 90) 1.1)))
  (setq C1-300 (scale&round-lists-by C1 1.1))
  (setq
   C2-300
   (translation
    C1-300
    (scale&round-list-by '(8 3) 1.1)))
  (setq
   C3-300
   (translation
    C1-300
    (scale&round-list-by '(69 48) 1.1)))
  (setq
   E1-300
   '((24 67) (25 65) (26 65) (26 66) (28 64) (28 67)
     (28 69) (29 64) (29 68) (30 58) (30 60) (30 64)
     (30 65) (30 67) (30 69) (30 72) (30 74) (30 75)
     (31 64) (32 66) (32 68) (33 67) (34 66) (34 68)))
  (setq
   E2-300
   (translation
    E1-300
    (scale&round-list-by '(47 -26) 1.1)))
  (setq F1-300 (scale&round-lists-by F1 1.1))
  (setq
   F2-300
   (translation
    F1-300
    (scale&round-list-by '(4 -1) 1.1)))
  (setq
   F3-300
   (translation
    F1-300
    (scale&round-list-by '(47 -26) 1.1)))
  (setq
   F4-300
   (translation
    F1-300
    (scale&round-list-by '(51 -27) 1.1)))
  (setq G1-300 (scale&round-lists-by G1 1.1))
  (setq
   G2-300
   (translation
    G1-300
    (scale&round-list-by '(0 25) 1.1)))
  (setq
   H1-300
   '((22 97) (24 98) (25 98) (26 96) (26 97) (26 99)
     (26 101) (28 97) (29 97)))
  (setq
   H2-300
   (translation
    H1-300
    (scale&round-list-by '(4 -1) 1.1)))
  (setq H3-300 (translation H1-300 '(8 -2)))
  (setq I1-300 (scale&round-lists-by I1 1.1))
  (setq
   I2-300
   (translation
    I1-300
    (scale&round-list-by '(33 0) 1.1)))
  (setq
   J1-300
   '((1 106) (2 103) (2 105) (3 106) (4 106) (4 109)))
  (setq
   J2-300
   (translation
    J1-300
    (scale&round-list-by '(95 -93) 1.1)))
  (setq
   K1-300
   '((58 50) (59 50) (59 52) (59 53) (60 50) (60 53)
     (61 47) (61 49) (62 52) (63 50) (63 51) (64 52)
     (64 50) (64 51)))
  (setq
   K2-300
   (translation
    K1-300
    (scale&round-list-by '(41 51) 1.1)))
  (setq
   union-of-patterns-300
   (unions-multidimensional-sorted-asc
    (list
     A1-300 A2-300 A3-300 B1-300 B2-300 B3-300 B4-300
     B5-300 B6-300 B7-300 C1-300 C2-300 C3-300 E1-300
     E2-300 F1-300 F2-300 F3-300 F4-300 G1-300 G2-300
     H1-300 H2-300 H3-300 I1-300 I2-300 J1-300 J2-300
     K1-300 K2-300)))
  "Yes!")

#| This is how to save the size-300 original to a csv
file.
(dataset2csv
 union-of-patterns-300
 (concatenate
  'string
  "/Applications/CCL/Lisp code"
  "/Pattern discovery/Datasets/dataset-300.csv"))
|#

