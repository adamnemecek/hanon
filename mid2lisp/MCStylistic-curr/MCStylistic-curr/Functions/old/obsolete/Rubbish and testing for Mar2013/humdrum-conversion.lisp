;Demo.

;(in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "humdrum"
   :type "lisp")
  *MCStylistic-Mar2013-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "midi-save"
   :type "lisp")
  *MCStylistic-Mar2013-functions-path*))

(setq
 MIDI-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-63-1-ed.mid"))
(setq
 dataset-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-63-1-ed.txt"))
(progn
  (setq *scale* 1000)
  (setq *anacrusis* 0)
  (setq
   dataset
   (humdrum-file2dataset
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Humdrum files"
     "/C-63-1-ed.txt")))
  (saveit
   MIDI-destination
   (modify-to-check-dataset dataset *scale*))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (append
         (list (+ (first x) *anacrusis*))
         (rest x)))
    dataset)
   dataset-destination))

(setq
 MIDI-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-2-ed.mid"))
(setq
 dataset-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-2-ed.txt"))
(progn
  (setq *scale* 1000)
  (setq *anacrusis* -5/4)
  (setq
   dataset
   (humdrum-file2dataset
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Humdrum files"
     "/C-68-2-ed.txt")))
  (saveit
   MIDI-destination
   (modify-to-check-dataset dataset *scale*))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (append
         (list (+ (first x) *anacrusis*))
         (rest x)))
    dataset)
   dataset-destination))

(setq
 MIDI-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-3-ed.mid"))
(setq
 dataset-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-3-ed.txt"))
(progn
  (setq *scale* 1000)
  (setq *anacrusis* 0)
  (setq
   dataset
   (humdrum-file2dataset
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Humdrum files"
     "/C-68-3-ed.txt")))
  (saveit
   MIDI-destination
   (modify-to-check-dataset dataset *scale*))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (append
         (list (+ (first x) *anacrusis*))
         (rest x)))
    dataset)
   dataset-destination))

(setq
 MIDI-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-4-ed.mid"))
(setq
 dataset-destination
 (concatenate
  'string
  "/Users/tomcollins/Open/Music/Datasets"
  "/C-68-4-ed.txt"))
(progn
  (setq *scale* 1000)
  (setq *anacrusis* 0)
  (setq
   dataset
   (humdrum-file2dataset
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Humdrum files"
     "/C-68-4-ed.txt")))
  (saveit
   MIDI-destination
   (modify-to-check-dataset dataset *scale*))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (append
         (list (+ (first x) *anacrusis*))
         (rest x)))
    dataset)
   dataset-destination))


(progn
  (setq
   *humdrum*
   (read-from-file-arbitrary
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Humdrum files"
     "/C-6-1.txt")))
  (identity "Yes!"))

