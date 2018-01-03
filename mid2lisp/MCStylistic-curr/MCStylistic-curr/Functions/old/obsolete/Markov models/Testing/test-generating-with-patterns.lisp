
(in-package :common-lisp-user)
(setq
 *rs* #.(CCL::INITIALIZE-RANDOM-STATE 56302 14832))


(setq sort-index 1)
(setq duration-index 3)
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
         (my-last
          (beat-spacing-states
           context-datapoints-> "no information"
           beats-in-bar sort-index duration-index)))
(setq state-context-pair<-
         (first
          (beat-spacing-states<-
           context-datapoints<- "no information"
           beats-in-bar sort-index duration-index)))
(setq output
         (generate-beat-spacing-forced<->
          generation-interval terminal->p terminal<-p
          external-initial-states
          internal-initial-states stm->
          external-final-states internal-final-states
          stm<- rounded-template pattern-region
          state-context-pair-> state-context-pair<-
          checklist beats-in-bar c-failures c-sources
          c-bar c-min c-max c-beats c-prob c-forwards
          c-backwards sort-index duration-index))

