#| Tom Collins
   Tuesday 28 September 2010
   Incomplete

\noindent The idea is to take a look at some examples
of the key function in the file testing-generating-
beat-MNN-spacing-forwards.lisp. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Markov models"
  "/generating-beat-MNN-spacing-backwards.lisp"))

(defvar *rs* (make-random-state t))
(progn
  (setq
   final-states
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Markov models"
     "/Chopin mazurka model (kern scores)"
     "/chopin-final-states.txt")))
  (setq
   stm<-
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Markov models"
     "/Chopin mazurka model (kern scores)"
     "/chopin-transition-matrix<-.txt")))
  (setq no-ontimes< 24)
  (setq
   dataset-all
   (read-from-file
    "/Users/tec69/Open/Music/Datasets/C-67-3-ed.txt"))
  (setq
   dataset-template
   (subseq dataset-all 0 142))
  "Yes!")
(setq
 checklist
 (list "originalp" "mean&rangep" "likelihoodp"))
(setq checklist (list "originalp" "mean&rangep"))
(setq checklist (list "originalp"))
(setq beats-in-bar 3)
(setq initial-MNN 60)
(setq initial-MPN 60)
(setq c-failures 10)
(setq c-sources 3)
(setq c-bar 19)
(setq c-min 13)
(setq c-max 13)
(setq c-beats 12)
(setq c-prob 0.14)


(float
 (/
  (abs
   (- (get-internal-real-time)
      (progn
        (setq
         output
         (generate-beat-MNN-spacing<-
          final-states stm<- no-ontimes<
          dataset-template checklist beats-in-bar
          c-failures c-sources c-bar c-min c-max
          c-beats c-prob))
        (get-internal-real-time))))
  internal-time-units-per-second))
(fourth output)
(if (listp (first output))
  (saveit
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/test.mid")
   (modify-to-check-dataset
    (translation
     (second output)
     (list
      (- 0 (first (first (second output))))
      0 0 0 0))
     1500)))


(progn
  (setq template-segments
        (butlast
         (segments-strict dataset-template 1 3)))
  "Yes!")
(progn
  (setq template-likelihood-profile
        (geom-mean-likelihood-of-states<-
         template-segments dataset-template c-beats))
  "Yes!")
(dataset2csv
 template-likelihood-profile
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Markov models"
  "/Testing/like-back-56-3.csv"))

(setq final-MNN
         (if template-segments
           (second
            (first
             (second (my-last template-segments))))
           60))
(setq final-MPN
         (if template-segments
           (third
            (first
             (second (my-last template-segments))))
           60))
(setq i 1)
(setq index-failures (list 0))
(setq states<-
         (list
          (if template-segments
            (choose-one-with-beat
             (+
              (mod
               (first (my-last template-segments))
               beats-in-bar) 1)
             internal-final-states)
            (choose-one internal-final-states))))
(setq datapoints
         (translate-datapoints-to-last-ontime
          (first (my-last template-segments)) 0
          (states2datapoints-by-lookup<-
           states<- beats-in-bar final-MNN
           final-MPN)))
(setq next-state
         (choose-one
          (second
           (assoc
            (first (my-last states<-)) stm<-
            :test #'equalp))))
(setq checklistedp
      (checklist<-p
       states<- datapoints template-segments
       template-likelihood-profile checklist
       c-sources c-bar c-min c-max c-beats c-prob))
(setq failurep
         (index-1st-sublist-item>=
          c-failures index-failures))
(setq i (+ i 1))
(setq index-failures
      (if (< (length states<-)
             (length index-failures))
        (identity index-failures)
        (append index-failures (list 0))))
(setq
 states<- (append states<- (list next-state)))

(setq
 index-failures
 (append
          (butlast index-failures)
          (list (+ (my-last index-failures) 1))))
(setq
 states<-
 (if (equalp (length index-failures) 1)
           (list
            (if template-segments
              (choose-one-with-beat
               (+ (first (first template-segments)) 1)
               final-states)
              (choose-one final-states)))
           (butlast states<-)))







(setq lastn-sources
         (mapcar
          #'(lambda (x)
              (third (second x)))
          (lastn c-sources states<-)))
(setq datapoints-segments
         (if (or
              (find
               "mean&rangep" checklist
               :test #'string=)
              (find
               "likelihoodp" checklist
               :test #'string=))
           (segments-strict datapoints 1 3)))
(setq first-segment
         (first datapoints-segments))
(setq datapoints-segment first-segment)
(setq template-segment
         (full-segment-nearest<ontime
          (first datapoints-segment)
          template-segments))
(setq MNNs1
         (if template-segment
           (nth-list-of-lists
            1 (second template-segment))))
(setq MNNs2
         (if template-segment
           (nth-list-of-lists
            1 (second datapoints-segment))))
(setq ontime-state-points-pair first-segment)
(setq subset (second ontime-state-points-pair))
(setq subset-ontimes (nth-list-of-lists 0 subset))
(setq state-likelihood
         (if subset
           (geom-mean-likelihood-of-subset<-
            subset
            (orthogonal-projection-not-unique-equalp
             subset (list 0 1))
            (min-item subset-ontimes)
            (max-item subset-ontimes)
            (orthogonal-projection-not-unique-equalp
             datapoints (list 0 1))
            (nth-list-of-lists 0 datapoints)
            c-beats)))
