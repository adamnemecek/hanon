#| Copyright 2008-2013 Tom Collins
   Saturday 9 February 2013

This function estimates the key of an input musical
point set, and convert MIDI note numbers to pitch (or
pitch class) relative to tonal center
\citep*{sapp2005,krumhansl1982,aarden2003}. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Harmony and metre")
   :name "keyscape"
   :type "lisp")
  *MCStylistic-Mar2013-functions-path*))

#|
\noindent Example:
\begin{verbatim}
(dataset2pcs-norm-tonic
 '((3 42 49 3 1) (3 74 68 1/3 0) (10/3 76 69 1/3 0)
   (11/3 74 68 1/3 0)))
--> (7 3 5 3)
\end{verbatim}

\noindent This function estimates the key of the input
dataset. It subtracts the tonic pitch class from each
input MIDI note number, and outputs the answer modulo
twelve. |#

(defun dataset2pcs-norm-tonic
       (dataset &optional (MNN-idx 1) (dur-index 3)
	(dataset-durs-appended
	 (mapcar
	  #'(lambda (x)
	      (append
	       x (list (nth dur-index x)))) dataset))
	(key-profiles *Aarden-key-profiles*)
	(key-corr
	 (key-correlations
	  dataset-durs-appended key-profiles))
	(tonic-pc
	 (mod
	  (second
	   (max-argmax
	    (nth-list-of-lists 1 key-corr))) 12)))
  (mapcar
   #'(lambda (x) (mod (- (nth MNN-idx x) tonic-pc) 12))
   dataset))




