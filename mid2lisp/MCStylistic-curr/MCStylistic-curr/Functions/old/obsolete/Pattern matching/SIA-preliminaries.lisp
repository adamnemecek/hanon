#| Tom Collins
   Thursday 23 July 2009
   Incomplete

These functions support those in SIA-scaling. They
underpin the search for MTPs, TECs and MWTs. Reference
is `Algorithms for discovering repeated patterns in
multidimensional representations of polyphonic music',
by D. Meredith, K. Lemstrom and G.A. Wiggins, in
Journal of New Music Research 31(4) 2002, 321-345. |#

#| Example:
(add-two-lists '(4 7 -3) '(8 -2 -3))
gives
(12 5 -6).

Adds two lists element-by-element. It is assumed that
elements of list arguments are numbers, and the list
arguments are of the same length. An empty first (but
not second) argument will be tolerated. |#

(defun add-two-lists (a-list b-list)
  (if (null a-list) ()
    (cons (+ (first a-list) (first b-list))
          (add-two-lists (rest a-list)
                         (rest b-list)))))

#| Example:
(assoc-files
 '(2 -1)
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "difference set" "txt" 4)
gives
(3 ((2 -1) 8)).

The arguments to this function are a probe, a
pathname, a filename prefix, a file type and a
positive integer. The integer indicates how many
files there are in the directory of the pathname with
the specified filename prefix and file type. Each
one, assumed to contain an assoc-list, is read in
turn and probed for the presence of the argument in
probe. If it is present the relevant row is
returned. |#

(defun assoc-files
       (probe pathname filename-prefix extension
        number-of-files &optional
        (filename-counter 1)
        (filename
         (if (<= filename-counter number-of-files)
           (concatenate-filename
            pathname filename-prefix
            filename-counter extension)))
        (list-to-probe
         (read-from-file filename))
	(result
	 (assoc probe list-to-probe :test #'equalp)))
  (if (null filename) ()
    (if result
      (append (list filename-counter) (list result))
      (assoc-files
       probe pathname filename-prefix extension
       number-of-files (+ filename-counter 1)))))

#| Example:
(assoc-substitute
 '(1 -1) '((1 -1) ("u"))
 '(((3 2) ("y")) ((10 0) ("a")) ((4 -2) ("d"))
   ((1 -1) ("t")) ((8 9) ("g"))))
gives
(((3 2) ("y")) ((10 0) ("a")) ((4 -2) ("d"))
 ((1 -1) ("u")) ((8 9) ("g"))).

It appears that the built in functions substitute and
subst will not find and replace sublists of lists. This
function uses the function assoc to locate and replace
a particular row, so that it retains its particular
position within a list. |#

(defun assoc-substitute
       (assoc-lookup replacement a-list &optional
        (existence
         (assoc assoc-lookup a-list :test #'equalp))
        (length-a-list (length a-list))
        (replacement-index
         (index-item-1st-1st-occurs
          assoc-lookup a-list)))
  (if existence
    (append
     (firstn replacement-index a-list)
     (list replacement)
     (lastn (- length-a-list (+ replacement-index 1))
            a-list))
    (identity a-list)))

#| Example:
(assoc-translations
 '((3 3) (5 6) (6 5))
 '((((2 2) (23 4)) ((6 2)))
   (((2 2) (10 14) (13 8) (23 4)) ((3 2) (2 3)))
   (((2 2) (4 5) (5 4) (8 4)) ((21 2)))
   (((2 2) (4 5) (5 4)) ((11 6) (21 2) (8 12)))
   (((2 2)) ((6 2) (3 2) (2 3) (21 2) (11 6)))))
 0)
gives
(((2 2) (4 5) (5 4)) ((11 6) (21 2) (8 12))).

Two arguments are supplied to this function: a list of
(real) vectors of uniform dimension k and an assoc
list, the first of each pair again a list of vectors
of dimension k. When the first argument is a
translation of the first of a pair, the pair is
returned. Otherwise nil is returned. |#

(defun assoc-translations
       (a-list b-list &optional
	(length-a (length a-list))
	(first-b-list (first b-list)))
  (if (null first-b-list) ()
    (if (test-translation
	 a-list
	 (first first-b-list)
	 ;20/10/2010 line removed was: length-a
         )
      (identity first-b-list)
      (assoc-translations
       a-list (rest b-list) length-a))))

#| Example:
(assoc-translations-files
 '((3 3) (5 6) (6 5))
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "Faro (1 1)" "txt" 2)
gives
(2 (((2 2) (4 5) (5 4)) ((11 6) (21 2) (8 12)))).

The function assoc-translations is applied to pairs
contained in several files. Recall the aim: two
arguments are supplied to assoc-translations: a list
of (real) vectors of uniform dimension k and an assoc
list, the first of each pair again a list of vectors
of dimension k. When the first argument is a
translation of the first of a pair, the pair is
returned. Otherwise nil is returned. |#

(defun assoc-translations-files
       (probe pathname filename-prefix extension
	number-of-files &optional
	(length-probe (length probe))
	(filename-counter 1)
	(filename
	 (if (<= filename-counter number-of-files)
	   (concatenate-filename
	    pathname filename-prefix
	    filename-counter extension)))
	(list-to-probe
	 (read-from-file filename))
	(result
	 (assoc-translations
	  probe list-to-probe length-probe)))
  (if (null filename) ()
    (if result
      (list filename-counter result)
      (assoc-translations-files
       probe pathname filename-prefix extension
       number-of-files length-probe
       (+ filename-counter 1)))))

#| Example:
(concatenate-filename "//Users/tec69/Desktop/"
                      "difference set" 1 "txt")
gives
"//Users/tec69/Desktop/difference set 1.txt".

This function concatenates a pathname, filename
prefix and filename counter into an integral name
for a specified file type. |#

(defun concatenate-filename
       (pathname filename-prefix
        filename-counter extension)
  (concatenate
   'string
   pathname
   filename-prefix
   (format nil " ~D." filename-counter)
   extension))

#| Example:
(index-item-1st-1st-occurs
 1 '((3 ("y")) (10 ("a")) (4 ("d")) (1 ("t"))
     (8 ("g")))))
gives
3.

Taking a probe (or item) and a list of lists as its
arguments, this function returns the index at which the
probe first occurs as the first element of a list,
counting from zero. If the probe does not occur at all
then the function returns nil. |#

(defun index-item-1st-1st-occurs
       (item a-list &optional (index 0))
  (if (null a-list) ()
    (if (equalp (first (first a-list)) item)
      (identity index)
      (index-item-1st-1st-occurs
       item (rest a-list) (1+ index)))))

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
the list, then this list is output unchanged.) |#

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

#| Example:
(intersect-indices-in-files
 '(47 50) "Oland (1 1) SIA"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 50)
gives
((11/2 4)).

This function applies the function intersections-
multidimensional to the function read-first-nths-from-
files-modulo. So an intersection is taken over patterns
that reside in the locations indicated by the first
argument. |#

(defun intersect-indices-in-files
       (intersection-indices prefix
        pathname extension partition-size)
  (intersections-multidimensional
   (read-first-nths-from-files-modulo
    intersection-indices prefix
    pathname extension partition-size)))

#| Example:
(intersection-multidimensional
 '((4 8 8) (4 7 6) (5 -1 0) (2 0 0))
 '((4 6 7) (2 0 0) (4 7 6)))
gives
((4 7 6) (2 0 0)).

Like the built-in Lisp function intersection, this
function returns the intersection of two lists. Unlike
the built-in Lisp function, this function handles
lists of lists. |#

(defun intersection-multidimensional
       (a-list b-list)
  (if (null a-list) ()
    (append
     (if (test-equal<list-elements
          b-list
          (first a-list))
       (list (first a-list)))
     (intersection-multidimensional
      (rest a-list) b-list))))

#| Example:
(intersections-multidimensional
 '(((4 8 8) (4 7 6) (5 -1 0) (2 0 0))
   ((4 6 7) (2 0 0) (4 7 6))
   ((4 7 6) (2 1 0) (5 -1 0) (5 0 5))))
gives
((4 7 6)).

The single argument to this function consists of n
lists of lists (of varying length). Their
intersection is calculated and returned.
|#

(defun intersections-multidimensional
       (datasets &optional
        (is-nullity
         (null-list-of-lists datasets))
        (dataset (first datasets))
        (current-intersection dataset))
  (if (or (identity is-nullity)
          (null current-intersection)) ()
    (if (null dataset)
      (identity current-intersection)
      (intersections-multidimensional
       (rest datasets)
       is-nullity
       (second datasets)
       (intersection-multidimensional
        current-intersection
        dataset)))))

#| Example:
(list-elements '(49 67 (5 5)))
gives
((49) (67) ((5 5))).

This function wraps each element of a list in a further
list. |#

(defun list-elements (a-list)
  (if (null a-list) ()
    (append
     (list (list (first a-list)))
     (list-elements (rest a-list)))))

#| Example:
(multiply-list-by-constant '(2 0) 5)
gives
(10 0).

Two arguments are supplied to this function: a list
and a constant. A list is returned, containing the
result of multiplying each element of the list by the
constant. |#

(defun multiply-list-by-constant
       (a-list a-constant)
  (if (null a-list) ()
    (cons
     (* a-constant (first a-list))
     (multiply-list-by-constant
      (rest a-list) a-constant))))

#| Example:
(nth-list-index '(1 1 0 1 0))
gives
(0 1 3).

This function returns the value of the increment i if
the ith element of the input list is equal to 1. |#

(defun nth-list-index
       (indicator-vector
        &optional (i 0) (n (length indicator-vector)))
  (if (null indicator-vector) ()
    (if (equal (first indicator-vector) 1)
        (cons (identity i)
              (nth-list-index (rest indicator-vector)
                              (+ i 1)
                              n))
      (nth-list-index (rest indicator-vector)
                      (+ i 1)
                      n))))

#| Example:
(null-list-of-lists
 '(((4 8 8) (4 7 6) (5 -1 0) (2 0 0))
   ()
   ((4 7 6) (2 1 0) (5 -1 0) (5 0 5))))
gives
T.

The single argument to this function consists of n
lists of lists (of varying length). If any one of
these lists is empty then the value T is returned.
Otherwise the value NIL is returned. Note that a
null argument gives the output NIL.
|#

(defun null-list-of-lists
       (list-of-lists &optional
        (n (length list-of-lists))
        (i 0))
  (if (equal i n) ()
    (if (null (first list-of-lists))
      (identity t)
      (null-list-of-lists
       (rest list-of-lists)
       n (+ i 1)))))

#| Example:
(read-first-nth-from-file
 49
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/Oland (1 1) SIA 1.txt")
gives
((5 5)).

This function applies the function nth to the function
read-from-file, according to its arguments. |#

(defun read-first-nth-from-file
       (index filename)
  (first (nth index (read-from-file filename))))

#| Example:
(read-first-nths-from-files-modulo
 '(47 50) "Oland (1 1) SIA"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 50)
gives
(((5 5) (11/2 4))
 ((11/2 4))).

This function applies the function read-first-nth-from-
file to a list of indices (its first argument). These
indices are converted to a modulo b, where b is the
fifth argument. This is so that multiple files can be
read from within one call to the function. |#

(defun read-first-nths-from-files-modulo
       (indices prefix pathname
        extension partition-size &optional
        (index
         (if (not (null indices))
           (mod (first indices) partition-size)))
        (counter
         (if index
           (+
            (floor
             (/ (first indices) partition-size)) 1))))
  (if (null counter) ()
    (append
     (list
      (read-first-nth-from-file
       index
       (concatenate-filename
        pathname prefix
        counter extension)))
     (read-first-nths-from-files-modulo
      (rest indices) prefix
      pathname extension partition-size))))

#| Example:
(read-from-file "//Applications/CCL/Lisp documentation/Pattern matching/Example files/difference set 1.txt")
gives
(((0 1) 1) ((3 0) 2) ((3 -2) 3)).

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
(reflect-files
 "reflected SIA (1 0 1 0)"
 "prep for SIA (1 0 1 0)"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "txt" 4)
gives files in the specified location.

This function reflects (as in the function reflect-
list) lists contained in files specified by the
arguments. |#

(defun reflect-files
       (prefix-origin prefix-destination
        pathname-origin pathname-destination
        extension number-of-files &optional
        (filename-counter 1)
        (filename-origin
         (concatenate-filename
          pathname-origin prefix-origin
          filename-counter extension))
        (filename-destination
         (concatenate-filename
          pathname-destination prefix-destination
          filename-counter extension)))
  (if (> filename-counter number-of-files)
    (identity t)
    (progn
      (write-to-file
       (reflect-list
        (read-from-file filename-origin))
       filename-destination)
      (reflect-files
       prefix-origin prefix-destination
       pathname-origin pathname-destination
       extension number-of-files
       (+ filename-counter 1)))))

#| Example:
(reflect-list
 '(((1 1) ((1 1) (2 1) (3 1) (3 2)))
   ((1 0) ((1 1) (2 1) (2 2) (3 2)))
   ((2 0) ((1 1) (2 2)))))
gives
((((1 1) (2 1) (3 1) (3 2)) (1 1))
 (((1 1) (2 1) (2 2) (3 2)) (1 0))
 (((1 1) (2 2)) (2 0)))

This function has one argument: a list of lists.
Each list is reversed and forms the output. |#

(defun reflect-list (a-list)
  (if (null a-list) ()
    (append
     (list (reverse (first a-list)))
     (reflect-list (rest a-list)))))

#| Example:
(sort-dataset-asc
 '((1 1) (0 1) (4 4) (0 1) (1 1) (-2 3) (4 4) (4 3)))
gives
((-2 3) (0 1) (0 1) (1 1) (1 1) (4 3) (4 4) (4 4)).

This function takes one argument: a dataset. It sorts
the dataset ascending by each dimension in turn. By
the definition of `dataset', the dataset should not
contain repeated values. If it does these will be
removed. |#

(defun sort-dataset-asc (dataset)
  (union-multidimensional-sorted-asc
   nil dataset T))

#| Example:
(subset-multidimensional
 '((2 56) (6 60)) '((0 62) (2 56) (6 60) (6 72)))
gives
T.

This function returns T if and only if the first
argument is a subset of the second, and it is assumed
that the second list is sorted ascending. |#

(defun subset-multidimensional
       (a-list b-list)
  (if (null a-list) (identity t)
    (if (test-equal<list-elements
	 b-list (first a-list))
      (subset-multidimensional
       (rest a-list) b-list))))

#| Example:
(subtract-list-from-each-list
 '((8 -2 -3) (4 6 6) (0 0 0) (4 7 -3))
 '(4 7 -3))
gives
((4 -9 0) (0 -1 9) (-4 -7 3) (0 0 0)).

The function subtract-two-lists is applied
recursively to each sublist in the first list
argument, and the second argument. |#

(defun subtract-list-from-each-list (a-list b-list)
  (if (null a-list) ()
    (cons
     (subtract-two-lists (first a-list) b-list)
     (subtract-list-from-each-list
      (rest a-list) b-list))))

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
(test-equal<list-elements
 '((0 1) (0 2) (1 1) (3 1/4))
 '(1 1))
gives
T.

The first argument is a list of sublists, assumed to
be sorted ascending by each of its elements in turn.
We imagine it as a set of vectors (all members of the
same n-dimensional vector space). The second
argument v (another list) is also an n-dimensional
vector. If v1 is less than v2, the first element of
the first element of the first argument then NIL is
returned, since we know the list is sorted ascending.
Otherwise each item is checked for equality. This is
one of the most important functions in this section.
|#

(defun test-equal<list-elements
       (a-list a-vector &optional
        (i 0)
	(v1 (first a-vector))	
	(ith-a-list (nth i a-list))
	(v2 (if (null ith-a-list)
	      (identity v1)
	      (first (nth i a-list)))))
  (if (< v1 v2) ()
    (if (null ith-a-list) ()
      (if (equal a-vector ith-a-list)
	(identity T)
	(test-equal<list-elements
	 a-list a-vector (+ i 1) v1)))))

#| Example:
(test-translation
 '((2 2) (4 5)) '((11 6) (13 9)))
gives
T.

If the first argument to this function, a list,
consists of vectors of uniform dimension that are the
pairwise translation of vectors in another list (the
functions second argument), then T is returned, and
nil otherwise. (At present the function returns T if
two empty lists are provided as arguments.) |#

(defun test-translation
       (a-list b-list &optional
	(length-a (length a-list))
	(length-b (length b-list)))
  (if (equal length-a length-b)
    (if (<= length-a 1)
      (identity t)
      (test-translation-length>1
       a-list b-list length-a))))

#| Example:
(test-translation-length>1
 '((2 2) (4 5)) '((11 6) (13 9)))
gives
T.

This function is called in the event that two lists
of equal length l are supplied to the function
test-translation, and l > 1. It returns T if one list,
consisting of vectors of uniform dimension, is the
pairwise translation of the other list, and nil
otherwise. |#

(defun test-translation-length>1
       (a-list b-list &optional
	(their-length (length a-list))
	(m 0)
	(last-difference nil)
	(current-difference
	 (if (< m their-length)
	   (subtract-two-lists
	    (nth m a-list)
	    (nth m b-list)))))
  (if (null current-difference) (identity t)
    (if (or (null last-difference)
	    (equal current-difference
		   last-difference))
      (test-translation-length>1
       a-list b-list their-length
       (+ m 1) current-difference))))

#| Example:
(translators-of-pattern-in-dataset
 '((6 2) (7 1/2) (15/2 1/4) (31/4 1/4) (8 1) (9 1))
 '((0 1) (0 4/3) (0 2) (1 1) (4/3 1/3) (5/3 1/3)
   (2 1/2) (2 1) (5/2 1/2) (3 1/2) (3 2) (7/2 1/2)
   (4 1/2) (4 1) (9/2 1/2) (5 1) (6 1) (6 2)
   (7 1/2) (7 1) (15/2 1/4) (31/4 1/4) (8 1) (9 1)
   (9 2) (10 1/2) (10 1) (21/2 1/4) (43/4 1/4)
   (11 1) (12 1) (12 2) (13 1/2) (13 2) (27/2 1/4)
   (55/4 1/4) (14 1) (14 2) (15 1) (16 1/3) (16 2)
   (49/3 1/3) (50/3 1/3) (17 1)))
gives
((0 0) (3 0) (6 0)).

This function takes two arguments: a pattern P and a
dataset D. Typically P will be a non-empty subset of
D, and we are looking for the vectors v1, v2,..., vn
such that P translated by vi gives another subset of
D, i = 1, 2,.., n. |#

(defun translators-of-pattern-in-dataset
       (pattern dataset &optional
	(initial T) (last-intersection '())
	(datapoint (first pattern))
	(translators
	 (if (null datapoint) ()
	   (subtract-list-from-each-list
	    dataset datapoint)))
	(intersection-of-translators
	 (if (identity initial)
	   (identity translators)
	   (if (null translators)
	     (identity last-intersection)
	     (intersection-multidimensional
	      last-intersection translators)))))
  (if (null datapoint)
    (identity intersection-of-translators)
    (if (null intersection-of-translators) ()
      (translators-of-pattern-in-dataset
       (rest pattern) dataset NIL
       intersection-of-translators))))

#| Example:
(union-multidimensional-sorted-asc
 '((-5 0 4) (-4 3 1) (8 5 3) (8 6 0))
 '((-4 3 1) (-6 2 2) (8 5 0) (8 6 0))
 t)
gives
((-6 2 2) (-5 0 4) (-4 3 1) (8 5 0) (8 5 3) (8 6 0)).

Two lists of (real) vectors of the same dimension are
supplied to this function. If the first is sorted
strictly ascending already, a third argument of T
should be supplied to prevent it being sorted so. The
union of these lists is output and remains strictly
ascending. |#

(defun union-multidimensional-sorted-asc
       (a-list b-list &optional
	(is-a-list-sorted nil)
	(a-cup-b
	 (if is-a-list-sorted
	   (identity a-list)
	   (sort-dataset-asc a-list)))
	(first-b (first b-list)))
  (if (null first-b) (identity a-cup-b)
    (union-multidimensional-sorted-asc
     a-list (rest b-list) t
     (insert-retaining-sorted-asc
      first-b a-cup-b))))

#| Example:
(update-written-file
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "update" 1 "txt"
 '(6 60) '((2 2) ((2 72))))
gives
((0 7) ((0 60) (2 63)))
((2 2) ((2 72) (6 60)))
((3 -1) ((0 60) (3 67)))
((6 0) ((3 67) (5 66)))
whereas originally file read
((0 7) ((0 60) (2 63)))
((2 2) ((2 72)))
((3 -1) ((0 60) (3 67)))
((6 0) ((3 67) (5 66))).

This function updates the contents of a specifed
file by removing the row associated with the
variable updatee, and replacing it with updater
appended within updatee. It should overwrite the
existing file. The position of the row is
preserved. |#

(defun update-written-file
       (pathname filename-prefix filename-counter
	extension updater updatee &optional
        (length-provided nil)
	(filename
	 (concatenate-filename
	  pathname filename-prefix
	  filename-counter extension))
	(list-to-update
	 (read-from-file filename))
        (length-a-list
         (if length-provided
           (identity length-provided)
           (length list-to-update)))
        (replacement-index
         (index-item-1st-occurs
          updatee list-to-update))
	(list-updated
	 (append
          (firstn replacement-index list-to-update)
	  (list (list (first updatee)
                      (insert-retaining-sorted-asc
		       updater
                       (second updatee))))
	  (lastn (- length-a-list
                    (+ replacement-index 1))
                 list-to-update))))
  (write-to-file list-updated filename))

#| Example:
(update-written-file-row
 "//Applications/CCL/Lisp documentation/Pattern matching/Example files/"
 "update" 1 "txt"
 '((2 2) ((2 72) (6 60))) '((2 2) ((2 72))))
gives
((0 7) ((0 60) (2 63)))
((2 2) ((2 72) (6 60)))
((3 -1) ((0 60) (3 67)))
((6 0) ((3 67) (5 66)))
whereas originally file read
((0 7) ((0 60) (2 63)))
((2 2) ((2 72)))
((3 -1) ((0 60) (3 67)))
((6 0) ((3 67) (5 66))).

This function updates the contents of a specifed file
by removing the row associated with the variable
updatee, and replacing it with updater. It should
overwrite the existing file. The position of the row is
preserved. |#

(defun update-written-file-row
       (pathname prefix counter extension
	updater updatee &optional
        (length-provided nil)
	(filename
	 (concatenate-filename
	  pathname prefix
	  counter extension))
	(list-to-update
	 (read-from-file filename))
        (length-a-list
         (if length-provided
           (identity length-provided)
           (length list-to-update)))
        (replacement-index
         (index-item-1st-occurs
          updatee list-to-update))
	(list-updated
	 (append
          (firstn replacement-index list-to-update)
	  (list updater)
	  (lastn (- length-a-list
                    (+ replacement-index 1))
                 list-to-update))))
  (write-to-file list-updated filename))

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
equal, and nil otherwise. |#

(defun vector<vector (a-vector b-vector)
  (if (null a-vector) (identity "equal")
    (if (< (first a-vector) (first b-vector))
      (identity t)
      (if (equal (first a-vector) (first b-vector))
	(vector<vector
	 (rest a-vector) (rest b-vector))))))
