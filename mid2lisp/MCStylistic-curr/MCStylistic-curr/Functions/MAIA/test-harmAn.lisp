#| Copyright 2008-2013 Tom Collins
   Friday 8 February 2013
   Incomplete

\noindent The purpose of this script is to load an excerpt of
music and run my implementation of the HarmAn algorithm 
(Pardo and Birmingham, 2002) on it. |#

;(in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Harmony and metre")
   :name "chord-labelling"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "MAIA")
   :name "generate-chord-labelling"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "humdrum-by-col"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))

(setq
   *path&name*
   (merge-pathnames
    (make-pathname
     :directory
     '(:relative "beethovenOp2No1Mvt3" "polyphonic"))
    *music-data-root*))

(progn
  (setq
   dataset
   (humdrum-file2dataset-by-col
    (merge-pathnames
     (make-pathname
      :directory
      '(:relative "kern") :name "sonata01-3" :type "krn")
     *path&name*)))
  (setq
   dataset
   (mapcar #'(lambda (x) (add-to-nth -1 1 x)) dataset))
  (setq mini-d (subseq dataset 0 110))
  (setq
   chord-dataset
   (HarmAn-> mini-d 1 3 *chord-templates-p&b&min7ths*))
  (setq
   chord-tones
   (determine-chord-tones-train mini-d chord-dataset))
  "Yes!")


