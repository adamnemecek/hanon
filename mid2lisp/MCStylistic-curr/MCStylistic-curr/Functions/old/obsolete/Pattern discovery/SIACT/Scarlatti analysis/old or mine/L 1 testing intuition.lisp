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
   dataset-1-1*-0-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-0-0 12 1)))
  (identity "Yes!"))
(progn
  (setq
   dataset-bot
   (orthogonal-projection-not-unique-equalp
    (restrict-dataset-in-nth-to-xs
     dataset 4 '(1)) '(1 1 1 1 0)))
  (setq
   dataset-1-1-0-1-bot
   (orthogonal-projection-unique-equalp
    dataset-bot '(1 1 0 1)))
  (setq
   dataset-1-1*-0-1-bot
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-bot 12 1)))
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

(translators-of-pattern-in-dataset
 A dataset-1-1-0-1-0)

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

(translators-of-pattern-in-dataset-mod-2nd-n
 B dataset-1-1*-0-1-0 12)

(setq
 C*
 (maximal-translatable-pattern
  '(8 0) dataset-1-1-0-0-0))

(translators-of-pattern-in-dataset
 C dataset-1-1-0-0-0)

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
     MTP-8-0* MTP-72-7* MTP-96-7* MTP-104-7*
     MTP-220-0* MTP-244-0* MTP-252-0*))))

(translators-of-pattern-in-dataset-mod-2nd-n
 D dataset-1-1*-0-0-0 12)

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

(translators-of-pattern-in-dataset-mod-2nd-n
 E dataset-1-1*-0-0-0 12)

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

(translators-of-pattern-in-dataset
 F dataset-1-0-1-1-0)

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

(translators-of-pattern-in-dataset
 G dataset-1-1-0-0-0)

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
   MTP-439/3-0-0
   (maximal-translatable-pattern
    '(439/3 0 0) dataset-1-0-1-1-0))
  (setq
   H*
   (intersections-multidimensional
    (list MTP-2-2-0 MTP-4-4-0 MTP-439/3-0-0))))

(translators-of-pattern-in-dataset
 H dataset-1-0-1-1-0)

(setq
 I*
 (maximal-translatable-pattern
  '(148 0) dataset-1-0-0-1-0))

(translators-of-pattern-in-dataset
 I dataset-1-0-0-1-0)

(progn
  (setq
   MTP-4-0
   (maximal-translatable-pattern
    '(4 0) dataset-1-0-0-1-0))
  (setq
   MTP-8-0
   (maximal-translatable-pattern
    '(8 0) dataset-1-0-0-1-0))
  (setq
   MTP-38-0
   (maximal-translatable-pattern
    '(38 0) dataset-1-0-0-1-0))
  (setq
   MTP-70-0
   (maximal-translatable-pattern
    '(70 0) dataset-1-0-0-1-0))
  (setq
   MTP-148-0
   (maximal-translatable-pattern
    '(148 0) dataset-1-0-0-1-0))
  (setq
   MTP-152-0
   (maximal-translatable-pattern
    '(152 0) dataset-1-0-0-1-0))
  (setq
   MTP-156-0
   (maximal-translatable-pattern
    '(156 0) dataset-1-0-0-1-0))
  (setq
   MTP-186-0
   (maximal-translatable-pattern
    '(186 0) dataset-1-0-0-1-0))
  (setq
   MTP-218-0
   (maximal-translatable-pattern
    '(218 0) dataset-1-0-0-1-0))
  (setq
   J*
   (intersections-multidimensional
    (list
     MTP-4-0 MTP-8-0 MTP-38-0 MTP-70-0 MTP-148-0
     MTP-152-0 MTP-156-0 MTP-186-0 MTP-218-0))))

(translators-of-pattern-in-dataset
 J dataset-1-0-0-1-0)

(progn
  (setq
   MTP-2-0
   (maximal-translatable-pattern
    '(2 0) dataset-1-0-0-1-0))
  (setq
   MTP-4-0
   (maximal-translatable-pattern
    '(4 0) dataset-1-0-0-1-0))
  (setq
   MTP-6-0
   (maximal-translatable-pattern
    '(6 0) dataset-1-0-0-1-0))
  (setq
   MTP-28-0
   (maximal-translatable-pattern
    '(28 0) dataset-1-0-0-1-0))
  (setq
   MTP-52-0
   (maximal-translatable-pattern
    '(52 0) dataset-1-0-0-1-0))
  (setq
   MTP-60-0
   (maximal-translatable-pattern
    '(60 0) dataset-1-0-0-1-0))
  (setq
   MTP-148-0
   (maximal-translatable-pattern
    '(148 0) dataset-1-0-0-1-0))
  (setq
   MTP-150-0
   (maximal-translatable-pattern
    '(150 0) dataset-1-0-0-1-0))
  (setq
   MTP-152-0
   (maximal-translatable-pattern
    '(152 0) dataset-1-0-0-1-0))
  (setq
   MTP-154-0
   (maximal-translatable-pattern
    '(154 0) dataset-1-0-0-1-0))
  (setq
   MTP-176-0
   (maximal-translatable-pattern
    '(176 0) dataset-1-0-0-1-0))
  (setq
   MTP-200-0
   (maximal-translatable-pattern
    '(200 0) dataset-1-0-0-1-0))
  (setq
   MTP-208-0
   (maximal-translatable-pattern
    '(208 0) dataset-1-0-0-1-0))
  (setq
   K*
   (intersections-multidimensional
    (list
     MTP-2-0 MTP-4-0 MTP-6-0 MTP-28-0 MTP-52-0
     MTP-60-0 MTP-148-0 MTP-150-0 MTP-152-0
     MTP-154-0 MTP-176-0 MTP-200-0 MTP-208-0))))

(translators-of-pattern-in-dataset
 K dataset-1-0-0-1-0)

(setq
 L*
 (maximal-translatable-pattern-mod-2nd-n
  '(148 5 0) dataset-1-1*-0-1-bot 12))

(translators-of-pattern-in-dataset-mod-2nd-n
 L dataset-1-1*-0-1-bot 12)

(setq
 M*
 (maximal-translatable-pattern-mod-2nd-n
  '(148 5) dataset-1-1*-0-0-0 12))

(translators-of-pattern-in-dataset-mod-2nd-n
 M dataset-1-1*-0-0-0 12)

(setq N* M*)

(translators-of-pattern-in-dataset-mod-2nd-n
 N dataset-1-1*-0-0-0 12)

(progn
  (setq
   MTP-8-0
   (maximal-translatable-pattern
    '(8 0) dataset-1-1-0-0-0))
  (setq
   MTP-148-5
   (maximal-translatable-pattern
    '(148 5) dataset-1-1-0-0-0))
  (setq
   MTP-156-5
   (maximal-translatable-pattern
    '(156 5) dataset-1-1-0-0-0))
  (setq
   O*
   (intersections-multidimensional
    (list MTP-8-0 MTP-148-5 MTP-156-5))))

(translators-of-pattern-in-dataset
 O dataset-1-1-0-0-0)

(progn
  (setq
   MTP-8-0*
   (maximal-translatable-pattern-mod-2nd-n
    '(8 0) dataset-1-1*-0-0-0 12))
  (setq
   MTP-148-5*
   (maximal-translatable-pattern-mod-2nd-n
    '(148 5) dataset-1-1*-0-0-0 12))
  (setq
   MTP-156-5*
   (maximal-translatable-pattern-mod-2nd-n
    '(156 5) dataset-1-1*-0-0-0 12))
  (setq
   P*
   (intersections-multidimensional
    (list MTP-8-0* MTP-148-5* MTP-156-5*))))

(translators-of-pattern-in-dataset-mod-2nd-n
 P dataset-1-1*-0-0-0 12)

(progn
  (setq
   MTP-8-0
   (maximal-translatable-pattern
    '(8 0) dataset-1-1-0-0-0))
  (setq
   MTP-148-5
   (maximal-translatable-pattern
    '(148 5) dataset-1-1-0-0-0))
  (setq
   MTP-156-5
   (maximal-translatable-pattern
    '(156 5) dataset-1-1-0-0-0))
  (setq
   Q*
   (intersections-multidimensional
    (list MTP-8-0 MTP-148-5 MTP-156-5))))

(translators-of-pattern-in-dataset
 Q dataset-1-1-0-0-0)

(progn
  (setq
   MTP-8-0-0
   (maximal-translatable-pattern
    '(8 0 0) dataset-1-0-1-1-0))
  (setq
   MTP-24-7-0
   (maximal-translatable-pattern
    '(24 7 0) dataset-1-0-1-1-0))
  (setq
   MTP-32-7-0
   (maximal-translatable-pattern
    '(32 7 0) dataset-1-0-1-1-0))
  (setq
   MTP-60-0-0
   (maximal-translatable-pattern
    '(60 0 0) dataset-1-0-1-1-0))
  (setq
   MTP-72-1-0
   (maximal-translatable-pattern
    '(72 1 0) dataset-1-0-1-1-0))
  (setq
   MTP-84-3-0
   (maximal-translatable-pattern
    '(84 3 0) dataset-1-0-1-1-0))
  (setq
   MTP-104-0-0
   (maximal-translatable-pattern
    '(104 0 0) dataset-1-0-1-1-0))
  (setq
   MTP-148-3-0
   (maximal-translatable-pattern
    '(148 3 0) dataset-1-0-1-1-0))
  (setq
   MTP-156-3-0
   (maximal-translatable-pattern
    '(156 3 0) dataset-1-0-1-1-0))
  (setq
   MTP-172-10-0
   (maximal-translatable-pattern
    '(172 10 0) dataset-1-0-1-1-0))
  (setq
   MTP-180-10-0
   (maximal-translatable-pattern
    '(180 10 0) dataset-1-0-1-1-0))
  (setq
   R*
   (intersections-multidimensional
    (list
     MTP-8-0-0 MTP-24-7-0 MTP-32-7-0 MTP-60-0-0
     MTP-72-1-0 MTP-84-3-0 MTP-104-0-0 MTP-148-3-0
     MTP-156-3-0 MTP-172-10-0 MTP-180-10-0))))

(translators-of-pattern-in-dataset
 R dataset-1-0-1-1-0)

(progn
  (setq
   MTP-8-0-0
   (maximal-translatable-pattern
    '(8 0 0) dataset-1-1-0-1-0))
  (setq 
   MTP-104-0-0
   (maximal-translatable-pattern
    '(104 0 0) dataset-1-1-0-1-0))
  (setq 
   MTP-148-5-0
   (maximal-translatable-pattern
    '(148 5 0) dataset-1-1-0-1-0))
  (setq 
   MTP-156-5-0
   (maximal-translatable-pattern
    '(156 5 0) dataset-1-1-0-1-0))
  (setq
   S*
   (intersections-multidimensional
    (list
     MTP-8-0-0 MTP-104-0-0 MTP-148-5-0 MTP-156-5-0))))

(translators-of-pattern-in-dataset
 S dataset-1-1-0-1-0)

(progn
  (setq
   MTP-12-1
   (maximal-translatable-pattern
    '(12 1) dataset-1-0-1-0-0))
  (setq
   MTP-24-3
   (maximal-translatable-pattern
    '(24 3) dataset-1-0-1-0-0))
  (setq
   pattern-T*
   (intersections-multidimensional
    (list MTP-12-1 MTP-24-3))))

(translators-of-pattern-in-dataset
 pattern-T dataset-1-0-1-0-0)

(progn
  (setq
   MTP-12-1
   (maximal-translatable-pattern
    '(12 1) dataset-1-0-1-0-0))
  (setq
   MTP-24-3
   (maximal-translatable-pattern
    '(24 3) dataset-1-0-1-0-0))
  (setq
   MTP-28-3
   (maximal-translatable-pattern
    '(28 3) dataset-1-0-1-0-0))
  (setq
   MTP-32-3
   (maximal-translatable-pattern
    '(32 3) dataset-1-0-1-0-0))
  (setq
   U*
   (intersections-multidimensional
    (list MTP-12-1 MTP-24-3 MTP-28-3 MTP-32-3))))

(translators-of-pattern-in-dataset
 U dataset-1-0-1-0-0)

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
   V*
   (intersections-multidimensional
    (list MTP-4-0 MTP-8-0))))

(translators-of-pattern-in-dataset
 V dataset-1-1-0-0-0)

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
   W*
   (intersections-multidimensional
    (list MTP-4-0-0 MTP-8-0-0))))

(translators-of-pattern-in-dataset
 W dataset-1-1-0-1-0)

(progn
  (setq
   MTP-2-3-0
   (maximal-translatable-pattern
    '(2 -3 0) dataset-1-0-1-1-0))
  (setq
   MTP-4-4-0
   (maximal-translatable-pattern
    '(4 -4 0) dataset-1-0-1-1-0))
  (setq
   MTP-6-6-0
   (maximal-translatable-pattern
    '(6 -6 0) dataset-1-0-1-1-0))
 (setq
   X*
   (intersections-multidimensional
    (list MTP-2-3-0 MTP-4-4-0 MTP-6-6-0))))

(translators-of-pattern-in-dataset
 X dataset-1-0-1-1-0)
