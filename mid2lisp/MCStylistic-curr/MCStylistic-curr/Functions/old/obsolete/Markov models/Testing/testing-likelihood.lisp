#| Tom Collins
   Sunday 26 September 2010
   Incomplete

\noindent The idea is to take a look at some plots
of the probability of states in different phrases. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/csv-files.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/pattern-importance-preliminaries.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Markov models"
  "/segmentation.lisp"))
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
    "/Users/tec69/Open/Music/Datasets/C-41-2-ed.txt"))
  "Yes!")
(progn
  (setq dataset (subseq dataset-all 0 184))
  (my-last dataset))
(progn
  (setq
   dataset-proj
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 0 0)))
  "Yes!")

(setq pattern (subseq dataset-proj 0 5))
(float
 (likelihood-of-pattern-or-translation
  pattern dataset-proj))

(segments-strict (subseq dataset 0 16) 1 3)

; Version 1
(mapcar
 #'(lambda (x)
     (list
      (first x)
      (float
       (likelihood-of-pattern-or-translation
        (orthogonal-projection-unique-equalp
         (second x) (list 1 1 0 0 0))
        dataset-proj))))
 (butlast
  (segments-strict (subseq dataset 0 184) 1 3)))


; Version 2
(progn
  (setq
   segments
   (butlast 
    (segments-strict (subseq dataset 0 184) 1 3)))
  (setq
   ontimes-list
   (mapcar
    #'(lambda (x)
        (first x))
    dataset-proj))
   "Yes!")

(progn
  (setq
   likelihood-curve
   (mapcar
    #'(lambda (x)
        (list
         (first x)
         (float
          (likelihood-of-pattern-or-translation
           (orthogonal-projection-unique-equalp
            (second x) (list 1 1 0 0 0))
           (subseq
            dataset-proj
            (index-1st-sublist-item>=
             (- (first x) 12)
             ontimes-list)
            (+
             (index-item-1st-occurs
              (my-last
               (orthogonal-projection-unique-equalp
                (second x) (list 1 1 0 0 0)))
              dataset-proj) 1))))))
    segments))
  (dataset2csv
   likelihood-curve
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/likelihood-curve-C-41-2.csv")))

(progn
  (setq
   likelihood-curve2
   (mapcar
    #'(lambda (x)
        (list
         (first x)
         (float
          (likelihood-of-subset
           (orthogonal-projection-not-unique-equalp
            (second x) (list 0 1 0 0 0))
           (empirical-mass
            (orthogonal-projection-not-unique-equalp
             (subseq
              dataset-proj
              (index-1st-sublist-item>=
               (- (first x) 12)
               ontimes-list)
              (+
               (index-item-1st-occurs
                (my-last
                 (orthogonal-projection-unique-equalp
                  (second x) (list 1 1 0 0 0)))
                dataset-proj) 1))
             (list 0 1)))))))
    segments))
  (dataset2csv
   likelihood-curve2
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/likelihood-curve2-C-41-2.csv")))

(progn
  (setq
   likelihood-curve3
   (mapcar
    #'(lambda (x)
        (list
         (first x)
         (expt
          (likelihood-of-subset
           (orthogonal-projection-not-unique-equalp
            (second x) (list 0 1 0 0 0))
           (empirical-mass
            (orthogonal-projection-not-unique-equalp
             (subseq
              dataset-proj
              (index-1st-sublist-item>=
               (- (first x) 12)
               ontimes-list)
              (+
               (index-item-1st-occurs
                (my-last
                 (orthogonal-projection-unique-equalp
                  (second x) (list 1 1 0 0 0)))
                dataset-proj) 1))
             (list 0 1))))
          (/ 1 (length (second x))))
         ))
    segments))
  (dataset2csv
   likelihood-curve3
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/likelihood-curve3-C-41-2.csv")))


#| The above version is the one I think we'll go with.
Below we try it out for a few more pieces. |#

(progn
  (setq
   dataset-all
   (read-from-file
    "/Users/tec69/Open/Music/Datasets/C-50-1-ed.txt"))
  "Yes!")
(progn
  (setq dataset (subseq dataset-all 0 179))
  (my-last dataset))
(progn
  (setq
   dataset-proj
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 0 0)))
  "Yes!")

(progn
  (setq
   segments
   (butlast 
    (segments-strict dataset 1 3)))
  (setq
   ontimes-list
   (mapcar
    #'(lambda (x)
        (first x))
    dataset-proj))
   "Yes!")

(progn
  (setq
   likelihood-curve
   (mapcar
    #'(lambda (x)
        (list
         (first x)
         (if (second x)
           (expt
            (likelihood-of-subset
             (orthogonal-projection-not-unique-equalp
              (second x) (list 0 1 0 0 0))
             (empirical-mass
              (orthogonal-projection-not-unique-equalp
               (subseq
                dataset-proj
                (index-1st-sublist-item>=
                 (- (first x) 12)
                 ontimes-list)
                (+
                 (index-item-1st-occurs
                  (my-last
                  (orthogonal-projection-unique-equalp
                    (second x) (list 1 1 0 0 0)))
                  dataset-proj) 1))
               (list 0 1))))
            (/ 1 (length (second x))))
           0)
         ))
    segments))
  (dataset2csv
   likelihood-curve
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/likelihood-curve-C-50-1.csv")))



(setq x (nth 24 segments))

(index-1st-sublist-item>= 11 ontimes-list)

(my-last (subseq dataset 0 184))
(my-last
 (butlast 
  (segments-strict (subseq dataset 0 184) 1 3)))

