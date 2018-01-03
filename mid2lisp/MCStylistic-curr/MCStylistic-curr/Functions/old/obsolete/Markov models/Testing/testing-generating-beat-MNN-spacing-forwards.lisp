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
  "/generating-beat-MNN-spacing-forwards.lisp"))

(defvar *rs* (make-random-state t))
(progn
  (setq
   initial-states
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Markov models"
     "/Chopin mazurka model (kern scores)"
     "/chopin-initial-states.txt")))
  (setq
   stm
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Markov models"
     "/Chopin mazurka model (kern scores)"
     "/chopin-transition-matrix.txt")))
  (setq no-ontimes> 12)
  (setq
   dataset-all
   (read-from-file
    "/Users/tec69/Open/Music/Datasets/C-41-2-ed.txt"))
  (setq
   dataset-template
   (subseq dataset-all 0 184))
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
(setq c-min 14)
(setq c-max 14)
(setq c-beats 12)
(setq c-prob 0.12)


(float
 (/
  (abs
   (- (get-internal-real-time)
      (progn
        (setq
         output
         (generate-beat-MNN-spacing->
          initial-states stm no-ontimes>
          dataset-template checklist
          beats-in-bar c-failures c-sources c-bar
          c-min c-max c-beats c-prob))
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
      0 0 0 0)) 1500)))









(progn
  (setq
   dataset-template
   (subseq dataset-all 184 250))
  (setq template-segments
         (segments-strict dataset-template 1 3))
  (setq template-likelihood-profile
        (geom-mean-likelihood-of-states
         template-segments dataset-template c-beats))
  "Yes!")
(setq initial-MNN
         (if template-segments
           (second
            (first
             (second (first template-segments))))
           60))
(setq initial-MPN
         (if template-segments
           (third
            (first
             (second (first template-segments))))
           60))
(setq i 1)
(setq index-failures (list 0))
(setq states
         (list
          (if template-segments
            (choose-one-with-beat
             (+ (first (first template-segments)) 1)
             initial-states)
            (choose-one initial-states))))
(setq datapoints
         (translate-datapoints-to-first-ontime
          (first (first template-segments)) 0
          (sort-dataset-asc
           (states2datapoints-by-lookup
            states beats-in-bar initial-MNN
            initial-MPN))))
(setq next-state
         (choose-one
          (second
           (assoc
            (first (my-last states)) stm
            :test #'equalp))))




(setq
 new-datapoints
 '((0 52 55 1 1) (0 59 59 1 1) (0 68 64 1 1)
   (0 76 69 1 0) (1 57 58 2 1) (1 64 62 1 1)
   (1 69 65 1 0) (1 73 67 1/2 0) (3/2 74 68 1/2 0)
   (2 67 64 1 0) (2 76 69 1/2 0) (5/2 71 66 1/2 0)
   (3 50 54 2 0) (3 69 65 1/2 0) (7/2 76 69 1/2 0)
   (4 57 58 1 1) (4 65 63 1 1) (4 74 68 1 0)
   (6 55 57 5 1) (6 62 61 2 1) (6 67 64 2 0)
   (6 71 66 1/2 0) (13/2 72 67 1/2 0)
   (7 71 66 1/2 0) (15/2 72 67 1/2 0) (8 65 63 2 0)
   (8 74 68 3/4 0) (35/4 69 65 1/4 0) (9 48 53 2 1)
   (9 67 64 1/2 0) (19/2 67 64 3 0) (10 65 63 1 0)
   (11 48 53 1 1) (11 55 57 1 1) (11 64 62 1 0)
   (12 48 53 1/2 1) (12 55 57 1/2 1)
   (12 72 67 1/2 0)))
(setq
 likelihood-profile
 (geom-mean-likelihood-of-states
  (segments-strict new-datapoints 1 3)
  new-datapoints c-beats))
(dataset2csv
   likelihood-profile
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Markov models"
    "/Testing/likelihood-profile-new.csv"))






(setq subset (second ontime-state-points-pair))
(setq subset-ontimes (nth-list-of-lists 0 subset))
(setq state-likelihood
         (if subset
           (geom-mean-likelihood-of-subset
            subset
            (orthogonal-projection-not-unique-equalp
             subset (list 0 1))
            (min-item subset-ontimes)
            (max-item subset-ontimes)
            (orthogonal-projection-not-unique-equalp
             datapoints (list 0 1))
            (nth-list-of-lists 0 datapoints)
            c-beats)))





(setq c-bar 4)
(setq c-min 3)
(setq c-max 3)
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






(progn
  (setq
   template-segments
   (segments-strict
    dataset-template 1 3))
  "Yes!")
(progn
  (setq template-likelihood-profile
        (geom-mean-likelihood-of-states
         template-segments dataset-template
         c-beats))
  "Yes!")
(setq initial-MNN
         (if template-segments
           (second
            (first
             (second (first template-segments))))
           60))
(setq initial-MPN
         (if template-segments
           (third
            (first
             (second (first template-segments))))
           60))
(setq i 1)
(setq index-failures (list 0))


(setq states
      (list
       (if template-segments
         (choose-one-with-beat
          (+ (first (first template-segments)) 1)
          initial-states)
         (choose-one initial-states))))
(setq datapoints
      (states2datapoints-by-lookup
       states beats-in-bar initial-MNN
       initial-MPN))
(setq next-state
         (choose-one
          (second
           (assoc
            (first (my-last states)) stm
            :test #'equalp))))
(setq checklistedp
         (checklistp
          states datapoints template-segments
          template-likelihood-profile checklist
          c-sources c-bar c-min c-max c-beats c-prob))
(setq failurep
         (index-1st-sublist-item>=
          c-failures index-failures))

(setq i (+ i 1))
(setq
 index-failures
 (if (< (length states)
                  (length index-failures))
             (identity index-failures)
             (append index-failures (list 0))))
(setq states (append states (list next-state)))

(setq
 index-failures
 (append
        (butlast index-failures)
        (list (+ (my-last index-failures) 1))))
(setq states (butlast states))
(setq
 datapoints
 (states2datapoints-by-lookup
  states beats-in-bar initial-MNN initial-MPN))
(setq
 next-state
 (choose-one
  (second
   (assoc
    (first (my-last states)) stm :test #'equalp))))
(setq checklistedp T)
(setq failurep NIL)

(setq i (+ i 1))
(setq
 index-failures
 (append
  (subseq index-failures 0 (- failurep 1))
  (list
   (+ (nth (- failurep 1) index-failures) 1))))
(setq
 states
 (if (equalp failurep 1)
   (list
    (if template-segments
      (choose-one-with-beat
       (+ (first (first template-segments)) 1)
       initial-states)
      (choose-one initial-states)))
   (subseq states 0 (- failurep 1))))

