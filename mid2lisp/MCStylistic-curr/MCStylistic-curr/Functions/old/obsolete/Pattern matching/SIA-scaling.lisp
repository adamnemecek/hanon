#| Tom Collins
   Monday 15 June 2009
   Complete Monday 15 June 2009

The aim of these functions is to implement one of the
key ideas from a paper entitled `Algorithms for
discovering repeated patterns in multidimensional
representations of polyphonic music', by D. Meredith,
K. Lemstrom and G.A. Wiggins, in Journal of New Music
Research 31(4) 2002, 321-345. It is the idea of
maximal translatable pattern.

An initial attempt to code this idea (see maximal-
translatable-pattern) was unable to handle large
datasets. We assume the functions in sort-by, choose,
chords, markov-analyse etc? have been loaded. |#

#| Example:
(MWT-1st-cycle
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63) (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 "Fantasia (1 1) SIA" "Fantasia (1 1) SIAMWT"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 2 60 5)
gives files in the specified location.

This function applies the first cycle of the SIAMWT
algorithm, the first cycle being very similar to
the SIATEC algorithm. The difference is that the
indices of contributory MTPs is returned, so that
they can be retrieved by later cycles for the
formation of intersections. |#

(defun MWT-1st-cycle
       (dataset prefix-origin prefix-destination
	pathname-origin pathname-destination
	extension number-of-files
        partition-size-SIA partition-size-SIAMWT
	&optional
        (number-of-MTPs
         (+ (* partition-size-SIA
               (- number-of-files 1))
            (length
             (read-from-file
              (concatenate-filename
               pathname-origin prefix-origin
               number-of-files extension)))))
        (i 0)
        (intersection-indices nil)
        (counter-origin 1)
	(counter-destination 1)
	(filename-origin
	 (concatenate-filename
	  pathname-origin prefix-origin
	  counter-origin extension))
	(filename-destination
	 (concatenate-filename
	  pathname-destination prefix-destination
	  counter-destination extension))
	(growing-list nil) (j 0)
	(pairs
	 (if (<= counter-origin number-of-files)
	   (read-from-file filename-origin)))
	(pattern (first (first pairs)))
	;;(translator (second (first pairs)))
	(result-exact-recent
	 (assoc pattern growing-list :test #'equalp))
	(result-exact
	 (if (and (> counter-destination 1)
		  (null result-exact-recent))
	   (assoc-files
	    pattern pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-exact-recent)))
	(result-translation-recent
	 (if (null result-exact)
	   (assoc-translations pattern growing-list)))
	(result-translation
	 (if (and (null result-exact)
		  (> counter-destination 1)
		  (null result-translation-recent))
	   (assoc-translations-files
	    pattern pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-translation-recent)))
        (translators
	 (if (and
	      (null result-exact)
	      (null result-translation)
	      pattern)
           (translators-of-pattern-in-dataset
            pattern dataset)))
        )
  (if (> counter-origin number-of-files)
    (if (null growing-list)
      (list
       counter-destination
       intersection-indices)
      (progn
        (write-to-file growing-list
                       filename-destination)
        (list
         counter-destination
         intersection-indices)))
    (if (null pattern)
      (MWT-1st-cycle
       dataset prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension number-of-files partition-size-SIA
       partition-size-SIAMWT number-of-MTPs
       i intersection-indices
       (+ counter-origin 1) counter-destination
       (concatenate-filename
	pathname-origin prefix-origin
	(+ counter-origin 1) extension)
       filename-destination growing-list j)
      (if (equal j partition-size-SIAMWT)
	(progn
	  (write-to-file growing-list
			 filename-destination)
	  (MWT-1st-cycle
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files
           partition-size-SIA partition-size-SIAMWT
           number-of-MTPs i intersection-indices
	   counter-origin (+ counter-destination 1)
	   filename-origin
	   (concatenate-filename
	    pathname-destination prefix-destination
	    (+ counter-destination 1) extension)
	   nil 0 pairs pattern #|translator|# nil))
	(if result-exact
	  (MWT-1st-cycle
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files
           partition-size-SIA partition-size-SIAMWT
           number-of-MTPs (+ i 1)
           intersection-indices counter-origin
           counter-destination filename-origin
           filename-destination growing-list j
           (rest pairs))
          (if result-translation
            (MWT-1st-cycle
             dataset prefix-origin
             prefix-destination pathname-origin
             pathname-destination extension
             number-of-files partition-size-SIA
             partition-size-SIAMWT number-of-MTPs
             (+ i 1) intersection-indices
             counter-origin counter-destination
             filename-origin filename-destination
             growing-list j (rest pairs))
            (MWT-1st-cycle
             dataset prefix-origin
             prefix-destination pathname-origin
             pathname-destination extension
             number-of-files partition-size-SIA
             partition-size-SIAMWT number-of-MTPs
             (+ i 1)
             (append intersection-indices (list i))
             counter-origin counter-destination
             filename-origin filename-destination
             (append
              growing-list
              (list
               (list
                pattern
                translators
             #| 25/08/09 Don't think this call is
                 necessary...
                 (insert-retaining-sorted-asc
                 (second (first pairs))
                 translators) |#
                 )))
             (+ j 1) (rest pairs))))))))

#| Example:
(MWT-nth-cycle
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63) (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 "Fantasia (1 1) SIA" "Fantasia (1 1) SIAMWT"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 60 5 '(2 (0 12 22 25 26 33 39 56 95)))
gives files in the specified location.

This function applies the nth cycle of the SIAMWT
algorithm, n > 1. The first optional argument
contains the indices of contributory intersections
(taken over MTPs) from the last cycle. Further
intersections are formed and tested for their
contribution. The output is a new list of
contributory indices. |#

(defun MWT-nth-cycle
       (dataset prefix-origin prefix-destination
        pathname-origin pathname-destination
	extension #|last-cycle-output|#
        partition-size-SIA partition-size-SIAMWT
	&optional
        (last-cycle-output '(1))
        (counter-destination
         (first last-cycle-output))
        (filename-destination
	 (concatenate-filename
	  pathname-destination prefix-destination
	  counter-destination extension))
        (growing-list
         (read-from-file
          (concatenate-filename
           pathname-destination prefix-destination
           counter-destination extension)))
        (j (length growing-list))
        (right-sides
         (second last-cycle-output))
        (augmentation-indices
         (if (null (third last-cycle-output))
           (list-elements right-sides)
           (third last-cycle-output)))
        (next-indices nil)
        (number-of-rights
         (length right-sides))
        (number-of-augmentations
         (length augmentation-indices))
        (s 0)
        (r
         (if (< s number-of-augmentations)
           (+ 1
              (index-item-1st-occurs
               (my-last
                (nth s augmentation-indices))
               right-sides))))
        (intersection-indices
         (if (and r (< r number-of-rights))
           (append
            (nth s augmentation-indices)
            (list (nth r right-sides)))))
        (intersect
         (if intersection-indices
           (intersect-indices-in-files
            intersection-indices prefix-origin
            pathname-origin extension
            partition-size-SIA)))
        (result-exact-recent
         (if (not (null intersect))
           (assoc
            intersect
            growing-list :test #'equalp)))
        (result-exact
	 (if (and (not (null intersect))
                  (> counter-destination 1)
		  (null result-exact-recent))
	   (assoc-files
	    intersect pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-exact-recent)))
        (result-translation-recent
	 (if (and (not (null intersect))
                  (null result-exact))
	   (assoc-translations
            intersect growing-list)))
        (result-translation
	 (if (and (not (null intersect))
                  (null result-exact)
		  (> counter-destination 1)
		  (null result-translation-recent))
	   (assoc-translations-files
	    intersect pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-translation-recent)))
;;        (next-indices
;;         (if (and (not (null intersect))
;;                 (not result-exact)
;;                  (not result-translation))
;;          (append
;;            next-indices
;;           (list intersection-indices))))
        )
  (if (and
       (>= s number-of-augmentations)
       (>= r number-of-rights))
    (if (null growing-list)
      (list
       (- counter-destination 1)
       right-sides
       next-indices)
      (progn
        (write-to-file growing-list
                       filename-destination)
        (list
         counter-destination
         right-sides
         next-indices)))
    (if (>= r number-of-rights)
      (MWT-nth-cycle
       dataset prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension #|last-cycle-output|#
       partition-size-SIA partition-size-SIAMWT
       last-cycle-output
       counter-destination filename-destination
       growing-list j right-sides
       augmentation-indices next-indices
       number-of-rights number-of-augmentations
       (+ s 1) (+ s 2))
      (if (equal j partition-size-SIAMWT)
	(progn
	  (write-to-file growing-list
			 filename-destination)
	  (MWT-nth-cycle
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension #|last-cycle-output|#
           partition-size-SIA partition-size-SIAMWT
           last-cycle-output
           (+ counter-destination 1)
           (concatenate-filename
            pathname-destination prefix-destination
            (+ counter-destination 1) extension)            
           nil 0 right-sides augmentation-indices
           next-indices number-of-rights
           number-of-augmentations s r
           intersection-indices intersect nil))
	(if (or (null intersect)
                result-exact
                result-translation)
	  (MWT-nth-cycle
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension #|last-cycle-output|#
           partition-size-SIA partition-size-SIAMWT
           last-cycle-output
           counter-destination filename-destination
           growing-list j right-sides
           augmentation-indices next-indices
           number-of-rights number-of-augmentations
           s (+ r 1))
          (MWT-nth-cycle
           dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension #|last-cycle-output|#
           partition-size-SIA partition-size-SIAMWT
           last-cycle-output
           counter-destination filename-destination
           (append
            growing-list
            (list
             (list
              intersect
              (translators-of-pattern-in-dataset
                intersect dataset))))
           (+ j 1) right-sides
           augmentation-indices
           (append
            next-indices
            (list intersection-indices))
           number-of-rights number-of-augmentations
           s (+ r 1)))))))

#| Example:
(reflected-SIA-scaling
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63) (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 '(1 1) 60
 "Fantasia (1 1) prep" "txt"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/")
gives files in the specified location.

This function calculates the reduced difference set
for the projected dataset, assumed to be ordered
ascending. The projection indicator is a required
argument so as to distinguish the text files thus
created, according to the partition size, which must
also be specified. A byproduct of this process is the
calculation of maximal translatable patterns.

This function will often be followed by a call to
reflect files, such as
(reflect-files
 "Fantasia (1 1) prep"
 "Fantasia (1 1) SIA"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 2). |#

(defun reflected-SIA-scaling
       (dataset projection-indicator
       	partition-size &optional
	(filename-prefix
	 (concatenate
	  'string
	  "prep"
	  (format nil " ~D" projection-indicator)))
	(extension "txt")
	(pathname "//Applications/CCL/Lisp code/Pattern matching/Write to files/")
        (filename-counter 1) (growing-list nil) (j 0)
	(first-dataset (first dataset))
	(rest-dataset (rest dataset))
	(probe
	 (if (null rest-dataset) ()
	   (subtract-two-lists
	    (first rest-dataset) (first dataset))))
	(result-recent
	 (assoc probe growing-list :test #'equalp))
	(result
	 (if (and (> filename-counter 1)
		  (null result-recent))
	   (assoc-files
	    probe pathname filename-prefix
	    extension (- filename-counter 1))
	   (identity result-recent))))
  (if (null dataset)
    (progn
      (write-to-file
       growing-list
       (concatenate-filename
        pathname filename-prefix
        filename-counter extension))
      (identity filename-counter))
    (if (null probe)
      (reflected-SIA-scaling
       (rest dataset) projection-indicator
       partition-size filename-prefix extension
       pathname filename-counter growing-list j)
      (if (equal j partition-size)
	(progn
	  (write-to-file
	   growing-list
	   (concatenate-filename
	    pathname filename-prefix
	    filename-counter extension))
	  (reflected-SIA-scaling
	   dataset projection-indicator
	   partition-size filename-prefix
	   extension pathname
	   (+ filename-counter 1) nil
	   0 first-dataset rest-dataset
	   probe nil)) #| 23/07/09 Changed this
from ...probe result-recent result. This was
because if v was found recently as the partition-
size was reached, growing-list would be written to
file and the recent result would no longer hold.
Therefore the result-recent is certainly null
and result must be recalculated. |#
	(if result-recent
	  (reflected-SIA-scaling
	   dataset projection-indicator
	   partition-size filename-prefix extension
	   pathname filename-counter
	   (append
	    (remove result-recent
		    growing-list :test #'equalp)
	    (list
	     (list
	      (first result-recent)
	      (append (second result-recent)
		      (list first-dataset)))))
	   j first-dataset (rest rest-dataset))
	  (if result
	    (progn
	      (update-written-file
	       pathname filename-prefix
	       (first result) extension
	       first-dataset (second result)
               partition-size)
	      (reflected-SIA-scaling
	       dataset projection-indicator
	       partition-size filename-prefix extension
	       pathname filename-counter growing-list
	       j first-dataset (rest rest-dataset)))
	    (reflected-SIA-scaling
	     dataset projection-indicator
	     partition-size filename-prefix
	     extension pathname filename-counter
	     (append
	      growing-list
	      (list
	       (list probe
		     (list first-dataset))))
	     (+ j 1) first-dataset
	     (rest rest-dataset))))))))

#| Example:
(scaling-SIATEC
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63) (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 "Fantasia (1 1) SIA" "Fantasia (1 1) SIATEC"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 2 5)
gives files at the location specified.

The algorithm SIA has been applied and results exist
in files at the location specified. This function is
an implementation of the SIATEC algorithm.

22/07/09. This function has been corrected. If a later
version of an MTP appeared earlier in the output of the
function reflected-SIA-scaling, then this could cause
translators to be missed. This has now been fixed but
requires testing with a dataset somewhere in between
Faro and Oland. |#

(defun scaling-SIATEC
       (dataset prefix-origin prefix-destination
	pathname-origin pathname-destination
	extension number-of-files partition-size
	&optional (counter-origin 1)
	(counter-destination 1)
	(filename-origin
	 (concatenate-filename
	  pathname-origin prefix-origin
	  counter-origin extension))
	(filename-destination
	 (concatenate-filename
	  pathname-destination prefix-destination
	  counter-destination extension))
	(growing-list nil) (j 0)
	(pairs
	 (if (<= counter-origin number-of-files)
	   (read-from-file filename-origin)))
	(pattern (first (first pairs)))
	;;(translator (second (first pairs)))
	(result-exact-recent
	 (assoc pattern growing-list :test #'equalp))
	(result-exact
	 (if (and (> counter-destination 1)
		  (null result-exact-recent))
	   (assoc-files
	    pattern pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-exact-recent)))
	(result-translation-recent
	 (if (null result-exact)
	   (assoc-translations pattern growing-list)))
	(result-translation
	 (if (and (null result-exact)
		  (> counter-destination 1)
		  (null result-translation-recent))
	   (assoc-translations-files
	    pattern pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-translation-recent)))
        (translators
	 (if (and
	      (null result-exact)
	      (null result-translation)
	      pattern)
           (translators-of-pattern-in-dataset
            pattern dataset)))
        )
  (if (> counter-origin number-of-files)
    (if (null growing-list) (identity t)
      (write-to-file growing-list
		     filename-destination))
    (if (null pattern)
      (scaling-SIATEC
       dataset prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension number-of-files partition-size
       (+ counter-origin 1) counter-destination
       (concatenate-filename
	pathname-origin prefix-origin
	(+ counter-origin 1) extension)
       filename-destination growing-list j)
      (if (equal j partition-size)
	(progn
	  (write-to-file growing-list
			 filename-destination)
	  (scaling-SIATEC
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files partition-size
	   counter-origin (+ counter-destination 1)
	   filename-origin
	   (concatenate-filename
	    pathname-destination prefix-destination
	    (+ counter-destination 1) extension)
	   nil 0 pairs pattern #|translator|# nil))
	(if result-exact
	  (scaling-SIATEC
	   dataset prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files partition-size
	   counter-origin counter-destination
	   filename-origin filename-destination
	   growing-list j (rest pairs))
          (if result-translation
            (scaling-SIATEC
             dataset prefix-origin
             prefix-destination pathname-origin
             pathname-destination extension
             number-of-files partition-size
             counter-origin counter-destination
             filename-origin filename-destination
             growing-list j (rest pairs))
            (scaling-SIATEC
             dataset prefix-origin
             prefix-destination pathname-origin
             pathname-destination extension
             number-of-files partition-size
             counter-origin counter-destination
             filename-origin filename-destination
             (append
              growing-list
              (list
               (list
                pattern
                translators
#| 30/07/2009 Is this call to insert-retaining-sorted-
asc defunct?
                (insert-retaining-sorted-asc
                 (second (first pairs))
                 translators) |#
                )))
             (+ j 1) (rest pairs))))))))

#| Example:
(SIAMWT
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60) (8 64) (9 63) (12 56) (13 69) (15 65) (16 57) (16 59) (17 64) (19 63))
 "Fantasia (1 1) SIA" "Fantasia (1 1) SIAMWT"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 2 60 5)
gives files in the specified location.

This function applies the functions MWT-first-cycle
and MWT-nth cycle, the latter recursively, until no
new contributory intersections are found. This
amounts to the SIAMWT algorithm, returning all
MWT patterns in a dataset D. |#

(defun SIAMWT
       (dataset prefix-origin prefix-destination
        pathname-origin pathname-destination
	extension number-of-files
        partition-size-SIA partition-size-SIAMWT
        &optional (initial t)
        (current-cycle-output nil)
        (next-cycle-output
         (if current-cycle-output
           (MWT-nth-cycle
            dataset prefix-origin prefix-destination
            pathname-origin pathname-destination
            extension partition-size-SIA
            partition-size-SIAMWT
            current-cycle-output)
           (MWT-1st-cycle
            dataset prefix-origin
            prefix-destination pathname-origin
            pathname-destination	extension
            number-of-files partition-size-SIA
            partition-size-SIAMWT))))
  (if (and (null (third next-cycle-output))
           (not initial))
    (print "Finished!")
    (SIAMWT
     dataset prefix-origin prefix-destination
     pathname-origin pathname-destination extension
     number-of-files partition-size-SIA
     partition-size-SIAMWT nil next-cycle-output)))




