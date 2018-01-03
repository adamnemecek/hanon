

(setq
 ontime-state-points-pairs
 '((-1 ((-1 55 57 1 1 0 0)))
   (0 ((0 67 64 10 0 10 1)))
   (1 ((1 65 63 1/2 1 3/2 2) (0 67 64 10 0 10 1)))
   (3/2 ((3/2 63 62 1/2 1 2 3) (0 67 64 10 0 10 1)
         (3/2 72 67 1/2 0 2 4)))
   (2 ((2 62 61 1/2 1 5/2 5) (0 67 64 10 0 10 1)
       (2 71 66 1/2 0 5/2 6) (2 74 68 1/2 0 5/2 7)))
   (5/2 ((5/2 60 60 1/2 1 3 8) (0 67 64 10 0 10 1)
         (5/2 72 67 1/2 0 3 9)
         (5/2 75 69 1/2 0 3 10)))
   (3 ((3 62 61 3/4 1 15/4 11) (0 67 64 10 0 10 1)
       (3 71 66 1 0 4 12) (3 77 70 3/4 0 15/4 13)))
   (15/4 ((15/4 55 57 1/4 1 4 14) (0 67 64 10 0 10 1)
          (3 71 66 1 0 4 12) (15/4 79 71 1/4 0 4 15)))
   (4 ((4 62 61 1 1 5 16) (0 67 64 10 0 10 1)
       (4 71 66 1 0 5 17) (4 77 70 1 0 5 18)))
   (5 ((5 60 60 1 1 6 19) (0 67 64 10 0 10 1)
       (5 72 67 1 0 6 20) (5 75 69 1 0 6 21)))
   (6 ((6 62 61 3/4 1 27/4 22) (0 67 64 10 0 10 1)
       (6 71 66 1 0 7 23) (6 77 70 3/4 0 27/4 24)))
   (27/4 ((27/4 55 57 1/4 1 7 25) (0 67 64 10 0 10 1)
          (6 71 66 1 0 7 23) (27/4 79 71 1/4 0 7 26)))
   (7 ((7 62 61 1 1 8 27) (0 67 64 10 0 10 1)
       (7 71 66 1 0 8 28) (7 77 70 1 0 8 29)))
   (8 ((8 60 60 1 1 9 30) (0 67 64 10 0 10 1)
       (8 72 67 1 0 9 31) (8 75 69 1 0 9 32)))
   (9 ((0 67 64 10 0 10 1)))))
(setq dataset dataset-template)
(setq dataset-palette
         (orthogonal-projection-not-unique-equalp
          dataset (list 0 1)))
(setq ontimes-list
         (nth-list-of-lists 0 dataset))
(setq subset
         (second
          (first ontime-state-points-pairs)))
(setq subset-palette
         (orthogonal-projection-not-unique-equalp
          subset (list 0 1)))
(setq subset-ontimes
         (nth-list-of-lists 0 subset))
(setq first-subset-ontime
         (if subset-ontimes
           (min-item subset-ontimes)))
(setq last-subset-ontime
         (if subset-ontimes
           (max-item subset-ontimes)))

(setq ontime-state-points-pairs
      (rest ontime-state-points-pairs))

(progn
  (setq
   dataset-all2
   (read-from-file
    "/Users/tec69/Open/Music/Datasets/C-30-2-ed.txt"))
  (setq
   dataset-template2
   (subseq dataset-all2 0 120))
  "Yes!")

(setq
 dataset-template
 '((27 39 48 1 1) (27 63 62 1/2 0) (111/4 72 67 1/4 0)
   (28 51 55 1 1) (28 60 60 1 1) (28 68 65 1 1)
   (28 84 74 1 0) (29 82 73 1/3 0) (88/3 80 72 1/3 0)
   (89/3 77 70 1/3 0) (30 39 48 1 1) (30 79 71 1/2 0)
   (61/2 77 70 1/2 0) (31 51 55 1 1) (31 55 57 1 1)
   (31 61 61 1 1) (31 75 69 1/2 0) (63/2 73 68 1/2 0)
   (32 51 55 1 1) (32 55 57 1 1) (32 61 61 1 1)
   (32 70 66 1/2 0) (65/2 65 63 1/2 0) (33 44 51 2 1)
   (33 63 62 1/2 0) (135/4 72 67 1/4 0) (34 51 55 1 1)
   (34 60 60 1 1) (34 68 65 1 0)))
(setq
 template-segments
 '((27
    ((27 39 48 1 1 28 91) (27 63 62 1/2 0 55/2 92)))
   (55/2 ((27 39 48 1 1 28 91)))
   (111/4
    ((27 39 48 1 1 28 91) (111/4 72 67 1/4 0 28 93)))
   (28
    ((28 51 55 1 1 29 94) (28 60 60 1 1 29 95)
     (28 68 65 1 1 29 96) (28 84 74 1 0 29 97)))
   (29 ((29 82 73 1/3 0 88/3 98)))
   (88/3 ((88/3 80 72 1/3 0 89/3 99)))
   (89/3 ((89/3 77 70 1/3 0 30 100)))
   (30
    ((30 39 48 1 1 31 101) (30 79 71 1/2 0 61/2 102)))
   (61/2
    ((30 39 48 1 1 31 101) (61/2 77 70 1/2 0 31 103)))
   (31
    ((31 51 55 1 1 32 104) (31 55 57 1 1 32 105)
     (31 61 61 1 1 32 106) (31 75 69 1/2 0 63/2 107)))
   (63/2
    ((31 51 55 1 1 32 104) (31 55 57 1 1 32 105)
     (31 61 61 1 1 32 106) (63/2 73 68 1/2 0 32 108)))
   (32
    ((32 51 55 1 1 33 109) (32 55 57 1 1 33 110)
     (32 61 61 1 1 33 111) (32 70 66 1/2 0 65/2 112)))
   (65/2
    ((32 51 55 1 1 33 109) (32 55 57 1 1 33 110)
     (32 61 61 1 1 33 111) (65/2 65 63 1/2 0 33 113)))
   (33
    ((33 44 51 2 1 35 114) (33 63 62 1/2 0 67/2 115)))
   (67/2 ((33 44 51 2 1 35 114)))
   (135/4
    ((33 44 51 2 1 35 114)
     (135/4 72 67 1/4 0 34 116)))
   (34
    ((33 44 51 2 1 35 114) (34 51 55 1 1 35 117)
     (34 60 60 1 1 35 118) (34 68 65 1 0 35 119)))))

(setq checklist (list "originalp"))
(setq beats-in-bar 3)
(setq c-failures 10)
(setq c-sources 3)
(setq c-bar 12)
(setq c-min 7)
(setq c-max 7)
(setq c-beats 12)
(setq c-prob 0.1)


(setq template-segments
         (butlast
          (segments-strict
           dataset-template 1 3)))
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
             final-states)
            (choose-one final-states))))
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
            (first (first states<-)) stm<-
            :test #'equalp))))


