
(setq hash-table-of-datasets A)
(setq dataset-keys
         (disp-ht-key hash-table-of-datasets))
(setq join-at 3/4)
(setq duration-index 3)
(setq beats-in-bar 3)
(setq sort-index 1)
(setq c-beats 12)
(setq revised-keys
         (keys-of-states-in-transition-matrix
          hash-table-of-datasets dataset-keys
          join-at stm "beat-spacing-states"
          duration-index beats-in-bar sort-index))


(setq hash-table-of-datasets A)
(setq template-segments
         (if dataset-keys
           (segments-strict template-dataset 1 3)))
(setq template-likelihood-profile
         (if template-segments
           (geom-mean-likelihood-of-states
            template-segments template-dataset
            c-beats)))
(setq result nil)
(setq candidate-dataset
         (if dataset-keys
           (gethash
            (first dataset-keys)
            hash-table-of-datasets)))
(setq candidate-segments
         (if candidate-dataset
           (segments-strict candidate-dataset 1 3)))
(setq candidate-likelihood-profile
         (if candidate-segments
           (geom-mean-likelihood-of-states
            candidate-segments candidate-dataset
            c-beats)))
(setq max-abs-diff
         (if (and
              candidate-likelihood-profile
              template-likelihood-profile)
           (max-item
            (abs-differences-for-curves-at-points
             candidate-likelihood-profile
             template-likelihood-profile))))
(setq result
      (append
        result
        (list
         (list (first dataset-keys) max-abs-diff))))
(setq dataset-keys (rest dataset-keys))


(setq state-fn "beat-spacing-states")
(setq duration-index 3)
(setq beats-in-bar 3)
(setq sort-index 1)
(setq hash-table-of-datasets A)
(setq dataset
         (if dataset-keys
           (gethash
            (first dataset-keys)
            hash-table-of-datasets)))














