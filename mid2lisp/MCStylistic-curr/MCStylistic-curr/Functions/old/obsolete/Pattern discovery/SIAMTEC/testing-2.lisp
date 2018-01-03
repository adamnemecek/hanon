

(setq dataset '((0 60) (4 65) (8 70)))

(setq path&name (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1) prep"))

(setq partition-size 20)

(setq filename-counter 1)
(setq growing-list nil)
(setq j 0)
(setq first-dataset (first dataset))
(setq rest-dataset (rest dataset))
(setq probe
	 (if (null rest-dataset) ()
	   (subtract-two-lists
	    (first rest-dataset) (first dataset))))
(setq result-recent
	 (assoc probe growing-list :test #'equalp))
(setq result
	 (if (and (> filename-counter 1)
		  (null result-recent))
	   (assoc-files
	    probe path&name (- filename-counter 1))
	   (identity result-recent)))

(setq growing-list
      (append
	      growing-list
	      (list
	       (cons probe
		     (list first-dataset)))))
(setq j (+ j 1))
(setq rest-dataset (rest rest-dataset))

(setq dataset (rest dataset))

(setq growing-list (append
	    (remove result-recent
		    growing-list :test #'equalp)
	    (list
	     (cons
	      (first result-recent)
	      (append (cdr result-recent)
		      (list first-dataset))))))

