#| Tom Collins
   Tuesday 21 April 2009
   Incomplete Friday 23 April 2009

The aim of these functions is to adapt one of the
key ideas from a paper entitled `Feature set patterns
in music', by M. Bergeron and D. Conklin, in Computer
Music Journal 32(1) 2008, 60-70. It is the idea of
pattern interest, and the aim here is to adapt it to
polyphonic music.

We assume the functions in sort-by, choose, chords,
markov-compose, maximal-translatable-pattern, and
translational-equivalence-class have been loaded.
Below is an example of the functions at work on an
extract by Chopin.

(in-package :common-lisp-user)

(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/markov-compose.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/maximal-translatable-pattern.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/translational-equivalence-class.lisp")

(progn
  (setq *dataset*
        (firstn
         200
         (load-midi-file "/Users/tec69/Open/Music/MIDI/Chopin, Frederic/Simple kern/Mazurka in B-flat Major, Op 17 No 1.mid")))
  (print "Dataset loaded"))

(progn
  (setq *composers-palette*
        (orthogonal-projection-not-unique-equalp
         *dataset*
         '(0 1 1 0 0)))
  (print "Palette computed"))

(defvar *empirical-mass* '())

(empirical-mass *composers-palette*)

(setq *S*
      (maximal-translatable-pattern
       '(3 0 0)
       (orthogonal-projection-not-unique-equalp
         *dataset*
         '(1 1 1 0 0))))

(setq *T*
      (translational-equivalence-class
       *S*
       (orthogonal-projection-not-unique-equalp
         *dataset*
         '(1 1 1 0 0))))

(likelihood-of-pattern *S* *empirical-mass*)
|#

(defvar *empirical-mass* '())

#| Example:
(accumulate-to-mass
 '(6 72) '((6 72) 1/4)
 '(((6 72) 1/4) ((4 0.1) 1/2)) 1/4)
gives
(((6 72) 1/2) ((4 0.1) 1/2)).

This function takes four arguments: a datapoint d;
an element (to be updated) of the emerging empirical
probability mass function p; p itself is the third
argument; and the fourth argument is $\mu$, the
reciprocal of the number of datapoints which have
been observed. This function has been called because
d d is new to the empirical mass---it is added with
mass $\mu$. |#

(defun accumulate-to-mass
       (datapoint relevant-element
        mass reciprocal-length)
  (cons (list datapoint
              (+ (second relevant-element)
                 reciprocal-length))
        (remove relevant-element
                mass
                :test #'equalp)))

#| Example:
(add-to-mass '(6 72) '(((4 0.1) 2/3)) 1/3)
gives
(((6 72) 1/3) ((4 0.1) 2/3)).

This function takes three arguments: a datapoint d;
an emerging empirical probability mass function p;
and the third argument is $\mu$, the reciprocal of
the number of datapoints which have been observed.
This function has been called because d already forms
part $\lambda$ of the mass. This element is increased
to $\lambda + \mu$. |#

(defun add-to-mass
       (datapoint mass reciprocal-length)
  (cons (list datapoint reciprocal-length)
        mass))

#| Example:
(empirical-mass '((4 0) (4 0) (0 4)) '())
gives "It's done!": typing '*empirical-mass*' gives
(((0 4) 1/3) ((4 0) 2/3)).

This function writes the empirical probability mass
function p for a dataset D to the global variable
*empirical-mass*. |#

(defun empirical-mass
       (dataset &optional (mass *empirical-mass*)
        (reciprocal-length (/ 1 (length dataset))))
  (if (null dataset)
    (setq *empirical-mass* mass)
    ;; used to have progn above with
    ;; (print "It's done!") to suppress output.
    (empirical-mass (rest dataset)
                    (present-to-mass
                     (first dataset)
                     mass
                     reciprocal-length)
                    reciprocal-length)))

#| Example:
(index-point-in-dataset
 '(4 7)
 '((8 2 -3) (8 -2 -3) (8 4 7) (4 -2 7) (8 -2 -3))
 '(1 0 1))
gives
3.

A projected point, dataset and projection indicator
are provided as arguments. Each datapoint in the
dataset is projected in turn (according to the
projection indicator), and tested for equality with
the projected point. If it is found, the index of
the datapoint is returned, counting from zero.
Otherwise nil is returned. This function could have
been written using the function
index-item-1st-occurs. But this requires
projecting the entire dataset first, or that the
projected dataset already exists. |#

(defun index-point-in-dataset
       (point dataset projection-indicator
        &optional
        (projection-index
         (nth-list-index projection-indicator))
        (i 0))
  (if (null dataset) ()
    (if (equalp point
                (nth-list
                 projection-index
                 (first dataset)))
      (identity i)
      (index-point-in-dataset
       point (rest dataset) projection-indicator
       projection-index (+ i 1)))))

#| Example:
(likelihood-of-2nds-of-pairs
 '((3 62) (4 60) (5 63))
 '((64 1/9) (65 1/9) (58 1/9) (66 1/9) (60 2/9)
   (62 2/9) (63 1/9)))
gives
4/729.

A list of pairs is the first argument to this
function. We think of the second element of each pair
as a MIDI note number or a morphetic pitch number.
The second argument to this function is an empirical
mass function for some MIDI or morphetic numbers. The
function returns the likelihood of the list of pairs,
in terms of a product of the corresponding
probabilities in the empirical mass function. |#

(defun likelihood-of-2nds-of-pairs
       (pairs relevant-mass &optional
        (n (length pairs)) (i 0)
        (probabilities '())
        (probability
         (if (not (equal i n))
           (probability-of-2nd-of-pair
            (first pairs) relevant-mass))))
  (if (equal probability 0) (identity 0)
    (if (equal i n) (multiply-list probabilities)
      (likelihood-of-2nds-of-pairs
       (rest pairs) relevant-mass n (+ i 1)
       (cons probability probabilities)))))

#| Example:
(likelihood-of-projected-pattern
 '((0 62) (1 60) (2 63))
 '((0 62 61 1) (1 60 60 1) (2 63 62 4) (6 62 61 1)
   (7 60 60 1) (8 63 62 4) (10 58 59 2)
   (13 65 63 1) (13 60 62 1) (17 66 63 1))
 '(1 1 0 0))
gives
7/500.

A list of pairs is the first argument to this
function, called a projected pattern S. The next
argument is an unprojected dataset D from which S
hails. The third argument is an indicator vector,
containing the projection which was used to find
S. We think of the second element of each
pair of S as a MIDI note number or a morphetic
pitch number. The optional arguments to this
function might well be made explicit, to avoid
recalculation of the empirical mass function,
for example. The function finds all permissible
transpositions of S that can occur, given the
`composer's palette' that arises from D, and
calculates the likelihood of the projected pattern. |#

(defun likelihood-of-projected-pattern
       (projected-pattern dataset
        indicator-vector &optional
        (relevant-pairs
         (orthogonal-projection-not-unique-equalp
          dataset indicator-vector))
        (relevant-data
         (nth-list-of-lists 1 relevant-pairs))
        (relevant-mass
         (progn
           (empirical-mass relevant-data '())
           (identity *empirical-mass*)))
        (minimum-element
         (min-item relevant-data))
        (maximum-element
         (max-item relevant-data))
        (permissible-pairs-transposed
         (permissible-pairs-transpositions
          projected-pattern
          relevant-pairs 1
          minimum-element maximum-element))
        (likelihoods '())
        (likelihood
         (likelihood-of-2nds-of-pairs
          (first permissible-pairs-transposed)
          relevant-mass)))
  (if (null permissible-pairs-transposed)
    (my-last (fibonacci-list likelihoods))
    (likelihood-of-projected-pattern
     projected-pattern dataset indicator-vector
     relevant-pairs relevant-data relevant-mass
     minimum-element maximum-element
     (rest permissible-pairs-transposed)
     (cons likelihood likelihoods))))

#| Example:
(multiply-list '(4 6 0 5 2))
gives
0.

The one argument to this function is a list (presumed
to be complex numbers. A product is taken over all
elements of the list and the answer is returned, with
the convention that a product over an empty set is
equal to 1. The function searches the list for zero
elements first, to avoid calculating a long product
which is destined to be zero. |#

(defun multiply-list
       (a-list &optional
        (n (length a-list))
        (zero-indicator
         (index-item-1st-occurs 0 a-list))
        (i (if zero-indicator (identity n)
           (identity 1)))
        (current-product
         (if zero-indicator (identity 0)
           (first a-list))))
  (if (null current-product) (identity 1)
    (if (equal i n)
      (identity current-product)
      (multiply-list
       (rest a-list) n zero-indicator (+ i 1)
       (* (second a-list) current-product)))))

#| Example:
(nth-recursive
 '(2 3 1)
 '(4 6 (0 0 1 (4 "here")) 5 2))
gives
"here".

Suppose that an element of a list is `hidden' in the
nth element of the mth element of the lth element of
the $\ldots$ of the ith element. This function takes
an argument of the kind $(i\ j\ \ldots \l \m \n)$
and applies the function nth recursively to a second
argument (the list of interest), returning the
`hidden' element. |#

(defun nth-recursive
       (a-list b-list &optional
	(n (length a-list)) (i 0))
  (if (equal n 0) (identity b-list)
    (if (equal i n) (identity b-list)
      (nth-recursive
       (rest a-list)
       (nth (first a-list) b-list)
       n (+ i 1)))))

#| Example:
(pattern-interest-polyphonic
 '((0 62) (1 60) (2 63))
 '((0 62 61 1) (1 60 60 1) (1 62 61 1) (2 63 62 4)
   (6 62 61 1) (7 60 60 1) (8 63 62 4) (10 58 59 2)
   (13 65 63 1) (13 60 62 1) (17 66 63 1))
 '(1 1 0 0))
gives
36.3.

This function takes three mandatory arguments: a
projected pattern S, the dataset D from which S
hails, and a vector that indicates the projection
of D under which S was found. The function
represents an attempt to adapt the definition of
pattern interest to polyphonic music (see
introduction to these functions). Put simply,
pattern interest is the ratio of the number of
instances of the pattern, to the expected number
of instances, with context taken into account
Working out the expected number of instances in a
polyphonic dataset is the least obvious aspect of this
definition.

There are a large number of optional arguments that may
have been computed already in various scenarios, so it
would be inefficient to have them computed again. |#

(defun pattern-interest-polyphonic
       (projected-pattern dataset
        indicator-vector &optional
        (N (length dataset))
        (sorted-dataset
	 (sort-dataset-asc dataset))
        (projected-dataset
         (orthogonal-projection-unique-equalp
          sorted-dataset indicator-vector))
        (size-of-translational-equivalence-class
         (length
          (translators-of-pattern-in-dataset
           projected-pattern projected-dataset)))
        (relevant-pairs
         (orthogonal-projection-not-unique-equalp
          dataset indicator-vector))
        (relevant-data
         (nth-list-of-lists 1 relevant-pairs))
        (relevant-mass
         (progn
           (empirical-mass relevant-data '())
           (identity *empirical-mass*)))
        (minimum-element
         (min-item relevant-data))
        (maximum-element
         (max-item relevant-data))
        (likelihood
         (likelihood-of-projected-pattern
          projected-pattern dataset
          indicator-vector relevant-pairs
          relevant-data relevant-mass
          minimum-element maximum-element))
        (expected-value
         (/ (* N likelihood)
            (length projected-pattern)))
        (shadow-pattern-in-dataset
         (pattern-shadow
          projected-pattern dataset indicator-vector)))
  (float (/
	  (* shadow-pattern-in-dataset
	     size-of-translational-equivalence-class)
	  expected-value)))

#| Example:
(pattern-interest-polyphonic-no-shadow
 '((0 62) (1 60) (2 63))
 '((0 62 61 1) (1 60 60 1) (1 62 61 1) (2 63 62 4)
   (6 62 61 1) (7 60 60 1) (8 63 62 4) (10 58 59 2)
   (13 65 63 1) (13 60 62 1) (17 66 63 1))
 '(1 1 0 0))
gives
36.3.

This function takes three mandatory arguments: a
projected pattern S, the dataset D from which S
hails, and a vector that indicates the projection
of D under which S was found. The function
represents an attempt to adapt the definition of
pattern interest to polyphonic music (see
introduction to these functions). Put simply,
pattern interest is the ratio of the number of
instances of the pattern, to the expected number
of instances. Working out the expected number of
instances in a polyphonic dataset is the least
obvious aspect of this definition.

There are a large number of optional arguments
that may have been computed already in various
scenarios, so it would be inefficient to have
them computed again. |#

(defun pattern-interest-polyphonic-no-shadow
       (projected-pattern dataset
        indicator-vector &optional
        (N (length dataset))
        (sorted-dataset
	 (sort-dataset-asc dataset))
        (projected-dataset
         (orthogonal-projection-unique-equalp
          sorted-dataset indicator-vector))
        (size-of-translational-equivalence-class
         (length
          (translators-of-pattern-in-dataset
           projected-pattern projected-dataset)))
        (relevant-pairs
         (orthogonal-projection-not-unique-equalp
          dataset indicator-vector))
        (relevant-data
         (nth-list-of-lists 1 relevant-pairs))
        (relevant-mass
         (progn
           (empirical-mass relevant-data '())
           (identity *empirical-mass*)))
        (minimum-element
         (min-item relevant-data))
        (maximum-element
         (max-item relevant-data))
        (likelihood
         (likelihood-of-projected-pattern
          projected-pattern dataset
          indicator-vector relevant-pairs
          relevant-data relevant-mass
          minimum-element maximum-element))
        (expected-value
         (/ (* N likelihood)
            (length projected-pattern))))
  (float (/ size-of-translational-equivalence-class
     expected-value)))

#| Example:
(setq dataset
 '((0 33 44 2) (0 69 65 1) (1 76 69 1) (2 69 65 1)
   (2 81 72 1) (3 38 47 2) (3 78 70 1) (4 74 68 1)
   (5 69 65 1) (5 81 72 1) (6 37 46 2) (6 76 69 1)
   (7 73 67 1) (8 69 65 1) (8 81 72 1) (9 35 45 2)
   (9 74 68 1) (10 71 66 1) (11 69 65 1) (11 81 72 1)
   (12 33 44 2) (12 73 67 1) (13 76 69 1)
   (14 69 65 1) (14 81 72 1)))
(setq indicator-vector '(1 1 0 0))
(setq D1
      (orthogonal-projection-unique-equalp
       dataset indicator-vector))
(firstn
 10
 (pattern-interests-polyphonic
  (SIATEC D1) dataset indicator-vector (list 0)
  1 1 dataset D1))
gives
((2790178.5
  ((1 76) (3 78) (6 37) (6 76) (7 73) (9 35))
  ((0 0) (3 -2)))
 (120563.27
  ((2 69) (2 81) (5 69) (5 81) (8 69) (8 81) (11 69)
   (11 81))
  ((0 0) (3 0)))
 (6510.4165
  ((2 69) (2 81) (5 69) (5 81) (8 69) (8 81))
  ((0 0) (3 0) (6 0)))
 (3676.4707
  ((1 76) (3 38) (4 74) (6 76))
  ((0 0) (6 -3)))
 (2976.1904
  ((1 76) (4 74) (8 69) (10 71))
  ((0 0) (2 2)))
 (1893.9395
  ((2 81) (3 78) (4 74) (6 76))
  ((0 0) (4 -5)))
 (1736.1111
  ((0 69) (1 76) (4 74) (7 73))
  ((0 0) (5 0)))
 (750.0
  ((3 38) (6 37) (9 35))
  ((0 0) (1 36)))
 (694.44446
  ((0 33) (1 76) (2 69) (2 81))
  ((0 0) (12 0)))
 (535.7143
  ((1 76) (3 38) (3 78))
  ((0 0) (9 -5)))).

There are three mandatory arguments to this function:
analysis-output, the output of some analysis
 function (eg SIATEC);
dataset, the original data D (under the
 identity projection);
indicator-vector, a vector of zeros and ones
 indicating the projection of D under consideration.
Optional arguments are:
index-of-patterns, as analysis output can contain
 additional information to the patterns themselves
 (such as their translators), this vector tells you
 where to look for the actual patterns in the output;
is-SIATEC, equals 1 if SIATEC has been used to
 produce the analysis output, and 0 otherwise;
is-dataset-sorted-asc, sometimes D will already have
 been sorted, so it is inefficient to sort it again.
 This argument equals 1 if it has been sorted, and 0
 otherwise;
sorted-dataset, contains the result of applying the
 function sort-dataset-asc to D;
projected-dataset, D under the projection given in
 the argument indicator-vector (again it can be
 specified if known);
relevant-pairs, a list (not a set) resulting from the
 projection of D under the indicator vector;
relevant-data, a list of MIDI or morphetic numbers
 derived from the argument relevant-pairs;
relevant-mass, empirical probability mass function of
 the data contained in relevant-data;
minimum-element, minimum element in relevant-data;
maximum-element, maximum element in relevant-data;
first-analysis-output, the first element of the
 argument analysis output;
projected-pattern, the current pattern from analysis
 output under consideration;
size-of-translational-equivalence-class, the
 cardinality of $TEC(P, D')$, where P is the current
 pattern and D' the dataset under the relevant
 projection. (If SIATEC has been applied to give the
 argument analysis-output then this argument can be
 found easily.);
N, number of datapoints in D;
interested-analysis-output, the argument analysis-
 output with the pattern interest appended in each
 case;
pattern-interest, the result of the function
 pattern-interest-polyphonic as applied to the
 argument projected-pattern.

The function pattern-interest-polyphonic is applied
to each pattern in a list of several patterns (which
may be hid among other information in the list). The
pattern interest in each case is appended to the
relevant element of the list. |#

(defun pattern-interests-polyphonic
       (analysis-output dataset indicator-vector
	&optional
	(index-of-patterns '())
	(is-SIATEC 0)
	(is-dataset-sorted-asc 0)
	(sorted-dataset
	 (if (equal is-dataset-sorted-asc 1)
	   (identity dataset)
	   (sort-dataset-asc dataset)))
	(projected-dataset
	 (orthogonal-projection-unique-equalp
	  sorted-dataset indicator-vector))
	(relevant-pairs
         (orthogonal-projection-not-unique-equalp
          dataset indicator-vector))
        (relevant-data
         (nth-list-of-lists 1 relevant-pairs))
        (relevant-mass
         (progn
           (empirical-mass relevant-data '())
           (identity *empirical-mass*)))
        (minimum-element
         (min-item relevant-data))
        (maximum-element
         (max-item relevant-data))
	(N (length dataset))
	(interested-analysis-output '())
	(first-analysis-output
	 (first analysis-output))
	(projected-pattern
	 (nth-recursive
	  index-of-patterns first-analysis-output))
	(size-of-translational-equivalence-class
	 (length
	  (if (equal is-SIATEC 1)
	    (second first-analysis-output)
	    (translators-of-pattern-in-dataset
	     projected-pattern projected-dataset))))	
	(pattern-interest
	 (if (not (null projected-pattern))
	   (pattern-interest-polyphonic
	    projected-pattern dataset indicator-vector
	    N sorted-dataset projected-dataset
	    size-of-translational-equivalence-class
	    relevant-pairs relevant-data relevant-mass
	    minimum-element maximum-element))))
  (if (null analysis-output)
    (sort-by '((0 "desc")) interested-analysis-output)
    (pattern-interests-polyphonic
     (rest analysis-output) dataset indicator-vector
     index-of-patterns is-SIATEC
     is-dataset-sorted-asc sorted-dataset
     projected-dataset relevant-pairs relevant-data
     relevant-mass minimum-element maximum-element N
     (cons
      (list pattern-interest first-analysis-output)
      interested-analysis-output))))

#| Example:
(permissible-pairs-transpositions
 '((0 62) (1 60) (2 63))
 '((0 62) (1 60) (2 63) (6 62) (7 60) (8 66)
   (10 58) (13 65) (16 64)))
gives
(((0 60) (1 58) (2 61)) ((0 61) (1 59) (2 62)) 
 ((0 62) (1 60) (2 63)) ((0 63) (1 61) (2 64))
 ((0 64) (1 62) (2 65)) ((0 65) (1 63) (2 66))).

There are two arguments to this function: a list of
pairs and a dataset. Optional arguments allow for
the calculation of minimum and maximum elements
occurring in the dataset. All permissible
transpositions of the pairs are returned, permissible
in the sense that they are within the range of
minimum and maximum elements. |#

(defun permissible-pairs-transpositions
       (pairs dataset &optional
        (index 1)
        (minimum-element
         (min-item
          (nth-list-of-lists index dataset)))
        (maximum-element
         (max-item
          (nth-list-of-lists index dataset))))
  (append
   (reverse
    (permissible-pairs-transpositions-down
     pairs minimum-element))
   (list pairs)
   (permissible-pairs-transpositions-up
    pairs maximum-element)))

#| Example:
(permissible-pairs-transpositions-down
 '((0 62) (1 60) (2 63)) 58)
gives
(((0 61) (1 59) (2 62)) ((0 60) (1 58) (2 61))).

There are two arguments to this function: a list of
pairs and a minimum element. Transpositions down by
one are returned until the minimum element in a pair
equals the minimum element supplied to the function.
|#

(defun permissible-pairs-transpositions-down
       (pairs minimum-element &optional
        (min-in-pairs
         (min-item
          (nth-list-of-lists 1 pairs)))
        (n (- min-in-pairs minimum-element))
        (i 0))
  (let ((transposed-pairs
         (transpose-2nd-of-pairs-down pairs)))
    (if (>= i n) ()
      (cons transposed-pairs
            (permissible-pairs-transpositions-down
             transposed-pairs
             minimum-element
             min-in-pairs
             n (+ i 1))))))

#| Example:
(permissible-pairs-transpositions-up
 '((0 62) (1 60) (2 63)) 65)
gives
(((0 63) (1 61) (2 64)) ((0 64) (1 62) (2 65))).

There are two arguments to this function: a list of
pairs and a maximum element. Transpositions up by one
are returned until the maximum element in a pair
equals the maximum element supplied to the function.
|#

(defun permissible-pairs-transpositions-up
       (pairs maximum-element &optional
        (max-in-pairs
         (max-item
          (nth-list-of-lists 1 pairs)))
        (n (- maximum-element max-in-pairs))
        (i 0))
  (let ((transposed-pairs
         (transpose-2nd-of-pairs-up pairs)))
    (if (>= i n) ()
      (cons transposed-pairs
            (permissible-pairs-transpositions-up
             transposed-pairs
             maximum-element
             max-in-pairs
             n (+ i 1))))))

#| Example:
(present-to-mass '(0 4) '(((4 0) 2/3)) 1/3)
gives
(((0 4) 1/3) ((4 0) 2/3)).

This function takes three arguments: a datapoint d,
an empirical probability mass function p which is in
the process of being calculated, and $\mu$ the
reciprocal of the number of datapoints which have
been observed. If d is new to the empirical mass, it
is added with mass $\mu$, and if it already forms
part $\lambda$ of the mass, then this component is
increased to $\lambda + \mu$. |#

(defun present-to-mass
       (datapoint mass reciprocal-length)
  (let ((relevant-element (assoc
                           datapoint
                           mass
                           :test #'equalp)))
    (if (identity relevant-element)
      (accumulate-to-mass datapoint
                          relevant-element
                          mass
                          reciprocal-length)
      (add-to-mass
       datapoint mass reciprocal-length))))

#| Example:
(probability-of-2nd-of-pair
 '(3 62)
 '((64 1/9) (65 1/9) (58 1/9) (66 1/9) (60 2/9)
   (62 2/9) (63 1/9)))
gives
2/9.

A pair of numbers is supplied to this function,
as well as an empirical mass p. If the second of the
pair appears in the empirical mass, then its
corresponding probability is returned. Otherwise,
zero is returned. |#

(defun probability-of-2nd-of-pair
       (pair relevant-mass &optional
        (probability
         (assoc (second pair)
                relevant-mass
                :test #'equalp)))
  (if (null probability) (identity 0)
    (second probability)))

#| Example:
(transpose-2nd-of-pair-down '(3 62))
gives
(3 61).

A pair of numbers is supplied to this function,
which subtracts 1 from the second of the pair. |#

(defun transpose-2nd-of-pair-down (pair)
  (cons
   (first pair)
   (list (- (second pair) 1))))

#| Example:
(transpose-2nd-of-pair-up '(3 62))
gives
(3 63).

A pair of numbers is supplied to this function,
which adds 1 to the second of the pair. |#

(defun transpose-2nd-of-pair-up (pair)
  (cons
   (first pair)
   (list (+ (second pair) 1))))

#| Example:
(transpose-2nd-of-pairs-down '((3 62) (4 60) (5 63)))
gives
((3 61) (4 59) (5 62)).

Pairs of numbers are supplied to this function,
which subtracts 1 from the second of each pair. |#

(defun transpose-2nd-of-pairs-down (pairs)
  (if (null pairs) ()
    (cons
     (transpose-2nd-of-pair-down
      (first pairs))
     (transpose-2nd-of-pairs-down
      (rest pairs)))))

#| Example:
(transpose-2nd-of-pairs-up '((3 62) (4 60) (5 63)))
gives
((3 63) (4 61) (5 64)).

Pairs of numbers are supplied to this function,
which adds 1 to the second of each pair. |#

(defun transpose-2nd-of-pairs-up (pairs)
  (if (null pairs) ()
    (cons
     (transpose-2nd-of-pair-up
      (first pairs))
     (transpose-2nd-of-pairs-up
      (rest pairs)))))

#| Old code.

#| Example:
(context
 '((8 3) (8 7) (11 -3))
 '((4 -2 7) (8 -2 -3) (8 2 3) (8 4 7) (9 -2 -3)
   (10 -2 7) (11 -2 -3) (11 4 -3) (13 2 -3)
   (13 4 7))
 '(1 0 1))
gives
20.

A pattern, dataset and projection indicator
are provided as arguments. Each datapoint in the
dataset is projected in turn (according to the
projection indicator), and tested for equality with
the first point of the pattern (assumed sorted
ascending). When it is found, the index i of
the datapoint is returned, counting from zero.
(Otherwise nil is returned.) Similarly the index j
of the last point of the pattern is found. If l is
the length of the pattern then the value returned
is $\binom{j - i + 1}{l}$.

This function could have been written using the
function index-item-1st-occurs. But this requires
projecting the entire dataset first, or that the
projected dataset already exists. |#

(defun context
       (pattern dataset projection-indicator
        &optional
        (first-pattern (first pattern))
        (last-pattern (my-last pattern))
        (i
         (index-point-in-dataset
          first-pattern
          dataset
          projection-indicator))
        (j
         (-
          (length dataset)
          (index-point-in-dataset
           last-pattern
           (reverse dataset)
           projection-indicator))))
  (if (or (null i) (null j)) ()
    (choose (- j i) (length pattern))))

#| Example:
(context-projected-dataset
 '((8 3) (8 7) (11 -3))
 '((4 7) (8 -3) (8 3) (8 7) (9 -3) (10 7) (11 -3)
   (11 -3) (13 -3) (13 7)))
gives
20.

A projected pattern and dataset are provided as
arguments. Each datapoint in the dataset is tested
for equality with the first point of the pattern
(assumed sorted ascending). When it is found, the
index i of the datapoint is returned, counting from
zero. (Otherwise nil is returned.) Similarly the
index j of the last point of the pattern is found.
If it occurs more than once then the maximum index
is used. The function returns the value
$\binom{j - i + 1}{l}$, where l is the length of
the pattern. |#

(defun context-projected-dataset
       (pattern projected-dataset &optional
        (first-pattern (first pattern))
        (last-pattern (my-last pattern))
        (i
         (index-item-1st-occurs
          first-pattern
          projected-dataset))
        (j
         (- (length projected-dataset)
          (index-item-1st-occurs
           last-pattern
           (reverse projected-dataset)))))
  (if (or (null i) (null j)) ()
    (choose (- j i) (length pattern))))

(defun translators-of-pattern-in-dataset
       (pattern dataset &optional
        (translators
         (subtract-list-from-each-list
          dataset
          (first pattern)))
        (next-translators
         (if (null (second pattern))
           (identity translators)
           (subtract-list-from-each-list
            dataset
            (second pattern))))
        (intersection-of-translators
         (intersection-multidimensional
          translators next-translators)))
  (if (null (first pattern))
    (identity intersection-of-translators)
    (if (null intersection-of-translators) ()
      (translators-of-pattern-in-dataset
       (rest pattern)
       dataset
       next-translators))))

(defun likelihood-of-pattern
       (pattern relevant-mass
        &optional
        (probabilities '())
        (dim-pattern (length (first pattern)))
        (pattern-palette
         (orthogonal-projection-not-unique-equalp
          pattern
          (cons 0 (constant-vector
                   1
                   (- dim-pattern 1))))))
  (if (null pattern-palette)
    (multiply-list probabilities)
    (likelihood-of-pattern
     pattern
     relevant-mass
     (cons
      (second
       (assoc (first pattern-palette)
              relevant-mass
              :test #'equalp))
      probabilities)
     dim-pattern
     (rest pattern-palette)))) |#                                                                 