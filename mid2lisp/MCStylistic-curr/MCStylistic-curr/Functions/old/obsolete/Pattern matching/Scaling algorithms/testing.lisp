#| Tom Collins
   Monday 15 June 2009
   Complete Monday 15 June 2009

Wanted to test the functions reflected-SIA-scaling,
scaling-SIATEC and SIAMWTEC on a medium-size
dataset (open Scarlatti-K3.lisp in this folder
and setq the dataset).

The functions seem to work quite well, although
SIAMWT does take a while.. Interestingly the
function reflected-SIA-scaling was much quicker
when everything was held in memory. |#

(progn
  (setq dataset (firstn 50 dataset))
  (print "Medium-sized dataset defined"))

(reflected-SIA-scaling
 dataset '(1 1 1 1) 500
 "Med (1 1 1 1) prep" "txt"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/")

(reflect-files
 "Med (1 1 1 1) prep"
 "Med (1 1 1 1) SIA"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 1)

(scaling-SIATEC
 dataset
 "Med (1 1 1 1) SIA" "Med (1 1 1 1) SIATEC"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 1 500)

(SIAMWT
 dataset
 "Med (1 1 1 1) SIA" "Med (1 1 1 1) SIAMWT"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "//Applications/CCL/Lisp code/Pattern matching/Write to files/"
 "txt" 1 5000 5000)
;; this took ages.

(progn
  (MWT-1st-cycle
   dataset "Med (1 1 1 1) SIA" "Med (1 1 1 1) SIAMWT"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 1 60 5)
