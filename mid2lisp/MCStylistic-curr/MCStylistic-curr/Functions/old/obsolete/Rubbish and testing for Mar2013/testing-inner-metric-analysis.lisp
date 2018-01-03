



(setq
 vector-MTP-pair
 '((2) (0) (6) (7) (8) (9) (11) (14) (16) (22) (24)))

(setq
 vector-MTP-pair '((9) (0) (1) (8) (9) (16) (17)))

(setq
 vector-MTP-pair
 '((8) (0) (1) (2) (6) (8) (9) (10) (14) (16) (17)
   (18) (22)))

(setq min-length 2)
(setq period-vector-d (car vector-MTP-pair))
(setq MTP (cdr vector-MTP-pair))
(setq growing-list nil)
(setq i 1)
(setq k 1)
(setq first-member-s (first MTP))
(setq probe
         (if first-member-s
           (add-two-lists
            first-member-s period-vector-d)))
(setq candidate-member (nth i MTP))

(setq MTP (rest MTP))

(setq
 MTP (remove candidate-member MTP :test #'equalp))
(setq k (+ k 1))
(setq probe (add-two-lists probe period-vector-d))

(setq MTP (rest MTP))
(setq 
 growing-list
 (append
         growing-list
         (list
          (list
           period-vector-d first-member-s k
           (mapcar
            #'(lambda (x y) (mod x y))
            first-member-s period-vector-d)))))

(setq i (+ i 1))



(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/director-musices.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/midi-save.lisp"))

(progn
  (setq
   dataset
   (read-from-file
    (concatenate
     'string
     "/Users/tec69/Open/Music/Datasets"
     "/Schubert-op94-no4.txt")))
  "Yes!")

(mapcar
 #'(lambda (x)
     (MIDI-morphetic-pair2pitch&octave
      (list (second x) (third x))))
 dataset)

(saveit
 (concatenate
  'string
  "/Users/tec69/Open/Music/Datasets"
  "/Schubert-op94-no4.mid")
 (modify-to-check-dataset dataset 500))

