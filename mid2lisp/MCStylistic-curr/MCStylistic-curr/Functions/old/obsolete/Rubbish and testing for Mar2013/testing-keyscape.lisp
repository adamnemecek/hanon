(setq
 dataset
 '((-1 61 60 1 0) (0 30 42 1 1) (0 66 63 3/2 0)
   (1 49 53 1 1) (1 57 58 1 1) (1 61 60 1 1)
   (3/2 68 64 1/2 0) (2 49 53 1 1) (2 57 58 1 1)
   (2 61 60 1 1) (2 69 65 1/2 0) (5/2 72 66 1/2 0)
   (3 42 49 1 1) (3 74 68 1/3 0) (10/3 76 69 1/3 0)
   (11/3 74 68 1/3 0) (4 57 58 1 1) (4 61 60 1 1)
   (4 66 63 1 1) (4 73 67 1 0) (5 57 58 1 1)
   (5 61 60 1 1) (5 66 63 1 1) (5 78 70 1 0)
   (6 54 56 1 1) (6 73 67 1/3 0) (19/3 74 68 1/3 0)
   (20/3 73 67 1/3 0) (7 59 59 1 1) (7 62 61 1 1)
   (7 66 63 1 1) (7 71 66 1 0) (8 59 59 1 1)
   (8 62 61 1 1) (8 66 63 1 1) (8 78 70 1 0)
   (9 42 49 1 1) (9 71 66 1/3 0) (28/3 73 67 1/3 0)
   (29/3 71 66 1/3 0) (10 57 58 1 1) (10 61 60 1 1)
   (10 66 63 1 1) (10 69 65 1 0) (11 49 53 1 1)
   (11 57 58 1 1) (11 61 60 1 1) (11 73 67 1 0)
   (12 37 46 1 1) (12 69 65 1/3 0) (37/3 71 66 1/3 0)
   (38/3 69 65 1/3 0) (13 49 53 1 1) (13 53 55 1 1)
   (13 59 59 1 1) (13 68 64 1 0) (14 49 53 1 1)
   (14 53 55 1 1) (14 59 59 1 1) (14 73 67 1 0)
   (15 42 49 1 1) (15 68 64 1/3 0) (46/3 69 65 1/3 0)
   (47/3 68 64 1/3 0) (16 49 53 1 1) (16 54 56 1 1)
   (16 57 58 1 1) (16 66 63 1 0) (17 51 54 1 1)
   (17 57 58 1 1) (17 73 67 1 0) (18 44 50 1 1)
   (18 66 63 1/3 0) (55/3 68 64 1/3 0)
   (56/3 66 63 1/3 0) (19 52 55 1 1) (19 56 57 1 1)
   (19 61 60 1 1) (19 64 62 1 0) (20 54 56 1 1)
   (20 56 57 1 1) (20 60 59 1 1) (20 63 61 1/2 0)
   (41/2 68 64 1/2 0) (21 37 46 1 1) (21 61 60 3/2 0)
   (22 49 53 1 1) (22 53 55 1 1) (22 59 59 1 1)
   (45/2 62 61 1/2 0) (45/2 71 66 1/2 0)
   (23 49 53 1 1) (23 56 57 1 1) (23 59 59 1 1)
   (23 61 60 1/2 0) (23 69 65 1/2 0)
   (47/2 65 62 1/2 0) (47/2 68 64 1/2 0)
   (24 42 49 1 1) (24 66 63 1 0)))


(setq key-profiles *Aarden-key-profiles*)
(setq window-length-min 4)
(setq window-length-increment 1)
(setq step-size 4)
(setq duration-index 3)
(setq offtime-index 5)
(setq dataset-with-offtimes
         (append-offtimes dataset duration-index))
(setq terminus
         (max-item
          (nth-list-of-lists
           offtime-index dataset-with-offtimes)))
(setq first-window-ontime
         (*
          (floor
           (/
            (first (first dataset))
            window-length-min)) window-length-min))
(setq growing-list nil)
(setq window-ontime first-window-ontime)
(setq window-length window-length-min)
(setq window-offtime
         (+ window-ontime window-length))
(setq relevant-datapoints
         (if (<= window-offtime terminus)
           (datapoints-sounding-between
            dataset-with-offtimes window-ontime
            window-offtime)))
(setq norm-key-correlations
         (if relevant-datapoints
           (normalised-key-correlations
            relevant-datapoints key-profiles)))

(setq
 growing-list
 (append
      growing-list
      (list
       (list
        window-ontime window-length
        relevant-datapoints norm-key-correlations
        (max-argmax
         (nth-list-of-lists
          1 norm-key-correlations))))))
(setq window-ontime (+ window-ontime step-size))



