
(defun generate-beat-spacing-forcing->
       (initial-states stm no-ontimes>
        dataset-template pattern-region
        previous-state-context-pair &optional
        (checklist (list "originalp"))
        (beats-in-bar 4)
        (c-failures 10) (c-sources 3)
        (c-bar 12) (c-min 7) (c-max 7) (c-beats 12)
        (c-prob 0.1)
        (template-segments
         (butlast
          (segments-strict dataset-template 1 3)))
        (template-likelihood-profile
         (geom-mean-likelihood-of-states
          template-segments dataset-template c-beats))
        (initial-MNN
         (if previous-state-context-pair
           (second
            (first
             (fourth
              (second previous-state-context-pair))))
           (if pattern-region
             (second (first pattern-region)) 60)))
        (initial-MPN
         (if previous-state-context-pair
           (third
            (first
             (fourth
              (second previous-state-context-pair))))
           (if pattern-region
             (third (first pattern-region)) 60)))
        (i 1) (index-failures (list 0))
        (states
         (list
          (if previous-state-context-pair
            previous-state-context-pair
            (choose-one-with-beat
             (+ (mod
                 (floor
                  (first (first pattern-region)))
                 beats-in-bar) 1)
             initial-states))))
        (datapoints
         (if previous-state-context-pair
           (sort-dataset-asc
            (fourth
             (second
              previous-state-context-pair)))
           (translate-datapoints-to-first-ontime
            (floor (first (first pattern-region)))
            0
            (sort-dataset-asc
             (states2datapoints-by-lookup
              states beats-in-bar initial-MNN
              initial-MPN)))))
        (next-state
         (choose-one
          (second
           (assoc
            (first (my-last states)) stm
            :test #'equalp))))
        (checklistedp
         (checklistp
          states datapoints template-segments
          template-likelihood-profile checklist
          c-sources c-bar c-min c-max c-beats c-prob))
        (failurep
         (index-1st-sublist-item>=
          c-failures index-failures)))
  (progn
    #| 29/9/2010 For testing purposes.
    (write-to-file-append
     (list datapoints)
     (concatenate
      'string
      "/Applications/CCL/Lisp code/Markov models"
      "/Testing/datapoints.txt"))
    (write-to-file-append
     (list states)
     (concatenate
      'string
      "/Applications/CCL/Lisp code/Markov models"
      "/Testing/states.txt"))
    (write-to-file-append
     (list next-state)
     (concatenate
      'string
      "/Applications/CCL/Lisp code/Markov models"
      "/Testing/next-state.txt"))
    (write-to-file-append
     (list index-failures)
     (concatenate
      'string
      "/Applications/CCL/Lisp code/Markov models"
      "/Testing/index-failures.txt"))
    |#
    (if failurep
      (if (zerop failurep)
        (list
         "Failure!" states datapoints i
         index-failures)
        (generate-beat-spacing-forcing->
         initial-states stm no-ontimes>
         dataset-template pattern-region
         previous-state-context-pair checklist
         beats-in-bar c-failures c-sources c-bar c-min
         c-max c-beats c-prob template-segments
         template-likelihood-profile initial-MNN
         initial-MPN (+ i 1)
         (append
          (subseq index-failures 0 (- failurep 1))
          (list
           (+ (nth (- failurep 1) index-failures) 1)))
         ; 29/9/2010 Special case to avoid null states
         (if (equalp failurep 1)
           (list
            (if previous-state-context-pair
              previous-state-context-pair
              (choose-one-with-beat
               (+ (mod
                   (floor
                    (first (first pattern-region)))
                   beats-in-bar) 1)
               initial-states)))
           (subseq states 0 (- failurep 1)))))
      (if checklistedp
        (if (>= (first (my-last datapoints))
                no-ontimes>)
          (list states datapoints i index-failures)
          (if next-state
            (generate-beat-spacing-forcing->
             initial-states stm no-ontimes>
             dataset-template pattern-region
             previous-state-context-pair checklist
             beats-in-bar c-failures c-sources c-bar
             c-min c-max c-beats c-prob
             template-segments
             template-likelihood-profile initial-MNN
             initial-MPN (+ i 1)
             (if (< (length states)
                    (length index-failures))
               (identity index-failures)
               (append index-failures (list 0)))
             (append states (list next-state)))
            (generate-beat-spacing-forcing->
             initial-states stm no-ontimes>
             dataset-template pattern-region
             previous-state-context-pair checklist
             beats-in-bar c-failures c-sources c-bar
             c-min c-max c-beats c-prob
             template-segments
             template-likelihood-profile initial-MNN
             initial-MPN (+ i 1)
             (append
              (butlast index-failures)
              (list (+ (my-last index-failures) 1)))
             states datapoints)))
        (generate-beat-spacing-forcing->
         initial-states stm no-ontimes>
         dataset-template pattern-region
         previous-state-context-pair checklist
         beats-in-bar c-failures c-sources c-bar c-min
         c-max c-beats c-prob template-segments
         template-likelihood-profile initial-MNN
         initial-MPN i ;Only instance not incremented
         (append
          (butlast index-failures)
          (list (+ (my-last index-failures) 1)))
         (if (equalp (length index-failures) 1)
           (list
            (if previous-state-context-pair
              previous-state-context-pair
              (choose-one-with-beat
               (+ (mod
                   (floor
                    (first (first pattern-region)))
                   beats-in-bar) 1)
               initial-states)))
           (butlast states)))))))



(setq checklist (list "originalp"))
(setq beats-in-bar 4)
(setq c-failures 10) (setq c-sources 3)
(setq c-bar 12) (setq c-min 7) (setq c-max 7)
(setq c-beats 12) (setq c-prob 0.1)

(progn
  (setq template-segments
        (butlast
         (segments-strict dataset-template 1 3)))
  (setq template-likelihood-profile
        (geom-mean-likelihood-of-states
         template-segments dataset-template c-beats))
  "Yes!")

(setq initial-MNN
         (if previous-state-context-pair
           (second
            (first
             (fourth
              (second previous-state-context-pair))))
           (if pattern-region
             (second (first pattern-region)) 60)))
(setq initial-MPN
         (if previous-state-context-pair
           (third
            (first
             (fourth
              (second previous-state-context-pair))))
           (if pattern-region
             (third (first pattern-region)) 60)))
(setq i 1) (setq index-failures (list 0))

(setq *rs* #.(CCL::INITIALIZE-RANDOM-STATE 1168 24228))

(setq states
         (list
          (if previous-state-context-pair
            previous-state-context-pair
            (choose-one-with-beat
             (+ (mod
                 (floor
                  (first (first pattern-region)))
                 beats-in-bar) 1)
             initial-states))))
(setq datapoints
         (translate-datapoints-to-first-ontime
          (if previous-state-context-pair
            (first
             (first
              (sort-dataset-asc
               (fourth
                (second
                 previous-state-context-pair)))))
            (floor (first (first pattern-region))))
          0
          (states2datapoints-by-lookup
           (if previous-state-context-pair
             (append
              (butlast
               (beat-spacing-states
                (fourth
                 (second previous-state-context-pair))
                "No information" 3 1 3))
              states) states)
           beats-in-bar initial-MNN initial-MPN)))
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
(setq states
      (append states (list next-state)))

