
#| To probelm solve for a large dataset. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIA+"
  "/further-structural-inference-algorithms.lisp"))

#| Step 1 - Create datasets. |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 10.lisp"))
(progn
  (setq full-dataset dataset)
  (setq
   dataset
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (identity "Yes!"))
; size of full dataset is 872.

#| Step 2 - Replicate some of COSIATEC. |#
(setq
 prefix
 (concatenate
  'string
  "//Applications/CCL/Lisp code"
  "/Pattern discovery/SIA+/Write to files/L 10 test"
  "/L 10 (1 1 0 1 0)"))
(setq counter 2)
(setq growing-list nil)
(setq SIA-path&name
      (concatenate
       'string
       prefix " SIA " (write-to-string counter)
       ".txt"))
(setq SIATEC-path&name
      (concatenate
       'string
       prefix " SIATEC " (write-to-string counter)
       ".txt"))
; Manual
(progn
  (setq
   SIATEC-output
   (read-from-file
    (concatenate
     'string
     prefix " SIATEC 1.txt")))
  (length SIATEC-output))

#| Step 3 - The failure can be replicated as
follows. It is due to use of nth-list-of-lists. |#
(setq pattern&translators
      (if SIATEC-output
        (nth
         (argmax-of-threeCs
          (threeCs-pattern-translators-pairs
           SIATEC-output dataset))
         SIATEC-output)))

#| Step 4 - So now go hunting for a fix. |#
(progn
  (setq threeCs-list-of-lists
        (threeCs-pattern-translators-pairs
           SIATEC-output dataset))
  (identity "Yes!"))

; What about using mapcar?
(mapcar
 #'(lambda (x) (nth 0 x)) threeCs-list-of-lists)

#| Step 5 - Now try failure step (step 3) again with
argmax-of-threeCs redefined using mapcar. |#
(setq pattern&translators
      (if SIATEC-output
        (nth
         (argmax-of-threeCs
          (threeCs-pattern-translators-pairs
           SIATEC-output dataset))
         SIATEC-output)))
#| It gets past previous issue. Now there's a
problem with truncate. |#

(progn
  (setq
   threeCs-1
   (mapcar
    #'(lambda (x) (nth 1 x))
    threeCs-list-of-lists))
  (identity "Done!"))

(setq min-a-list (reduce #'min threeCs-1))
(setq min-a-list (reduce #'max threeCs-1))
(progn
  (setq
   threeCs-1-norm
   (normalise-0-1
	    (mapcar
            #'(lambda (x) (nth 1 x))
            threeCs-list-of-lists)))
  (identity "Done!"))

#| Problem solved I think! |#

(setq growing-list
      (append
       growing-list (list pattern&translators)))

(progn
  (setq
   reduced-dataset
   (remove-pattern-occurrences-from-dataset
	pattern&translators dataset))
  (length reduced-dataset))

#| Step 6 - Ready to restart COSIATEC. |#

(time
 (COSIATEC
  reduced-dataset prefix counter growing-list))
