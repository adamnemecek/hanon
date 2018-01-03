;Demo.

;(in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "csv-files"
   :type "lisp")
  *MCStylistic-Mar2013-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "humdrum-by-col"
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
 *path&name*
 (concatenate
  'string *music-data-root*
  "/beethovenOp2No1Mvt2"))

(setq
 csv-destination
 (concatenate
  'string *path&name* "/CSV datasets/sonata01-2.csv"))
(setq
 MIDI-destination
 (concatenate
  'string *path&name* "/MIDI/sonata01-2.mid"))
(setq
 dataset-destination
 (concatenate
  'string *path&name* "/Datasets/sonata01-2.txt"))
(progn
  (setq *scale* 2000)
  (setq *anacrusis* -1)
  (setq
   dataset
   (humdrum-file2dataset-by-col
    (concatenate
     'string *path&name* "/Humdrum/sonata01-2.krn")))
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
   dataset-destination)
  (dataset2csv
   dataset-destination csv-destination))





