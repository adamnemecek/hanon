
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))

(progn
  (setq
   dataset
   (read-from-file
    (concatenate
     'string
     "/Users/tec69/Open/Music/Datasets"
     "/chorale-bwv-151-ed.txt")))
  "Yes!")

(progn
  (setq segments (segments-strict dataset 1 3))
  "Yes!")

(progn
  (setq a-list (HarmAn->labelling segments)) "Yes!")

#| Trying to work out why consecutive segments get the
same label, rather than labels being combined. |#

(setq
 segments
 '((3
    ((3 59 59 1 3 4 20) (3 62 61 1 2 4 21)
     (3 67 64 1 1 4 22) (3 74 68 1 0 4 23)))
   (4
    ((4 48 53 1 3 5 24) (4 60 60 1/2 2 9/2 25)
     (4 67 64 1 1 5 26) (4 76 69 1 0 5 27)))
   (9/2
    ((4 48 53 1 3 5 24) (9/2 59 59 1/2 2 5 28)
     (4 67 64 1 1 5 26) (4 76 69 1 0 5 27)))
   (5
    ((5 50 54 1 3 6 29) (5 57 58 1/2 2 11/2 30)
     (5 66 63 1 1 6 31) (5 74 68 1/2 0 11/2 32)))
   (11/2
    ((5 50 54 1 3 6 29) (11/2 62 61 1/2 2 6 33)
     (5 66 63 1 1 6 31) (11/2 72 67 1/2 0 6 34)))
   (6
    ((6 55 57 1 3 7 35) (6 62 61 1 2 7 36)
     (6 67 64 1 1 7 37) (6 71 66 1 0 7 38)))
   (7
    ((7 54 56 1 3 8 39) (7 62 61 1 2 8 40)
     (7 69 65 1 1 8 42) (7 69 65 1 0 8 41)))
   (8
    ((8 52 55 1 3 9 43) (8 55 57 1 2 9 44)
     (8 67 64 1 1 9 45) (8 71 66 1/2 0 17/2 46)))))

(setq listed-segs-max-argmax-pairs nil)

(setq current-segment-max-argmax
         (if segments
           (max-argmax-of-segment-scores
            (mod-list
             (nth-list-of-lists
              1 (second (first segments))) 12))))
(setq last-segments-max-argmax
         (if listed-segs-max-argmax-pairs
           (second
            (my-last listed-segs-max-argmax-pairs))
           (list 0)))
(setq combined-segments-max-argmax
         (if segments
           (max-argmax-of-segments-score
            (append
             (first
              (my-last listed-segs-max-argmax-pairs))
             (list (first segments)))) (list 0)))

(setq listed-segs-max-argmax-pairs
      (append
        listed-segs-max-argmax-pairs
        (list
         (list
          (list (first segments))
          current-segment-max-argmax))))
(setq segments (rest segments))




(progn
  (setq
   dataset
   (read-from-file
    (concatenate
     'string
     "/Users/tec69/Open/Music/Datasets"
     "/C-30-1-ed.txt")))
  "Yes!")


(HarmAn-> (subseq dataset 0 100))




(HarmAn->
 '((15 54 56 1 3) (15 62 61 1/2 2) (15 69 65 1 1)
   (15 74 68 1 0) (31/2 60 60 1/2 2) (16 55 57 1 3)
   (16 59 59 1 2) (16 67 64 1 1) (16 74 68 1 0)
   (17 57 58 1 3) (17 60 60 1 2) (17 66 63 1 1)
   (17 74 68 1 0) (18 59 59 1 3) (18 62 61 1 2)
   (18 67 64 1 1) (18 74 68 1 0) (19 52 55 1 3)
   (19 64 62 1 2) (19 67 64 1 1) (19 71 66 1/2 0)
   (39/2 72 67 1/2 0) (20 47 52 1 3) (20 62 61 1 2)
   (20 67 64 1 1) (20 74 68 1 0) (21 48 53 1 3)
   (21 64 62 1 2) (21 69 65 1/2 1) (21 72 67 1/2 0)
   (43/2 67 64 1/2 1) (43/2 71 66 1/2 0)
   (22 50 54 1 3) (22 57 58 1 2) (22 66 63 1 1)
   (22 69 65 1 0))
 1 3 *chord-templates-p&b&min7ths*)










