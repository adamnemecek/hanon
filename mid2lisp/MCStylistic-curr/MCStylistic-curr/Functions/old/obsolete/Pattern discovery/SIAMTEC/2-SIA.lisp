#| Tom Collins
   Tuesday 1 December 2009
   Incomplete

The functions below are an implementation of SIA
(Structural inference algorithm, Meredith 2002). |#

#| These opening examples are for small sets, to
demonstrate the functions rassoc and time.

(in-package :common-lisp-user)
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load
 "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")

(setq
 alist
 '(((2 0 0) . ((0 60 2) (1 61 1)))
   ((4 12 0) . ((0 60 2) (3 59 1)))))

(rassoc '((4 72 2) (7 71 1))
        alist :test #'test-translation)

(rassoc '((4 72 2) (7 71 1))
        alist
        :test #'test-translation-no-length-check)

(time (rassoc '((4 72 2) (7 71 1))
              alist :test #'test-translation))
(time
 (rassoc '((4 72 2) (7 71 1))
	 alist
	 :test #'test-translation-no-length-check))
|#

#| Example:
(assoc-files
 '(0 3)
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/difference set") 4)
gives
(3 ((0 3) 9)).

The arguments to this function are a probe, a
path&name, and a positive integer. The integer
indicates how many files there are with the specified
path&name. Each one, assumed to contain an assoc-list,
is read in turn and probed for the presence of the
argument in probe. If it is present the relevant row
is returned. |#

(defun assoc-files
       (probe path&name number-of-files &optional
        (filename-counter 1)
        (filename
         (if (<= filename-counter number-of-files)
           (concatenate
            'string
            path&name " "
            (write-to-string filename-counter)
	    ".txt")))
        (list-to-probe
         (read-from-file filename))
	(result
	 (assoc probe list-to-probe :test #'equalp)))
  (if (null filename) ()
    (if result
      (append (list filename-counter) (list result))
      (assoc-files
       probe path&name number-of-files
       (+ filename-counter 1)))))

#| Example:
(insert-retaining-sorted-asc
 '(5 0) '((-6 2) (-4 1) (8 0)))
gives
((-6 2) (-4 1) (5 0) (8 0)).

Two arguments are supplied to this function: a (real)
vector and a strictly-ascending list of (real)
vectors (of the same dimension). The first argument
is included in the second and output, so that it
remains a strictly-ascending list of vectors. (Note
this means that if the first argument is already in
the list, then this list is output unchanged.)

(defun insert-retaining-sorted-asc
       (insert a-list &optional
	(front-list nil)
	(insert-state
	 (if (null a-list)
	   (identity "maximal-element")
	   (vector<vector
	    insert (first a-list)))))
  (if insert-state
    (append
     front-list
     (if (not (equalp insert-state "equal"))
       (list insert))
     a-list)
    (insert-retaining-sorted-asc
     insert (rest a-list)
     (append front-list (list (first a-list))))))

1/12/09 Not required yet |#

#| Example:
(read-from-file
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/a-list.txt"))
gives
(((2 0 0) (0 60 2) (1 61 1))
 ((4 12 0) (0 60 2) (3 59 1))).

This function returns the contents of a file
specified by the variable path&name. It returns 
each row of the file as a list, in a list of
lists. |#

(defun read-from-file (path&name)
  (if (null path&name)
    ()
    ;;(print "Empty path and file provided.")
    (with-open-file (stream path&name)
      (loop for row = (read-line stream nil)
        while row do (setf
                      row
                      (read-from-string row nil))
        when row collect row into results
        finally (return results)))))

#| Example:
(reflected-SIA-scaling
 '((0 61) (0 65) (1 64) (4 62) (4 66) (5 65) (8 60)
   (8 64) (9 63) (12 56) (13 69) (15 65) (16 57)
   (16 59) (17 64) (19 63))
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1) prep")
 50)
gives files in the specified location.

This function calculates the reduced difference set
for the projected dataset, assumed to be ordered
ascending. The projection indicator is a required
argument so as to distinguish the text files thus
created, according to the partition size, which must
also be specified. A byproduct of this process is the
calculation of maximal translatable patterns. |#

(defun reflected-SIA-scaling
       (dataset path&name partition-size &optional
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
	    probe path&name (- filename-counter 1))
	   (identity result-recent))))
  (if (null dataset)
    (progn
      (write-to-file
       growing-list
       (concatenate
        'string
        path&name " "
        (write-to-string filename-counter) ".txt"))
      (identity filename-counter))
    (if (null probe)
      (reflected-SIA-scaling
       (rest dataset) path&name partition-size
       filename-counter growing-list j)
      (if (equal j partition-size)
	(progn
	  (write-to-file
	   growing-list
	   (concatenate
            'string
	    path&name " "
            (write-to-string filename-counter)
	    ".txt"))
	  (reflected-SIA-scaling
	   dataset path&name partition-size
           (+ filename-counter 1) nil
	   0 first-dataset rest-dataset
	   probe nil)) #| 25/11/09 Remains changed
from ...probe result-recent result. This was because
if v was found recently as the partition-size was
reached, growing-list would be written to file and the
recent result would no longer hold. Therefore the
result-recent is certainly null and result must be
recalculated. |#
	(if result-recent
	  (reflected-SIA-scaling
	   dataset path&name partition-size
           filename-counter
#| Attempt to improve use of remove. 9/12/09|#
           (progn
             (rplacd
              (assoc probe
                     growing-list
                     :test #'equalp)
              (append
               (cdr result-recent)
               (list first-dataset)))
             (identity growing-list))
#|
	   (append
            (list
	     (cons
	      (first result-recent)
	      (append (cdr result-recent)
		      (list first-dataset))))
	    (remove result-recent
		    growing-list :test #'equalp))
|#
	   j first-dataset (rest rest-dataset))
	  (if result
	    (progn
	      (update-written-file
	       path&name (first result) first-dataset
               (second result))
	      (reflected-SIA-scaling
	       dataset path&name partition-size
               filename-counter growing-list
	       j first-dataset (rest rest-dataset)))
	    (reflected-SIA-scaling
	     dataset path&name partition-size
             filename-counter
#| With use of rplacd above, forward loading seems
most efficient. 9/12/09|#
	     (append
              (list
	       (cons probe
		     (list first-dataset)))
	      growing-list
	      )
	     (+ j 1) first-dataset
	     (rest rest-dataset))))))))

#| Example:
(subtract-two-lists '(4 7 -3) '(8 -2 -3))
gives
(-4 9 0).

Subtracts the second list from the first, element-
by-element. It is assumed that elements of list
arguments are numbers, and the list arguments are
of the same length. An empty first (but not second)
argument will be tolerated. |#

(defun subtract-two-lists (a-list b-list)
  (if (null a-list) ()
    (cons (- (first a-list) (first b-list))
          (subtract-two-lists (rest a-list)
                              (rest b-list)))))

#| Example:
(test-translation-no-length-check
 '((2 2) (4 5)) '((11 6) (13 9)))
gives
T.

If the first argument to this function, a list,
consists of vectors of uniform dimension that are the
pairwise translation of vectors in another list (the
function's second argument), then T is returned, and
nil otherwise. The length of the vectors is not
checked for equality. (At present the function
returns T if two empty lists are provided as
arguments.) |#

(defun test-translation-no-length-check
       (a-list b-list &optional
	(last-difference nil)
	(current-difference
	 (if (and a-list b-list)
	   (subtract-two-lists
	    (first a-list)
	    (first b-list)))))
  (if (null current-difference) (identity t)
    (if (or (null last-difference)
	    (equal current-difference
		   last-difference))
      (test-translation-no-length-check
       (rest a-list) (rest b-list)
       current-difference))))

#| Example:
(update-written-file
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/update")
 1 '(6 60) '((2 2) . ((2 72))))
gives
((0 7) . ((0 60) (2 63)))
((2 2) . ((2 72) (6 60)))
((3 -1) . ((0 60) (3 67)))
((6 0) . ((3 67) (5 66)))
whereas originally file read
((0 7) . ((0 60) (2 63)))
((2 2) . ((2 72)))
((3 -1) . ((0 60) (3 67)))
((6 0) . ((3 67) (5 66))).

This function updates the contents of a specifed file
by removing the row associated with the variable
updatee, and replacing it with updater appended within
updatee. It should overwrite the existing file.
The position of the row is preserved. |#

(defun update-written-file
       (path&name filename-counter updater updatee
        &optional
        (list-to-update
	 (read-from-file
          (concatenate
           'string
           path&name " "
           (write-to-string filename-counter)
           ".txt"))))
  (progn
    (rplacd (assoc (car updatee) list-to-update
                   :test #'equalp)
            (append
	     (cdr updatee) (list updater)))
    (write-to-file
     list-to-update
     (concatenate
      'string
      path&name " "
      (write-to-string filename-counter)
      ".txt"))))

#| Example:
(vector<vector '(4 6 7) '(4 6 7.1))
gives
T.

For d = (d1, d2,..., dk), e = (e1, e2,..., ek), we say
that d is less than e, denoted d < e, if and only if
there exists an integer 1 <= j <= k such that
dj < ej, and di = ei for 1<= i < j. This function
returns true if its first argument is `less than' its
second argument, "equal" if the two arguments are
equal, and nil otherwise.

(defun vector<vector (a-vector b-vector)
  (if (null a-vector) (identity "equal")
    (if (< (first a-vector) (first b-vector))
      (identity t)
      (if (equal (first a-vector) (first b-vector))
	(vector<vector
	 (rest a-vector) (rest b-vector))))))

1/12/09 Not required yet |#

#| Example:
(write-to-file '(5 7 8 "hello" 9)
               "//Users/tec69/Desktop/test.txt")
gives
(have a look at the desktop).

This function writes the data provided in the first list
to a file with the path and name provided in the second
list. The s in the format argument is essential for
retaining strings as they appear in the data. |#

(defun write-to-file
       (variable path&name
        &optional
        (file (open path&name
                    :direction
                    :output
                    :if-does-not-exist
                    :create
                    :if-exists
                    :overwrite)))
  (if (null variable) (close file)
    (progn (format file
                   "~s~%" (first variable))
      (write-to-file (rest variable)
                     path&name
                     file))))

