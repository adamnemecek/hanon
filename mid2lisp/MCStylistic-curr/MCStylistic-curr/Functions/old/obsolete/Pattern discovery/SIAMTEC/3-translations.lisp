#| Tom Collins
   Tuesday 1 December 2009
   Incomplete

The functions below act on a list consisting of vector-
MTP pairs (output of stage 2). They aim to remove the
MTPs that have pre-existing translations (including the
zero translation). |#

#| These opening examples are for small sets, to
demonstrate the functions rassoc and time.

(setq
 b-list
 '((((0 60 2) (1 61 1)))
   (((0 60 2) (3 59 1)))))

(assoc '((4 72 2) (7 71 1))
       b-list :test #'test-translation)

(rassoc '((4 72 2) (7 71 1))
        a-list
        :test #'test-translation-no-length-check)

(time (rassoc '((4 72 2) (7 71 1))
              a-list :test #'test-translation))
(time
 (rassoc '((4 72 2) (7 71 1))
	 a-list
	 :test #'test-translation-no-length-check))
|#

#| Example:
(assoc-translations
 '((1 66) (5 67))
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " translations") 2)
gives
(1 (((0 65) (4 66)))).

The arguments to this function are a probe, a
path&name, and a positive integer. The integer
indicates how many files there are with the specified
path&name. Each one, assumed to contain an assoc-list,
is read in turn and its car probed for the presence of
the argument in probe. If it is present the relevant
row is returned. |#

(defun assoc-translations
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
	 (assoc
          probe
          list-to-probe
          :test #'test-translation)))
  (if (null filename) ()
    (if result
      (append (list filename-counter) (list result))
      (assoc-translations
       probe path&name number-of-files
       (+ filename-counter 1)))))

#| Example:
(prepare-for-R
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)") 2)
gives files in the specified location.

The arguments to this function are a filename prefix
and a number, indicating the number of files with this
prefix. First the patterns are separated and turned
into comma-separated n-tuples. Then the lengths of
these patterns are recorded. This function is dedicated
to converting files for R. |#

(defun prepare-for-R (origin number-of-files)
  (loop for counter from 1 to number-of-files do
    (progn
      (unseparate-patterns-in-file
       (concatenate
        'string
        origin " translations "
        (write-to-string counter) ".txt")
       (concatenate
        'string
        origin " unseparated "
        (write-to-string counter) ".txt"))
      (write-to-file-n-tuples
       (concatenate
        'string
        origin " unseparated "
        (write-to-string counter) ".txt")
       (concatenate
        'string
        origin " commas "
        (write-to-string counter) ".txt"))
      (write-to-file-pattern-lengths
       (concatenate
        'string
        origin " translations "
        (write-to-string counter) ".txt")
       (concatenate
        'string
        origin " lengths "
        (write-to-string counter) ".txt")))))

#| Example:
(rassoc-translations
 '((4 66) (8 64))
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1) prep") 2)
gives
(1 ((11 3) (4 62) (8 60))).

The arguments to this function are a probe, a
path&name, and a positive integer. The integer
indicates how many files there are with the specified
path&name. Each one, assumed to contain an assoc-list,
is read in turn and its cdr probed for the presence of
the argument in probe. If it is present the relevant
row is returned.

(defun rassoc-translations
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
	 (rassoc
          probe
          list-to-probe
          :test #'test-translation)))
  (if (null filename) ()
    (if result
      (append (list filename-counter) (list result))
      (rassoc-translations
       probe path&name number-of-files
       (+ filename-counter 1)))))

1/12/2009. NB Might not need this file at all now, as
we are using the SIA output as probes. |#

#| Example:
(remove-translations-cdr
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1) SIA")
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " translations")
 50 5 2)
gives files in the specified location.

This function acts on the output of SIA, that is on
vector-MTP pairs. It takes each MTP, a pattern, and
determines whether a translation of this pattern has
already been included in a growing list. If it has then
this pattern is overlooked, and if not it is added. (We
lose the vector part of the vector-MTP pair at this
stage.) |#

(defun remove-translations-cdr
       (origin destination partition-origin
        partition-destination number-of-files
        &optional (counter-origin 1)
        (counter-destination 1)
        (growing-list nil) (j 0)
        (vector-MTP-pairs
         (if (<= counter-origin number-of-files)
           (read-from-file
            (concatenate
             'string
             origin " "
             (write-to-string counter-origin)
             ".txt"))))
        (pattern (cdr (first vector-MTP-pairs)))
        (result-recent
         (assoc pattern growing-list
                :test #'test-translation))
        (result
         (if (and (> counter-destination 1)
                  (null result-recent))
           (assoc-translations
            pattern destination
            (- counter-destination 1))
           (identity result-recent))))
  (if (> counter-origin number-of-files)
    (if (null growing-list) (identity t)
      (write-to-file
       growing-list
       (concatenate
        'string
        destination " "
        (write-to-string counter-destination)
        ".txt")))
    (if (null pattern)
      (remove-translations-cdr
       origin destination partition-origin
       partition-destination number-of-files
       (+ counter-origin 1) counter-destination
       growing-list j)
      (if (equal j partition-destination)
        (progn
          (write-to-file
           growing-list
           (concatenate
            'string
            destination " "
            (write-to-string counter-destination)
            ".txt"))
          (remove-translations-cdr
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin (+ counter-destination 1)
           nil 0 vector-MTP-pairs pattern nil))
        (if result
          (remove-translations-cdr
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin counter-destination
           growing-list j (rest vector-MTP-pairs))
          (remove-translations-cdr
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin counter-destination
           (append
            growing-list
            (list (list pattern))
            )
           (+ j 1) (rest vector-MTP-pairs))
          )
        )
      )
    ))

#| Example:
(test-translation
 '((2 2) (4 5)) '((11 6) (13 9)))
gives
T.

If the first argument to this function, a list,
consists of vectors of uniform dimension that are the
pairwise translation of vectors in another list (the
functions second argument), then T is returned, and
nil otherwise. The length of the vectors is checked
first for equality, then passed to the function
test-translation-no-length-check if equal.

1/12/2009. NB There is an inefficiency in length
checking when using assoc/rassoc, as the length of the
probe has to be recalculated for each check. |#

(defun test-translation (a-list b-list)
  (if (equal (length a-list) (length b-list))
    (test-translation-no-length-check
     a-list b-list)))

#| Example:
(unseparate-patterns-in-file
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " translations 1.txt")
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " unseparated 1.txt"))
gives
T.

The file contains five patterns in an extra deep list:

(((0 61)))
(((0 65) (8 64)))
(((0 65) (4 66)))
(((0 61) (0 65) (1 64) (12 56)))
(((0 61) (0 65) (1 64) (8 60))).

What we wish to do is unseparate these patterns so
that they appear as one long list, which is written to
the specified file. |#

(defun unseparate-patterns-in-file
       (origin destination &optional
	(patterns
	 (read-from-file origin))
	(unseparated-patterns nil))
  (if (null patterns)
    (write-to-file
     unseparated-patterns destination)
    (unseparate-patterns-in-file
     origin destination
     (rest patterns)
     (append
      unseparated-patterns
      (first (first patterns))))))

#| Example:
(setq file
      (open
       (concatenate
        'string
        "//Applications/CCL/Lisp documentation/Pattern"
        " discovery/Example files/open-file.txt")
       :direction
       :output
       :if-does-not-exist
       :create
       :if-exists
       :overwrite))
(write-to-file-n-tuple '(7/8 6 12 -2 -3/5) file)
(close file)
gives
0.875, 6.0, 12.0 -2.0, -0.6
in the specified location.

The aim is to write an n-tuple to an already open
file. |#

(defun write-to-file-n-tuple (n-tuple file)
  (if (equal (length n-tuple) 1)
    (format file "~s~%" (float (first n-tuple)))
    (progn
      (format file "~s, " (float (first n-tuple)))
      (write-to-file-n-tuple
       (rest n-tuple) file))))

#| Example:
(write-to-file-n-tuples
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " unseparated 1.txt")
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " commas 1.txt"))
gives the file in the specified location.

The aim is to take the separated patterns and reformat
them as comma-separated rows of a text file. |#

(defun write-to-file-n-tuples
       (filename-origin filename-destination &optional
	(n-tuples
	 (read-from-file filename-origin))
	(file
	 (open filename-destination
	       :direction
	       :output
	       :if-does-not-exist
	       :create
	       :if-exists
	       :overwrite)))
  (if (null n-tuples) (close file)
    (progn
      (write-to-file-n-tuple (first n-tuples) file)
      (write-to-file-n-tuples
       filename-origin filename-destination
       (rest n-tuples) file))))

#| Example:
(write-to-file-pattern-lengths
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " translations 1.txt")
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " lengths 1.txt"))
gives the file in the specified location.

Lengths of patterns are written to a file. |#

(defun write-to-file-pattern-lengths
       (origin destination &optional
	(patterns (read-from-file origin))
	(lengths nil))
  (if (null patterns)
    (write-to-file lengths destination)
    (write-to-file-pattern-lengths
     origin destination (rest patterns)
     (append
      lengths
      (list (length (first (first patterns))))))))
