
(in-package :common-lisp-user)
(setq
 *rs* #.(CCL::INITIALIZE-RANDOM-STATE 27920 62338))
(setq sort-index 1)
(setq duration-index 3)
(setq interval-output-pairs nil)
(setq existing-intervals
      (nth-list-of-lists 0 interval-output-pairs))
(setq indexed-max-subset-score
         (indices-of-max-subset-score patterns-hash))
(setq pattern-region
         (if indexed-max-subset-score
           (translation
            (gethash
             '"region"
             (nth
              (first indexed-max-subset-score)
              patterns-hash))
            (nth
             (second indexed-max-subset-score)
             (gethash
              '"translators"
              (nth
               (first indexed-max-subset-score)
               patterns-hash))))))
(setq floor-ontime
         (floor
          (first
           (first
            (if pattern-region
              pattern-region dataset-template)))))
(setq ceiling-ontime
         (ceiling
          (first
           (my-last
            (if pattern-region
              pattern-region dataset-template)))))
(setq generation-intervals
         (generate-intervals
          floor-ontime ceiling-ontime
          existing-intervals))
(setq new-interval-output-pairs
         (if generation-intervals
           (generate-beat-spacing-for-intervals
            generation-intervals whole-piece-interval
            interval-output-pairs
            external-initial-states
            internal-initial-states stm->
            external-final-states
            internal-final-states stm<-
            dataset-template pattern-region checklist
            beats-in-bar c-failures c-sources c-bar
            c-min c-max c-beats c-prob c-forwards
            c-backwards sort-index duration-index)))
(gethash
 '"united,2,3,backwards-dominant"
 (third
  (second
   (second
    (nth 0 new-interval-output-pairs)))))

(setq new-translated-interval-output-pairs
         (if (and
              indexed-max-subset-score
              new-interval-output-pairs)
           (translate-to-other-occurrences
            new-interval-output-pairs
            interval-output-pairs
            indexed-max-subset-score patterns-hash
            existing-intervals)))

(gethash
 '"translated material"
 (third
  (second
   (second
    (nth 0 new-translated-interval-output-pairs)))))

(setq
 patterns-hash
 (progn
   (setf
    (gethash
     '"inheritance addressed"
     (nth
      (first indexed-max-subset-score)
      patterns-hash)) "Yes")
   patterns-hash))
(setq interval-output-pairs
      (if new-interval-output-pairs
       (merge-sort-by-vector<vector-car
        (append
         interval-output-pairs
         new-interval-output-pairs
         new-translated-interval-output-pairs))
       interval-output-pairs))

(gethash
 (first (second (nth 1 interval-output-pairs)))
 (third
  (second
   (second
    (nth 1 interval-output-pairs)))))

(setq
 interval-output-pairs
 (merge-sort-by-vector<vector-car
     (append
      interval-output-pairs
      new-interval-output-pairs)))

(setq
 generation-interval (first generation-intervals))
(setq left-side (first generation-interval))
(setq right-side (second generation-interval))
(setq trimmed-template
      (remove-datapoints-with-nth-item>
       (remove-datapoints-with-nth-item<
        dataset-template left-side 0)
       right-side 0))
(setq rounded-template
         (if (null pattern-region)
           (append
            (list
             (append
              (list
               (floor
                (first (first trimmed-template))))
              (rest (first trimmed-template))))
            (rest (butlast trimmed-template))
            (list
             (append
              (list
               (ceiling
                (first (my-last trimmed-template))))
              (rest (my-last trimmed-template)))))
           trimmed-template))
(setq generated-intervals
         (nth-list-of-lists 0 interval-output-pairs))
(setq generated-left-sides
         (nth-list-of-lists 0 generated-intervals))
(setq generated-right-sides
         (nth-list-of-lists 1 generated-intervals))
(setq terminal->p
         (equalp
          left-side (first whole-piece-interval)))
(setq terminal<-p
         (equalp
          right-side (second whole-piece-interval)))
(setq index-context->
         (position
          left-side generated-right-sides
          :test #'equalp))
(setq index-context<-
         (position
          right-side generated-left-sides
          :test #'equalp))
(setq context-most-plausible->
         (if index-context->
           (first
            (second
             (nth
              index-context->
              interval-output-pairs)))))
(setq context-most-plausible<-
         (if index-context<-
           (first
            (second
             (nth
              index-context<-
              interval-output-pairs)))))
(setq context-datapoints->
         (if context-most-plausible->
           (gethash
            context-most-plausible->
            (third
             (second
              (second
               (nth
                index-context->
                interval-output-pairs)))))))
(setq context-datapoints<-
         (if context-most-plausible<-
           (gethash
            context-most-plausible<-
            (third
             (second
              (second
               (nth
                index-context<-
                interval-output-pairs)))))))
(setq state-context-pair->
         (if context-datapoints->
           (list
            (first
             (my-last
              (beat-spacing-states
               context-datapoints-> "no information"
               beats-in-bar sort-index
               duration-index)))
            (list
             nil nil "no information"
             (fourth
            (second
             (my-last
              (beat-spacing-states
               context-datapoints-> "no information"
               beats-in-bar sort-index
               duration-index))))))))
(setq state-context-pair<-
         (if context-datapoints<-
           (list
            (first
             (first
              (beat-spacing-states<-
               context-datapoints<- "no information"
               beats-in-bar sort-index
               duration-index)))
            (list
             nil nil "no information"
             (fourth
              (second
               (first
                (beat-spacing-states<-
                 context-datapoints<- "no information"
                 beats-in-bar sort-index
                 duration-index))))))))

(setq template-segments
         (butlast
          (segments-strict rounded-template 1 3)))
(setq bisection
         (ceiling
          (/
           (+
            (second generation-interval)
            (first generation-interval)) 2)))
(setq forwards-candidates
      (make-hash-table :test #'equal))
(setq backwards-candidates
      (make-hash-table :test #'equal))
(setq united-candidates
      (make-hash-table :test #'equal))
(setq i 3)
(setf
       (gethash
        (concatenate
         'string "forwards," (write-to-string i))
        forwards-candidates)
       (if pattern-region
         (generate-forced<->no-failure
          "forwards" terminal->p
          external-initial-states
          internal-initial-states stm-> bisection
          rounded-template generation-interval
          pattern-region state-context-pair->
          checklist beats-in-bar c-failures c-sources
          c-bar c-min c-max c-beats c-prob
          template-segments)
         (generate-forwards-or-backwards-no-failure
          "forwards"
          (if terminal->p
            external-initial-states
            internal-initial-states)
          stm-> bisection rounded-template checklist
          beats-in-bar c-failures c-sources c-bar
          c-min c-max c-beats c-prob
          template-segments)))

(setq i 1)
(setf
       (gethash
        (concatenate
         'string "backwards," (write-to-string i))
        backwards-candidates)
       (if pattern-region
         (generate-forced<->no-failure
          "backwards" terminal<-p
          external-final-states internal-final-states
          stm<- bisection rounded-template
          generation-interval pattern-region
          state-context-pair<- checklist beats-in-bar
          c-failures c-sources c-bar c-min c-max
          c-beats c-prob template-segments)
         (generate-forwards-or-backwards-no-failure
          "backwards"
          (if terminal->p
            external-final-states
            internal-final-states)
          stm<- bisection dataset-template checklist
          beats-in-bar c-failures c-sources c-bar
          c-min c-max c-beats c-prob
          rounded-segments)))


(setq i 1)
(progn
  (setq final-states internal-final-states)
  (setq stm stm<-)
  (setq no-ontimes< bisection)
  (setq dataset-template rounded-template)
  (setq
   next-state-context-pair state-context-pair<-)
  "Yes!")
(setq template-likelihood-profile
      (geom-mean-likelihood-of-states<-
       template-segments rounded-template c-beats))
(setq final-MNN
         (if next-state-context-pair
           (second
            (first
             (fourth
              (second next-state-context-pair))))
           (if pattern-region
             (second
              (first
               (second
                (nth
                 (position
                  (first (my-last pattern-region))
                  (nth-list-of-lists
                   0 template-segments)
                  :test #'equalp)
                 template-segments)))) 60)))
(setq final-MPN
         (if next-state-context-pair
           (third
            (first
             (fourth
              (second next-state-context-pair))))
           (if pattern-region
             (third
              (first
               (second
                (nth
                 (position
                  (first (my-last pattern-region))
                  (nth-list-of-lists
                   0 template-segments)
                  :test #'equalp)
                 template-segments)))) 60)))
(setq i 1) (setq index-failures (list 0))
(setq states<-
         (list
          (if next-state-context-pair
            next-state-context-pair
            (choose-one-with-beat
             (+ (mod
                 (ceiling
                  (first (my-last pattern-region)))
                 beats-in-bar) 1)
             final-states))))
(setq datapoints
         ; 25/10/10 This could go wrong!
         (translate-datapoints-to-last-ontime
          (if next-state-context-pair
            (first
             (my-last
              (sort-dataset-asc
               (fourth
                (second
                 next-state-context-pair)))))
            (second generation-interval))
          0
          (sort-dataset-asc
           (states2datapoints-by-lookup<-
            (if next-state-context-pair
              states<-
              (append
               (list
                (list
                 (first (first states<-))
                 (list
                  nil nil
                  (third (second (first states<-)))
                  (fourth
                   (second (first states<-))))))
               (rest states<-)))
            beats-in-bar final-MNN final-MPN))))
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
(setq index-failures (append index-failures (list 0)))
(setq states<- (append states<- (list next-state)))










(setq
 previous-state-context-pair state-context-pair->)

(setq template-segments
         (butlast
          (segments-strict rounded-template 1 3)))
(setq template-likelihood-profile
      (geom-mean-likelihood-of-states
       template-segments rounded-template c-beats))
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
(setq states
         (list
          (if previous-state-context-pair
            previous-state-context-pair
            (choose-one-with-beat
             (+ (mod
                 (floor
                  (first (first pattern-region)))
                 beats-in-bar) 1)
             internal-initial-states))))
(setq datapoints
         (translate-datapoints-to-first-ontime
          (if previous-state-context-pair
            (first
             (first
              (sort-dataset-asc
               (fourth
                (second
                 previous-state-context-pair)))))
            (first generation-interval))
          0
          (sort-dataset-asc
           (states2datapoints-by-lookup
            (if previous-state-context-pair
              (append
               (butlast
                (beat-spacing-states
                 (fourth
                  (second
                   previous-state-context-pair))
                 "No information" 3 1 3))
               states)
              (append
               (list
                (list
                 (first (first states))
                 (list
                  nil nil
                  (third (second (first states)))
                  (fourth (second (first states))))))
               (rest states)))
            beats-in-bar initial-MNN initial-MPN))))

(progn
  (setq initial-states internal-initial-states)
  (setq dataset-template rounded-template)
  (setq stm stm->)
  "Yes!")

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
(setq index-failures
      (append index-failures (list 0)))
(setq
 states
 (append states (list next-state)))

