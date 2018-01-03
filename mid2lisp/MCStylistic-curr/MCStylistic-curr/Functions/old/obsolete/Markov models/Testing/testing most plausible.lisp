
(setq hash-table-of-datasets (third output))
(setq join-at 23)
(progn
  (setq template-dataset dataset-template)
  (setq stm stm->)
  (setq duration-index 3)
  (setq beats-in-bar 3)
  (setq sort-index 1)
  (setq c-beats 12)
  "Yes!")
(setq dataset-keys
      (disp-ht-key hash-table-of-datasets))
(setq revised-keys
         (keys-of-states-in-transition-matrix
          hash-table-of-datasets dataset-keys
          join-at stm "beat-spacing-states"
          duration-index beats-in-bar sort-index))
(min-max-abs-diffs-for-likelihood-profiles
   hash-table-of-datasets revised-keys
   template-dataset c-beats)

(setq ontime 23)

