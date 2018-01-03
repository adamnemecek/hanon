
(setq beats-in-bar 3)
(setq initial-MNN 60)
(setq initial-MPN 60)
(setq half-states
         (create-MIDI&morphetic-numbers
          states initial-MNN initial-MPN))
(setq j 0)
(setq n (length half-states))
(setq state-durs
         (state-durations-by-beat
          states beats-in-bar))
(setq unique-times
         (cons
          0 (fibonacci-list state-durs)))
(setq j (+ j 1))

(((1 (60 72 79 84 88) (60 67 71 74 76))
      (NIL NIL "C-63-1"
           ((0 35 45 1/2 1 1/2 0)
            (0 47 52 1/2 1 1/2 1)
            (0 54 56 1/2 0 1/2 2)
            (0 59 59 1/2 0 1/2 3)
            (0 63 61 1/2 0 1/2 4))))
     ((3/2 NIL NIL)
      (NIL NIL "C-63-1" NIL))
     ((7/4 (54) (57))
      (-6 -3 "C-63-1"
          ((831/4 56 57 1/4 0 208 701))))
     ((2 (28 40 54 60 63) (42 49 57 60 62))
      (-26 -15 "C-63-1"
           ((208 30 42 1 1 209 702)
            (208 42 49 1 1 209 703)
            (208 56 57 1 0 209 704)
            (208 62 60 1 0 209 705)
            (208 65 62 1 0 209 706))))
     ((3 (28 40 52 61 64) (42 49 56 61 63))
      (0 0 "C-63-1"
         ((209 30 42 1 1 210 707)
          (209 42 49 1 1 210 708)
          (209 54 56 1 0 210 709)
          (209 63 61 1 0 210 710)
          (209 66 63 1 0 210 711))))
     ((1 (28 40 56 62 66) (42 49 58 62 64))
      (0 0 "C-63-1"
         ((216 30 42 1 1 217 740)
          (216 42 49 1 1 217 741)
          (216 58 58 1 0 217 742)
          (216 64 62 1 0 217 743)
          (216 68 64 1 0 217 744))))
     ((2 (47 52 56 59) (53 56 58 60))
      (19 11 "C-63-1" 
          ((43 56 57 1 1 44 195) (43 61 60 1 1 44 196)
           (43 65 62 1/2 0 87/2 197)
           (43 68 64 1 1 44 198))))
     ((5/2 (47 52 56 64 68) (53 56 58 63 65))
      (0 0 "C-63-1"
         ((25 54 56 1 1 26 101) (25 59 59 1 1 26 102)
          (25 63 61 1 1 26 103)
          (51/2 71 66 1/2 0 26 105)
          (51/2 75 68 1/2 0 26 106))))
     ((3 (66 69) (64 66))
      (19 11 "C-63-1"
          ((230 73 67 3/4 0 923/4 809)
           (230 76 69 3/4 0 923/4 810))))
     ((7/2 (69 73) (66 68))
      (3 2 "C-67-1"
         ((41/2 72 67 1/2 0 21 94)
          (41/2 76 69 1/2 0 21 95)))))

(setq i 0)
(setq j 7)
(setq state-durs '(1/2 1/4 1/4 1 1 1 1/2 1/2 1/2 1/2))
(setq unique-times '(0 1/2 3/4 1 2 3 4 9/2 5 11/2 6))
(setq beats-in-bar 3)
(setq current-state (nth j half-states))
(setq note-ontime (nth j unique-times))
(setq MNN
         (nth i (second (first current-state))))
(setq MPN
         (nth i (third (first current-state))))
(setq index-in-previous-chord
         (if (and (> j 0) MNN)
           (position
            MNN
            (second
             (first (nth (- j 1) half-states))))))
(setq held-over
         (if index-in-previous-chord
           (>=
            (index-of-offtime-by-lookup
             (- j 1) MNN half-states state-durs) j)))
(setq offtime-state
         (if MNN
           (index-of-offtime-by-lookup
            j MNN half-states state-durs)))
(setq voice
         (if MNN
           (fifth
            (nth
             i (fourth (second current-state))))))

(setq previous-MIDI 60)
(setq previous-morphetic 60)
(setq MIDI-step-index 0)
(setq morphetic-step-index 1)
(setq MNNs
         (nth-list-of-lists
          1 (fourth (second (first states)))))
(setq MPNs
         (nth-list-of-lists
          2 (fourth (second (first states)))))
(setq MNN-trans
         (if MNNs (- previous-MIDI (first MNNs))))
(setq MPN-trans
         (if MPNs
           (- previous-morphetic (first MPNs))))
(setq bass-step-MIDI
	 (if (null
              (nth
               MIDI-step-index
               (second (first states))))
	   (identity 0)
	   (nth
            MIDI-step-index (second (first states)))))
(setq bass-step-morphetic
	 (if (null
              (nth
               morphetic-step-index
               (second (first states))))
	   (identity 0)
	   (nth
            morphetic-step-index
            (second (first states)))))
(setq MNNs
         (if MNNs
           (add-to-list
            (+ MNN-trans bass-step-MIDI) MNNs)))
(setq MPNs
         (if MPNs
           (add-to-list
            (+ MPN-trans bass-step-morphetic) MPNs)))
(setq states (rest states))
(setq
 previous-MIDI
 (if MNNs (first MNNs) (identity previous-MIDI)))
(setq 
 previous-morphetic
 (if MPNs
        (first MPNs) (identity previous-morphetic)))


(setq
 states
 '(((1 (12 7 5 4))
    (NIL "C-63-1"
         ((0 35 45 1/2 1 1/2 0)
          (0 47 52 1/2 1 1/2 1)
          (0 54 56 1/2 0 1/2 2)
          (0 59 59 1/2 0 1/2 3)
          (0 63 61 1/2 0 1/2 4))))
   ((2 (12 7 5 4))
    (0 "C-63-1"
       ((298 35 45 1 1 299 1045)
        (298 47 52 1 1 299 1046)
        (298 54 56 1 1 299 1047)
        (298 59 59 1 1 299 1048)
        (295 63 61 5 0 300 1036))))
   ((3 (12 7 5 4))
    (0 "C-63-2"
       ((119 32 44 1 1 120 409)
        (119 44 51 1 1 120 410) 
        (119 51 55 1 1 120 411)
        (119 56 58 1 1 120 412)
        (119 60 60 1 0 120 413))))
   ((1 (7 5 4 8))
    (12 "C-63-1"
        ((303 47 52 1 1 304 1056)
         (303 54 56 1 1 304 1057)
         (303 59 59 1 0 304 1058)
         (303 63 61 1 0 304 1059)
         (303 71 66 1 0 304 1060))))
   ((2 (7 5 4 8))
    (24 "C-63-1"
        ((304 71 66 1 1 305 1061)
         (304 78 70 1 1 305 1062)
         (304 83 73 1 0 305 1063)
         (304 87 75 1 0 305 1064)
         (304 95 80 1 0 305 1065))))
   ((5/2 (7 5))
    (0 "C-63-2"
       ((82 44 51 1 1 83 266)
        (82 51 55 1 1 83 267)
        (82 56 58 1 1 83 268))))
   ((11/4 (7 5 9 12))
    (0 "C-63-2"
       ((82 44 51 1 1 83 266)
        (82 51 55 1 1 83 267)
        (82 56 58 1 1 83 268)
        (331/4 65 63 1/4 0 83 271)
        (331/4 77 70 1/4 0 83 272))))
   ((3 (7 9 3 12))
    (0 "C-63-2"
       ((83 44 51 1 1 84 273)
        (83 51 55 1 1 84 274)
        (83 60 60 1 1 84 275)
        (83 63 62 1 0 84 276)
        (83 75 69 1 0 84 277))))))

(create-MIDI-note-numbers states 48 1 0)
(state-durations-by-beat states 3)


(setq starting-index 3)
(setq note-number 28)
(setq
 half-states
 '(((1 (60 72 79 84 88) (60 67 71 74 76))
      (NIL NIL "C-63-1"
           ((0 35 45 1/2 1 1/2 0)
            (0 47 52 1/2 1 1/2 1)
            (0 54 56 1/2 0 1/2 2)
            (0 59 59 1/2 0 1/2 3)
            (0 63 61 1/2 0 1/2 4))))
     ((3/2 NIL NIL)
      (NIL NIL "C-63-1" NIL))
     ((7/4 (54) (57))
      (-6 -3 "C-63-1"
          ((831/4 56 57 1/4 0 208 701))))
     ((2 (28 40 54 60 63) (42 49 57 60 62))
      (-26 -15 "C-63-1"
           ((208 30 42 2 1 209 702)
            (208 42 49 1 1 209 703)
            (208 56 57 1 0 209 704)
            (208 62 60 1 0 209 705)
            (208 65 62 1 0 209 706))))
     ((3 (28 40 52 61 64) (42 49 56 61 63))
      (0 0 "C-63-1"
         ((209 30 42 1 1 210 707)
          (209 42 49 1 1 210 708)
          (209 54 56 1 0 210 709)
          (209 63 61 1 0 210 710)
          (209 66 63 1 0 210 711))))))
(setq state-durations '(1/2 1/4 1/4 1))
(setq beats-in-bar 3)
(setq j starting-index)
(setq n (- (length half-states) 1))
(setq note-index
         (position
          note-number
          (second (first (nth j half-states)))))
(setq context-durations
         (nth-list-of-lists
          3 (fourth (second (nth j half-states)))))
(setq j (+ j 1))


(setq beats-in-bar 3)
(setq n (length states))
(setq inter-state-duration
         (if (> n 1)
           (-
            (first (first (second states)))
            (first (first (first states))))))
(setq mod-state-duration
         (if (and inter-state-duration
                  (<= inter-state-duration 0))
           (+
            beats-in-bar
            (mod
             inter-state-duration beats-in-bar))
           (identity inter-state-duration)))

(setq n (- n 1))
(setq states (rest states))

(index-of-offtime-by-lookup
 0 60
 '((((48 60 67 72 76) 2)
    (0 "C-63-1"
       ((298 35 45 1 1 299 1045)
        (298 47 52 2 1 299 1046)
        (298 54 56 1 1 299 1047)
        (298 59 59 1 1 299 1048)
        (295 63 61 5 0 300 1036))))
   (((48 60 67 72 76) 3)
    (0 "C-63-2"
       ((119 32 44 1 1 120 409)
        (119 44 51 1 1 120 410)
        (119 51 55 1 1 120 411)
        (119 56 58 1 1 120 412)
        (119 60 60 1 0 120 413))))
   (((60 67 72 76 84) 1)
    (12 "C-63-1"
        ((303 47 52 1 1 304 1056)
         (303 54 56 1 1 304 1057)
         (303 59 59 1 0 304 1058)
         (303 63 61 1 0 304 1059)
         (303 71 66 1 0 304 1060)))))
 3)

