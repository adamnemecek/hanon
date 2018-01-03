
(in-package :common-lisp-user)

(setq template-segments
         (butlast
          (segments-strict dataset-template 1 3)))
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
(setq i 1)
(setq i 2)
(setq i 3)

(progn
  (setq final-states internal-final-states)
  (setq no-ontimes< bisection)
  (setq next-state-context-pair nil)
  (setq
   template-likelihood-profile
   (geom-mean-likelihood-of-states<-
    template-segments dataset-template c-beats))
  "Yes!")
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
          (ceiling (first (my-last pattern-region)))
          0
          (sort-dataset-asc
           (states2datapoints-by-lookup<-
            states<-
            beats-in-bar final-MNN final-MPN))))