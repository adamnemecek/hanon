#| Tom Collins
   Thursday 23 July 2009
   Incomplete

These functions are no longer of great use, but I
don't want to delete them til I've checked. Reference
is `Algorithms for discovering repeated patterns in
multidimensional representations of polyphonic music',
by D. Meredith, K. Lemstrom and G.A. Wiggins, in
Journal of New Music Research 31(4) 2002, 321-345. |#

#| Example:
(assoc-subsets-multidimensional
 '((2 2) (4 5))
 '((((2 2) (23 4)) ((6 2)))
   (((2 2) (10 14) (13 8) (23 4)) ((3 2) (2 3)))
   (((2 2) (4 5) (5 4)) ((21 2)))
   (((2 2) (4 5)) ((11 6) (21 2) (8 12)))
   (((2 2)) ((6 2) (3 2) (2 3) (21 2) (11 6)))))
gives
(2 (((2 2) (4 5) (5 4)) ((21 2)))).

Two arguments are supplied to this function: a list of
(real) vectors of uniform dimension k and an assoc
list, the first of each pair again a list of vectors
of dimension k. When the first argument is a subset
of the first of a pair, an index m is returned, as is the
pair. Otherwise nil is returned. |#

(defun assoc-subsets-multidimensional
       (a-list b-list &optional (m 0)
	(first-b-list (nth m b-list)))
  (if (null first-b-list) ()
    (if (subset-multidimensional
	 a-list (first first-b-list))
      (list m first-b-list)
      (assoc-subsets-multidimensional
       a-list b-list (+ m 1)))))

#| Example:
(collect-translators-for=MTPs
 "prep for SIA (1 0 1 0)"
 "collected=MTPs (1 0 1 0)"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 4 2)
gives files in the specified location.

This function locates MTPs that are found more than
once by the SIA algorithm and collects their
translators in files specified by the arguments. |#

(defun collect-translators-for=MTPs
       (prefix-origin prefix-destination
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
	(first-pair (first pairs))
	;;(rest-pairs (rest pairs))
	(result-recent
	 (assoc (first first-pair)
		growing-list :test #'equalp))
	(result
	 (if (and (> counter-destination 1)
		  (null result-recent))
	   (assoc-files
	    (first first-pair) pathname-destination
	    prefix-destination extension
	    (- counter-destination 1))
	   (identity result-recent))))
  (if (> counter-origin number-of-files)
    (if (null growing-list) (identity t)
      (write-to-file
       growing-list filename-destination))
    (if (null first-pair)
      (collect-translators-for=MTPs
       prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension number-of-files partition-size
       (+ counter-origin 1) counter-destination
       (concatenate-filename
	pathname-origin prefix-origin
	(+ counter-origin 1) extension)
       filename-destination growing-list j)
      (if (equal j partition-size)
	(progn
	  (write-to-file
	   (firstn j growing-list)
	   filename-destination)
	  (collect-translators-for=MTPs
	   prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files partition-size
	   counter-origin (+ counter-destination 1)
	   filename-origin
	   (concatenate-filename
	    pathname-destination prefix-destination
	    (+ counter-destination 1) extension)
	   nil 0 pairs first-pair nil))
	(if result-recent
	  (collect-translators-for=MTPs
	   prefix-origin prefix-destination
	   pathname-origin pathname-destination
	   extension number-of-files partition-size
	   counter-origin counter-destination
	   filename-origin filename-destination
	   (append
	    (remove result-recent
		    growing-list :test #'equalp)
	    (list
	     (list
	      (first first-pair)
	      (list
	       (+ (first (second result-recent)) 1)
	       (append
		(second (second result-recent))
		(list (second first-pair)))))))
	   j (rest pairs))
	  (if result
	    (progn
	      (update-written-file-row
	       pathname-destination
	       prefix-destination (first result)
	       extension
	       (list
		(first first-pair)
		(list
		 (+
		  (first (second (second result)))
		  1)
		 (append
		  (second (second (second result)))
		  (list (second first-pair)))))
	       (second result))
	      (collect-translators-for=MTPs
	       prefix-origin prefix-destination
	       pathname-origin pathname-destination
	       extension number-of-files
	       partition-size counter-origin
	       counter-destination filename-origin
	       filename-destination growing-list j
	       (rest pairs)))
	    (collect-translators-for=MTPs
	     prefix-origin prefix-destination
	     pathname-origin pathname-destination
	     extension number-of-files
	     partition-size counter-origin
	     counter-destination filename-origin
	     filename-destination
	     (append
	      growing-list
	      (list
	       (list
		(first first-pair)
		(list 1
		      (list
		       (second first-pair))))))
	     (+ j 1) (rest pairs))))))))

#| Example:
(difference-list-reduced-asc-assumption
 '((4 6 6) (4 7 -3) (8 -2 -3)))
gives
((0 1 -9) (4 -8 -9) (4 -9 0)).

The argument to this function is a dataset. We use
this function under the assumption that the dataset
has been subjected to the function sort-dataset-
ascending, but it does not have to have been sorted
this way in order for the function to work. The
function subtract-list-from-each-list is applied to
smaller and smaller subsets of the dataset, avoiding
the redundancy in the output whereby both v and -v
appear. |#

(defun difference-list-reduced-asc-assumption
       (dataset)
  (if (null dataset) ()
    (append
     (subtract-list-from-each-list
      (rest dataset)
      (first dataset))
     (difference-list-reduced-asc-assumption
      (rest dataset)))))

#| Example:
(difference-list-reduced-no-assumption
 '((4 6 6) (8 -2 -3) (4 7 -3)))
gives
((0 1 -9) (4 -8 -9) (4 -9 0)).

The argument to this function is a dataset. We use
this function under no assumption that the dataset
has been sorted in any way. The first thing that
happens however, is the application of the function
sort-dataset-asc. Then the function subtract-list-
from-each-list is applied to smaller and smaller
subsets of the dataset, avoiding the redundancy in
the output whereby both v and -v appear. |#

(defun difference-list-reduced-no-assumption
       (dataset &optional
	(sorted-dataset
	 (sort-dataset-asc dataset)))
  (if (null sorted-dataset) ()
    (append
     (subtract-list-from-each-list
      (rest sorted-dataset)
      (first sorted-dataset))
     (difference-list-reduced-no-assumption
      '() (rest sorted-dataset)))))

#| Example:
(difference-set-scaling
 '((12 55 1) (12 67 1) (13 60 2) (13 72 2)
   ;;(14 59 2) (15 64 1) (16 58 1) (17 67 1)
   ;;(18 65 1) (19 60 1) (19 69 1) (12 60 1)
   )
 '(1 0 1 1) 3
 "difference set" "txt"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/")
gives files in the specified location.

This function calculates the reduced difference set
for the projected dataset, assumed to be ordered
ascending. The projection indicator is a required
argument so as to distinguish the text files thus
created, according to the partition size, which must
also be specified. |#

(defun difference-set-scaling
       (dataset projection-indicator
	partition-size &optional
	(filename-prefix
	 (concatenate
	  'string
	  "difference set"
	  (format nil " ~D" projection-indicator)))
	(extension "txt")
	(pathname "//Applications/CCL/Lisp code/Pattern matching/Write to files/")
        (filename-counter 1)
	(growing-list nil) (i 1) (j 0)
	(rest-dataset (rest dataset))
	(probe
	 (if (null rest-dataset) ()
	   (subtract-two-lists
	    (first rest-dataset) (first dataset)))))
  (if (null dataset)
    (write-to-file
     growing-list
     (concatenate-filename
      pathname filename-prefix
      filename-counter extension))
    (if (null probe)
      (difference-set-scaling
       (rest dataset) projection-indicator
       partition-size filename-prefix extension
       pathname filename-counter
       growing-list i j)
      (if (assoc probe growing-list :test #'equalp)
	(difference-set-scaling
	 dataset projection-indicator
	 partition-size filename-prefix extension
	 pathname filename-counter
	 growing-list i j (rest rest-dataset))
	(if (equal filename-counter 1)
	  (if (equal j partition-size)
	    (progn
	      (write-to-file
	       growing-list
	       (concatenate-filename
		pathname filename-prefix
		filename-counter extension))
	      (difference-set-scaling
	       dataset projection-indicator
	       partition-size filename-prefix
	       extension pathname
	       (+ filename-counter 1)
	       nil i 0 rest-dataset probe))
	    (difference-set-scaling
	     dataset projection-indicator
	     partition-size filename-prefix
	     extension pathname
	     filename-counter
	     (append
	      growing-list
	      (list (append (list probe) (list i))))
	     (+ i 1) (+ j 1) (rest rest-dataset)))
	  (if (assoc-files
	       probe pathname filename-prefix
	       extension (- filename-counter 1))
	    (difference-set-scaling
	     dataset projection-indicator
	     partition-size filename-prefix
	     extension pathname filename-counter
	     growing-list i j (rest rest-dataset))
	    (if (equal j partition-size)
	      (progn
		(write-to-file
		 growing-list
		 (concatenate-filename
		  pathname filename-prefix
		  filename-counter extension))
		(difference-set-scaling
		 dataset projection-indicator
		 partition-size filename-prefix
		 extension pathname
		 (+ filename-counter 1)
		 nil i 0 rest-dataset probe))
	      (difference-set-scaling
	       dataset projection-indicator
	       partition-size filename-prefix
	       extension pathname filename-counter
	       (append
		growing-list
		(list (append
		       (list probe) (list i))))
	       (+ i 1) (+ j 1)
	       (rest rest-dataset)))))))))

#| Example:
(events-with-these-ontime-durations
 '((6 1/2) (7 1) (9 1))
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/2 1 37) (6 84 1 2 34) (7 91 1 1 56)
   (7 96 1 1 73) (7 99 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73)
   (39/4 110 1/4 2 66) (10 88 23/40 1 74)
   (10 92 23/40 1 74)))
gives
((6 1/2) (6 1/2)
 (7 1) (7 1) (7 1)
 (9 1) (9 1) (9 1)).

The function events-with-this-ontime-duration is
applied to each member of the list forming the first
argument of this function.
|#

(defun events-with-these-ontime-durations
       (projected-datapoints unprojected-dataset
        &optional
        (ontime-index 0) (duration-index 2)
        (ontimes (nth-list-of-lists
                  ontime-index
                  unprojected-dataset))
        (relevant-start
         (index-1st-sublist-item>=
          (first (first projected-datapoints))
          ontimes))
        (relevant-finish
         (index-1st-sublist-item>=
          (+ (first (my-last projected-datapoints))
	     0.01)
          ontimes))
        (relevant-dataset
         (subseq
          unprojected-dataset
          (if (null relevant-start)
             (identity 0)
             (identity relevant-start))
          (if (null relevant-finish)
             (length ontimes)
             (identity relevant-finish)))))
  (if (null projected-datapoints) ()
    (append
     (events-with-this-ontime-duration
      (first projected-datapoints)
      relevant-dataset
      ontime-index duration-index)
     (events-with-these-ontime-durations
      (rest projected-datapoints)
      unprojected-dataset
      ontime-index duration-index
      ontimes
      relevant-start relevant-finish
      relevant-dataset))))

#| Example:
(events-with-this-ontime-duration
 '(6 1/2)
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/2 1 37) (6 84 1 2 34) (7 91 1 1 56)
   (7 96 1 1 73) (7 99 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73)))
gives
((6 1/2) (6 1/2)).

A projected datapoint d' and the relevant dataset D
from which this datapoint hails are provided as
arguments. A list is returned of all the
(unprojected) datapoints d in D which have the
ontime and duration of d'. |#

(defun events-with-this-ontime-duration
       (projected-datapoint relevant-dataset
        &optional (ontime-index 0)
                  (duration-index 2))
  (if (null projected-datapoint) ()
    (if (null relevant-dataset) ()
      (append
       (if (equalp
            (list (nth
                   ontime-index
                   (first relevant-dataset))
                  (nth
                   duration-index
                   (first relevant-dataset)))
            projected-datapoint)
         (list
          (list (nth
                 ontime-index
                 (first relevant-dataset))
                (nth
                 duration-index
                 (first relevant-dataset)))))
       (events-with-this-ontime-duration
        projected-datapoint
        (rest relevant-dataset)
        ontime-index duration-index)))))

#| Example:
(list2set
 '((0 1) (0 1) (0 1/2) (1 1)
   (1 1) (-2 3) (4 4) (4 4)))
gives
((-2 3) (0 1/2) (0 1) (1 1) (4 4)).

A list of sublists is input to this function, where
each sublist is assumed to be of the same length. The
output has any repeated sublists removed, and so it
can be thought of as a set. |#

(defun list2set (a-list &optional
       (m (length a-list))
       (n (length (first a-list)))
       (sorted-list
        (sort-by
         (pair-off-lists
          (add-to-list
           -1 (reverse (first-n-naturals n)))
          (constant-vector "asc" n))
         a-list)))
  (if (null sorted-list) ()
    (if (equal m 1) (identity sorted-list)
      (append
       (if (not (equal (first sorted-list)
                       (second sorted-list)))
         (list (first sorted-list)))
       (list2set
        a-list (- m 1) n (rest sorted-list))))))

#| Example:
(maximal-translatable-pattern-SIA '(2 0)
 '((0 1/2) (0 1) (1 1) (2 1/2) (2 1) (3 2)))
gives
((0 1) (0 1/2)).

This function is very similar to the function
maximal-translatable-pattern>, which underpins the
function maximal-translatable-pattern. However, this
version is called by the function SIA, which sorts
the dataset as a preliminary step. This means it is
unnecessary to resort the dataset, and this function
is more efficient for this assumption. |#

(defun maximal-translatable-pattern-SIA
       (vector sorted-dataset)
  (if (null sorted-dataset) ()
    (append
     (if (test-equal<list-elements
	  sorted-dataset
	  (add-two-lists
	   vector
	   (first sorted-dataset)))
       (list (first sorted-dataset)))
     (maximal-translatable-pattern-SIA
      vector (rest sorted-dataset)))))

#| Example:
(orthogonal-projection-unique-scaling
 '((12 52 55 1) (12 71 66 1) (13 60 60 1)
   (13 69 65 2) (14 59 59 2) (15 68 64 1)
   (16 57 58 1) (17 72 67 1) (18 69 65 1)
   (19 60 60 1) (19 76 69 1) (12 60 60 1))
 '(1 0 0 1) 2
 "projection" "txt"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/")
gives files in the specified location.

This function takes three arguments: a dataset,
assumed to be sorted ascending, a projection-
indicator vector and a partition size. The dataset
is projected according to the projection-indicator
vector and segmented into partitions of the specified
size for storage in a file of default type txt and
default location /Lisp code/Write to files/. Repeated
values do not occur. |#

(defun orthogonal-projection-unique-scaling
       (dataset projection-indicator
        partition-size &optional
        (filename-prefix
         (concatenate
          'string
          "projection"
          (format
           nil " ~D" projection-indicator)))
        (extension "txt")
        (pathname "//Applications/CCL/Lisp code/Pattern matching/Write to files/")
        (filename-counter 1)
        (nth-list-indexed
         (nth-list-index projection-indicator))
        (growing-list nil) (i 1) (j 0)
        (probe
         (nth-list nth-list-indexed
                   (first dataset))))
  (if (null dataset)
    (write-to-file
     growing-list
     (concatenate-filename
      pathname filename-prefix
      filename-counter extension))
    (if (assoc probe growing-list :test #'equalp)
      (orthogonal-projection-unique-scaling
       (rest dataset) projection-indicator
       partition-size filename-prefix extension
       pathname filename-counter nth-list-indexed
       growing-list i j)
      (if (equal filename-counter 1)
        (if (equal j partition-size)
          (progn
            (write-to-file
             growing-list
             (concatenate-filename
              pathname filename-prefix
              filename-counter extension))
            (orthogonal-projection-unique-scaling
             dataset projection-indicator
             partition-size filename-prefix
             extension pathname
             (+ filename-counter 1)
             nth-list-indexed nil i 0 probe))
          (orthogonal-projection-unique-scaling
           (rest dataset) projection-indicator
           partition-size filename-prefix
           extension pathname filename-counter
           nth-list-indexed
           (append
            growing-list
            (list (append (list probe) (list i))))
           (+ i 1) (+ j 1)))
        (if (assoc-files
             probe pathname filename-prefix
             extension (- filename-counter 1))
          (orthogonal-projection-unique-scaling
           (rest dataset) projection-indicator
           partition-size filename-prefix
           extension pathname filename-counter
           nth-list-indexed growing-list i j)
          (if (equal j partition-size)
            (progn
              (write-to-file
               growing-list
               (concatenate-filename
                pathname filename-prefix
                filename-counter extension))
              (orthogonal-projection-unique-scaling
               dataset projection-indicator
               partition-size filename-prefix
               extension pathname
               (+ filename-counter 1)
	       nth-list-indexed
               nil i 0 probe))
            (orthogonal-projection-unique-scaling
             (rest dataset) projection-indicator
             partition-size filename-prefix
             extension pathname filename-counter
             nth-list-indexed
             (append
              growing-list
              (list
               (append (list probe) (list i))))
             (+ i 1) (+ j 1))))))))

#| Example:
(reflect-remove-length1-files
 "reflected SIA (1 0 1 0)"
 "prep-1 for SIA (1 0 1 0)"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 4 3)
gives files in the specified location.

This function reflects (as in the function reflect-
list) lists contained in files specified by the
arguments. Rows whose first element is of length 1
are also removed. |#

(defun reflect-remove-length1-files
       (prefix-origin prefix-destination
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
        (growing-list nil)
        (j (length growing-list)))
  (if (> counter-origin number-of-files)
    (if (null growing-list) (identity t)
      (write-to-file
       growing-list filename-destination))
    (if (>= j partition-size)
      (progn
        (write-to-file
         (firstn j growing-list)
         filename-destination)
        (reflect-remove-length1-files
         prefix-origin prefix-destination
         pathname-origin pathname-destination
         extension number-of-files partition-size
         counter-origin (+ counter-destination 1)
         filename-origin
         (concatenate-filename
          pathname-destination prefix-destination
          (+ counter-destination 1) extension)
         (lastn
          (- j partition-size) growing-list)))
      (reflect-remove-length1-files
       prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension number-of-files partition-size
       (+ counter-origin 1) counter-destination
       (concatenate-filename
        pathname-origin prefix-origin
        (+ counter-origin 1) extension)
       filename-destination
       (append growing-list
               (reflect-remove-length1-list
                (read-from-file
                 filename-origin)))))))

#| Example:
(reflect-remove-length1-list
 '(((1 1) ((1 1) (2 1) (3 1) (3 2)))
   ((4 2) ((1 1)))
   ((1 0) ((1 1) (2 1) (2 2) (3 2)))
   ((2 0) ((1 1) (2 2)))))
gives
((((1 1) (2 1) (3 1) (3 2)) (1 1))
 (((1 1) (2 1) (2 2) (3 2)) (1 0))
 (((1 1) (2 2)) (2 0)))

This function has one argument: a list of lists.
Each list is reversed and forms the output, unless
the second element has length one, in which case the
whole row is removed. |#

(defun reflect-remove-length1-list
       (a-list &optional
        (first-list (first a-list)))
  (if (null first-list) ()
    (append
     (if (> (length (second first-list)) 1)
       (list (reverse first-list)))
     (reflect-remove-length1-list
      (rest a-list)))))

#| Example:
(SIA-old '((3 2) (0 1) (1 1) (2 1/2) (0 1/2) (2 1)))
gives
((((0 1/2) (2 1/2)) (0 1/2))
 (((1 1)) (1 -1/2))
 (((0 1) (1 1)) (1 0))
 (((0 1/2)) (1 1/2))
 (((2 1)) (1 1))
 (((2 1/2)) (1 3/2))
 (((0 1)) (2 -1/2))
 (((0 1/2) (0 1)) (2 0))
 (((0 1/2)) (2 1/2))
 (((1 1)) (2 1))
 (((0 1)) (3 1))
 (((0 1/2)) (3 3/2))).

This function begins by sorting the dataset (its only
mandatory argument) ascending, and calculating the
difference set, which it also sorts ascending and
removes repeated values. The function maximal-
translatable-pattern-SIA is applied to each member of
the difference set, and a list of all maximal
translatable patterns is returned, proceeded in each
case by the motivating vector. |#

(defun SIA-old
       (dataset &optional
	(sorted-dataset
	 (sort-dataset-asc dataset))
	(vector-differences
	 (list2set
	  (difference-list-reduced-asc-assumption
	   sorted-dataset)))
	(first-vector (first vector-differences)))
  (if (null vector-differences) ()
    (append
     (list
      (list
       (maximal-translatable-pattern-SIA
	first-vector sorted-dataset)
       first-vector))
     (SIA-old
      '() sorted-dataset (rest vector-differences)))))

#| Example:
(SIA-nonreduced-difference-set
 '((3 2) (0 1) (1 1) (2 1/2) (0 1/2) (2 1)))
gives
((((3 2)) (-3 -3/2))
 (((3 2)) (-3 -1))
 (((3 2)) (-2 -1))
 (((2 1)) (-2 -1/2))
 (((2 1/2) (2 1))(-2 0))
 (((2 1/2)) (-2 1/2))
 (((3 2)) (-1 -3/2))
 (((3 2)) (-1 -1))
 (((1 1)) (-1 -1/2))
 (((1 1) (2 1)) (-1 0))
 (((2 1/2)) (-1 1/2))
 (((0 1) (2 1)) (0 -1/2))
 (((0 1/2) (2 1/2)) (0 1/2))
 (((1 1)) (1 -1/2))
 (((0 1) (1 1)) (1 0))
 (((0 1/2)) (1 1/2))
 (((2 1)) (1 1))
 (((2 1/2)) (1 3/2))
 (((0 1)) (2 -1/2))
 (((0 1/2) (0 1)) (2 0))
 (((0 1/2)) (2 1/2))
 (((1 1)) (2 1))
 (((0 1)) (3 1))
 (((0 1/2)) (3 3/2))).

This function is very similar to the function SIA.
Whereas SIA works with the reduced difference set
for a dataset D, SIA-nonreduced-difference set works
with the nonreduced version. However, the zero vector
is still excluded. We know $MTP(\mathbf{0}, D) = D$,
so this can be appended if desired. |#

(defun SIA-nonreduced-difference-set
       (dataset &optional
	(sorted-dataset
	 (sort-dataset-asc dataset))
	(vector-differences
	 (list2set
	  (difference-list sorted-dataset)))
	(first-vector (first vector-differences)))
  (if (null vector-differences) ()
    (append
     (list
      (list
       (if (> (nth
	       (index-item-1st-doesnt-occur
		0 first-vector)
	       first-vector) 0)
	 (maximal-translatable-pattern-SIA
	  first-vector sorted-dataset)
	 (translation
	  (maximal-translatable-pattern-SIA
	   (multiply-list-by-constant
	    first-vector -1)
	   sorted-dataset)
	  (multiply-list-by-constant
	   first-vector -1)))
       first-vector))
     (SIA-nonreduced-difference-set
      '() sorted-dataset (rest vector-differences)))))

#| Example:
(SIA-unique-output
 '((3 2) (0 1) (1 1) (2 1/2) (0 1/2) (2 1)) 0)
gives
(((2 1/2) (2 1))
 ((3 2))
 ((1 1) (2 1))
 ((0 1) (2 1))
 ((0 1/2) (2 1/2))
 ((0 1) (1 1))
 ((2 1))
 ((2 1/2))
 ((0 1/2) (0 1))
 ((1 1))
 ((0 1))
 ((0 1/2))).

This function looks at the output of either of the
functions SIA or SIA-nonreduced-difference-set, and
returns a list of the unique maximal translatable
patterns therein. Recall the dataset itself will not
be included in this output, even though it is a
maximal translatable pattern. |#

(defun SIA-unique-output
       (dataset &optional
        (reduced-difference-set 0)
        (sorted-dataset
	 (sort-dataset-asc dataset))
	(output
	 (if (equal
	      (identity reduced-difference-set) 0)
	   (SIA-nonreduced-difference-set
            dataset sorted-dataset)
	   (SIA-old dataset sorted-dataset)))
	(unique-output '()))
  (if (null output) (identity unique-output)
    (append
     (if (not (assoc (first (first output))
		     (rest output)
		     :test #'equalp))
       (list (first (first output))))
     (SIA-unique-output
      dataset reduced-difference-set sorted-dataset
      (rest output) unique-output))))

#| Example:
(SIATEC-old '((3 2) (0 1) (1 1) (2 1/2) (0 1/2) (2 1)) 1)
gives
((((0 1/2) (2 1/2))
  ((0 0) (0 1/2)))
 (((0 1) (1 1))
  ((0 0) (1 0)))
 (((2 1))
  ((-2 -1/2) (-2 0) (-1 0) (0 -1/2) (0 0) (1 1)))
 (((2 1/2))
  ((-2 0) (-2 1/2) (-1 1/2) (0 0) (0 1/2) (1 3/2)))
 (((0 1/2) (0 1))
  ((0 0) (2 0))) 
 (((1 1))
  ((-1 -1/2) (-1 0) (0 0) (1 -1/2) (1 0) (2 1)))
 (((0 1))
  ((0 -1/2) (0 0) (1 0) (2 -1/2) (2 0) (3 1)))
 (((0 1/2))
  ((0 0) (0 1/2) (1 1/2) (2 0) (2 1/2) (3 3/2)))).

This is the SIATEC algorithm, but it doesn't scale to
larger datasets. It takes a dataset as its only
mandatory argument, and returns a list of maximal
translatable patterns, each accompanied by the
translators of that pattern in the dataset. It does not
include the dataset in the output (even though this is
a maximal translatable pattern), as this can be appended
easily if desired. The user can opt for the nonreduced
difference set, but this is not advised as it will just
double the output in a deterministic fashion.

This function will also operate on a specified sorted
dataset and set of patterns, rather than just calling
the SIA algorithm in its preamble. |#

(defun SIATEC-old
       (dataset &optional
        (reduced-difference-set 1) 
        (sorted-dataset
	 (sort-dataset-asc dataset))
        (unique-SIA-output
         (SIA-unique-output
          dataset reduced-difference-set
          sorted-dataset))
        (first-output (first unique-SIA-output)))
  (if (null first-output) ()
    (cons
     (append
      (list
       first-output
       (translators-of-pattern-in-dataset
        first-output sorted-dataset)))
     (SIATEC-old
      dataset reduced-difference-set
      sorted-dataset
      (rest unique-SIA-output)))))

#| Example:
(sort-asc-nth-list-of-lists
 '(((10 62 3) (13 64 2)) ((0 50 3) (3 52 2))
   ((5 79 3) (8 81 2))))
gives
(((0 50 3) (3 52 2)) ((5 79 3) (8 81 2))
 ((10 62 3) (13 64 2))).

This function takes as its first argument a
translational equivalence class. Its optional
second argument is an index n. Each member of the
translational equivalence class is a set (assumed
ordered in some way). The nth element of the first
element of each member is sorted ascending,
providing an index for the reordering of the
translational equivalence class. This reordered
translational equivalence class is the output. |#

(defun sort-asc-nth-list-of-lists
       (translational-equivalence-class &optional
        (n 0)
        (length-TEC
         (length translational-equivalence-class))
        (indices
         (reverse
          (first-n-naturals length-TEC)))
        (list-to-sort
         (pair-off-lists
          (nth-list-of-lists
           n
           (nth-list-of-lists
            0 translational-equivalence-class))
          indices))
        (sorted-list
         (sort-by '((0 "asc")) list-to-sort))
        (new-indices
         (nth-list-of-lists 1 sorted-list)))
  (if (null new-indices) ()
    (cons
     (nth
      (- (first new-indices) 1)
      translational-equivalence-class)
     (sort-asc-nth-list-of-lists
      translational-equivalence-class n length-TEC
      indices list-to-sort sorted-list
      (rest new-indices)))))

#| Example:
(subset-translators-from-files
 '(((0 2) (4 0)) (0 6))
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "Oland (1 1) SIATEC" "txt" 3)
gives
((0 6) (1 5) (5 3)).

The function subset-translators-from-pairs is applied
to pairs contained in several files. Recall the aim is
to continue testing the first pair of each row of the
pairs for the `subsetness' of the first argument.
Where it is a subset, the translators should be
collected into a strictly-ascending union. |#

(defun subset-translators-from-files
       (pair pathname filename-prefix extension
	number-of-files &optional
	(first-pair (first pair))
	(translators (list (second pair)))
	(filename-counter 1)
	(filename
	 (if (<= filename-counter number-of-files)
	   (concatenate-filename
	    pathname filename-prefix
	    filename-counter extension)))
	(pairs
	 (read-from-file filename))
	(result
	 (subset-translators-from-pairs
	  first-pair pairs)))
  (if (null filename) (identity translators)
    (subset-translators-from-files
     pair pathname filename-prefix extension
     number-of-files first-pair
     (if result
       (union-multidimensional-sorted-asc
	translators result t)
       (identity translators))
     (+ filename-counter 1))))

#| Example:
(subset-translators-from-pairs
 '((2 2) (4 5))
 '((((2 2) (23 4)) ((6 2)))
   (((2 2) (10 14) (13 8) (23 4)) ((3 2) (2 3)))
   (((2 2) (4 5) (8 4)) ((21 2)))
   (((2 2) (4 5) (5 4)) ((11 6) (20 2) (8 12)))
   (((2 2) (7 7)) ((6 2) (3 2) (2 3) (21 2) (11 6)))))
gives
((8 12) (11 6) (21 2)).

The aim is to continue testing the first pair of each
row of the second argument for the `subsetness' of the
first argument. Where it is a subset, the translators
should be collected into a strictly-ascending
union. |#

(defun subset-translators-from-pairs
       (first-pair pairs &optional
	(m 0)
	(translators nil)
	(result
	 (assoc-subsets-multidimensional
	  first-pair pairs m)))
  (if (null result) (identity translators)
    (subset-translators-from-pairs
     first-pair pairs (+ (first result) 1)
     (union-multidimensional-sorted-asc
      translators (second (second result)) t))))

#| Example:
(test-translation-to-failure
 '((4 6) (6 5) (6 5) (6 7))
 '((0 1) (0 2) (1 3) (1 4) (4 6) (6 5) (6 7)
   (7 9) (7 10) (11 11) (14 1) (14 3) (14 14)))
gives
T.

This function takes three arguments: a pattern P, a
translator u and a dataset D. If the translation of
P by u is a subset of D then the outcome is T; NIL
otherwise. This function is called by an old
(incomplete) version of the function
translational-equivalence-class, but at present,
nothing else. |#

(defun test-translation-to-failure
       (pattern translator dataset)
  (if (null pattern) (identity T)
    (if (test-equal<list-elements
         dataset
         (add-two-lists
          (first pattern) translator))
      (test-translation-to-failure
       (rest pattern)
       translator dataset))))




