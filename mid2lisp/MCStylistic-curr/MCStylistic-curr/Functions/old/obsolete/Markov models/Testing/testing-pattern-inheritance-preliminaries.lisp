
;REQUIRED PACKAGES
;(in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/hash-tables.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/evaluation-for-SIACT.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/evaluation-preliminaries.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Markov models"
  "/pattern-inheritance-preliminaries.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/SIA-specific.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))

(progn
  (setq
   dataset-all
   (read-from-file
    "/Users/tec69/Open/Music/Datasets/C-68-1-ed.txt"))
  (setq dataset-mini (subseq dataset-all 0 350))
  (setq
   projected-dataset
   (orthogonal-projection-unique-equalp
    dataset-mini '(1 1 1 0 0)))
  "Yes!")

(maximal-translatable-pattern
 '(6 0 0) projected-dataset)

(setq
 A
 '((0 36 46) (0 48 53) (0 55 57) (0 60 60) (0 64 62)
   (1/2 36 46) (1/2 48 53) (1/2 55 57) (1/2 62 61)
   (1/2 65 63) (1 36 46) (1 48 53) (1 55 57) (1 64 62)
   (1 67 64) (2 48 53) (2 65 63) (2 69 65) (3 36 46)
   (3 48 53) (3 55 57) (3 64 62) (3 67 64) (7/2 36 46)
   (7/2 48 53) (7/2 55 57) (7/2 60 60) (7/2 64 62)
   (4 36 46) (4 48 53) (4 55 57)))
(compactness A projected-dataset)
(translators-of-pattern-in-dataset
 A projected-dataset)

(setq B (subseq A 10 20))
(translators-of-pattern-in-dataset
 B projected-dataset)

(setq
 C
 '((6 60 60) (7 55 57) (9 55 57) (9 60 60)
   (10 48 53) (10 55 57) (10 64 62) (13 55 57)
   (13 59 59) (14 55 57) (14 59 59) (19 55 57)
   (19 59 59) (20 55 57) (20 59 59) (25 55 57)
   (25 62 61) (26 55 57) (26 62 61) (27 72 67)
   (28 48 53) (28 55 57) (28 64 62) (31 55 57)
   (31 62 61) (32 55 57) (32 62 61) (33 72 67)
   (34 48 53) (34 55 57) (34 64 62) (37 55 57)
   (37 59 59)))
(translators-of-pattern-in-dataset
 C projected-dataset)

(setq E '((3 48 53) (7/2 48 53) (4 48 53)))
(translators-of-pattern-in-dataset
 E projected-dataset)
(setq MTP-vector '(45 41 24))

(setq
 F 
 '((11 71 66) (23/2 72 67) (12 54 56) (12 57 58)
   (12 60 60) (12 62 61) (12 74 68) (25/2 74 68)
   (13 53 56) (13 55 57) (13 59 59) (13 62 61)
   (13 74 68) (14 53 56) (14 55 57) (14 59 59)
   (14 62 61) (14 67 64) (29/2 71 66) (15 52 55)
   (15 55 57) (15 60 60) (15 72 67) (31/2 74 68)
   (16 48 53) (16 55 57) (16 64 62) (16 76 69)
   (33/2 77 70) (17 79 71) (35/2 80 71) (18 43 50)
   (18 81 72) (37/2 81 72) (19 55 57) (19 59 59)
   (19 65 63) (20 55 57) (20 59 59) (20 65 63)
   (20 79 71) (41/2 74 68) (21 48 53) (21 77 70)
   (43/2 77 70) (22 57 58) (22 65 63) (22 77 70)
   (23 55 57) (23 64 62) (23 76 69) (24 54 56)
   (24 57 58) (24 60 60) (24 62 61) (24 74 68)
   (49/2 74 68) (25 53 56) (25 55 57) (25 59 59)
   (25 62 61) (25 74 68) (26 53 56) (26 55 57)
   (26 59 59) (26 62 61) (26 67 64) (53/2 71 66)
   (27 52 55) (27 55 57) (27 60 60) (27 72 67)
   (55/2 74 68) (28 48 53) (28 55 57) (28 64 62)
   (28 76 69) (57/2 77 70) (29 79 71) (59/2 84 74)
   (30 43 50) (30 83 73) (123/4 81 72) (31 55 57)
   (31 62 61) (31 65 63) (31 77 70) (63/2 74 68)
   (32 55 57) (32 62 61) (32 65 63) (32 71 66)
   (65/2 67 64) (33 48 53) (33 64 62) (33 72 67)
   (100/3 74 68) (67/2 67 64) (101/3 76 69) (34 48 53)
   (34 55 57) (34 60 60) (34 64 62) (34 72 67)))
(translators-of-pattern-in-dataset
 F projected-dataset)

(setq
 G
 '((12 54 56) (12 57 58) (12 60 60) (12 62 61)
   (12 74 68) (25/2 74 68) (13 53 56) (13 55 57)
   (13 59 59) (13 62 61) (13 74 68) (14 53 56)
   (14 55 57) (14 59 59) (14 62 61) (14 67 64)
   (29/2 71 66) (15 52 55) (15 55 57) (15 60 60)
   (15 72 67) (31/2 74 68) (16 48 53) (16 55 57)
   (16 64 62) (16 76 69) (33/2 77 70) (17 79 71)
   (18 43 50) (19 55 57) (19 65 63) (20 55 57)
   (20 65 63) (21 48 53)))
(translators-of-pattern-in-dataset
 G projected-dataset)

(setq H (butlast (translation G '(24 0 0))))

(setq
 pattern-compact-vec-triples
 (list
  (list A (compactness A projected-dataset) '(6 0 0))
  (list
   B (compactness B projected-dataset) '(6 0 0))
  (list C (compactness C projected-dataset) '(6 0 0))
  (list
   E (compactness E projected-dataset) '(45 26 15)
   (compactness E projected-dataset) '(3 7 4))
  (list F (compactness F projected-dataset) '(24 0 0))
  (list G (compactness G projected-dataset) '(12 0 0))
  (list
   H (compactness H projected-dataset) '(12 0 0))))

(setq
 patterns-hash
 (evaluate-variables-of-patterns2hash
  pattern-compact-vec-triples projected-dataset
  '(4.277867 3.422478734 -0.038536808 0.651073171)
  '(73.5383283152 0.02114878519)))

(length A) - pattern 0
(length B) - pattern 1
(length C) - pattern 2
(length E) - pattern 3
(length F) - pattern 4
(length G) - pattern 5
(length H) - pattern 6

(write-to-file-balanced-hash-table
 patterns-hash
 (concatenate
   'string
   "/Applications/CCL/Lisp documentation"
   "/Example files/patterns-hash.txt"))

(subset-score-of-pattern
 (gethash '"pattern" (nth 3 patterns-hash))
 3 patterns-hash)

(subset-score-of-pattern
 (translation
  (gethash '"pattern" (nth 3 patterns-hash))
  '(12 38 22))
 3 patterns-hash)

(setq
 probe-pattern
 (gethash '"pattern" (nth 3 patterns-hash)))
(setq index-in-patterns-hash 3)
(setq n (length patterns-hash))
(setq i 0)
(setq growing-result 0)
(setq pattern-hash
         (if (< i n) (nth i patterns-hash)))

(write-to-file-balanced-hash-table
 patterns-hash
 (concatenate
   'string
   "/Applications/CCL/Lisp documentation"
   "/Example files/patterns-hash2.txt"))

