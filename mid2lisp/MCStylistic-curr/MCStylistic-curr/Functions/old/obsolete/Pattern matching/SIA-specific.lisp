#| Tom Collins
   Thursday 23 July 2009
   Incomplete

These functions are useful for finding specific MTPs,
TECs, MWTs, without running an exhaustive search.
Reference is `Algorithms for discovering repeated
patterns in multidimensional representations of
polyphonic music', by D. Meredith, K. Lemstrom and G.A.
Wiggins, in Journal of New Music Research 31(4) 2002,
321-345. |#

#| Example:
(difference-list '((8 -2 -3) (4 6 6) (4 7 -3)))
gives
((-4 8 9) (-4 9 0)
 (4 -8 -9) (0 1 -9)
 (4 -9 0) (0 -1 9)).

The argument to this function is a list consisting
of sublists of equal lengths. For i = 1,..., n,
the ith sublist S is removed from the argument to
give a list L, and the function
subtract-list-from-each-list is applied. |#

(defun difference-list
       (a-list &optional (n (length a-list)) (i 0))
  (if (equal i n) ()
    (append
     (subtract-list-from-each-list
      (remove-nth i a-list)
      (nth i a-list))
     (difference-list a-list n (+ i 1)))))

#| Example:
(index-1st-sublist-item<=
 6 '(14 14 14 11 7 7 6 6 4 1 1 0 0))
gives
6.

This function takes two arguments: a real number x
and a list L of real numbers. It returns the index
of the first element of L which is less than or equal
to x. |#

(defun index-1st-sublist-item<=
       (item a-list &optional (i 0))
  (if (null a-list) ()
    (if (<= (first a-list) item) (identity i)
      (index-1st-sublist-item<=
       item (rest a-list) (+ i 1)))))

#| Example:
(index-1st-sublist-item>=
 4 '(0 0 0 1 1 4 6 6 7 7 11 14 14 14))
gives
5.

This function takes two arguments: a real number x
and a list L of real numbers. It returns the index
of the first element of L which is greater than or
equal to x. |#

(defun index-1st-sublist-item>=
       (item a-list &optional (i 0))
  (if (null a-list) ()
    (if (>= (first a-list) item) (identity i)
      (index-1st-sublist-item>=
       item (rest a-list) (+ i 1)))))

#| Example:
(is-maximal-translatable-pattern
 '((0 1/2) (1/2 1/2))
 '((0 1/2) (1/2 1/2) (1 1/2)
   (1 1) (2 3) (5 1/2) (11/2 1/2)))
gives
(5 0).

Two arguments are supplied to this function: a
pattern P and a dataset D. If P is a maximal
translatable pattern in D for some vector u, then u
is returned. NIL is returned otherwise. |#

(defun is-maximal-translatable-pattern
       (pattern dataset &optional
        (vector-differences
         (difference-list dataset)))
  (if (null vector-differences) ()
    (if (equal
         pattern
         (maximal-translatable-pattern
          (first vector-differences) dataset))
      (identity (first vector-differences))
      (is-maximal-translatable-pattern
       pattern dataset
       (rest vector-differences)))))

#| Example:
(maximal-translatable-pattern '(2 0)
 '((0 1) (0 1/2) (1 1) (2 1) (2 1/2) (3 2)))
gives
((0 1) (0 1/2)).

This function takes two arguments: a vector (list) u
and a dataset (list of lists) D. It returns the
maximal translatable pattern of u in D, defined by
$MTP(u, D) = \{ d in D : d + u in D \}$. |#

#| 25/10/2010 Superseeded by a function in the file
structural-inference-algorithm.lisp. 
(defun maximal-translatable-pattern
       (vector projected-dataset &optional
        (minus-vector
         (multiply-list-by-constant vector -1)))
  (if (>= (first vector) 0)
    (maximal-translatable-pattern>
     vector projected-dataset)
    (translation
     (maximal-translatable-pattern>
      minus-vector projected-dataset)
     minus-vector)))
|#

#| Example:
(maximal-translatable-pattern> '(2 0)
 '((0 1) (0 1/2) (1 1) (2 1) (2 1/2) (3 2)))
gives
((0 1) (0 1/2)).

This function assumes that the vector argument
provided has a non-negative first element (hence the
'>') in the name. This enables a more efficient search
for the maximal translatable pattern of an arbitrary
vector u, searching in some dataset D, defined by
$MTP(u, D) = \{ d \in D \mid d + u in D \}$. |#

#| 25/10/2010 Superseeded by a function in the file
structural-inference-algorithm.lisp.
(defun maximal-translatable-pattern>
       (vector projected-dataset &optional
        (n (length projected-dataset))
        (sorted-projected-dataset
         (sort-by
          (pair-off-lists
           (add-to-list
            -1 (reverse (first-n-naturals n)))
           (constant-vector "asc" n))
          projected-dataset))
        (first-datapoint
         (first sorted-projected-dataset))
        (vector+datapoint
         (add-two-lists first-datapoint vector)))
  (if (null sorted-projected-dataset) ()
    (append
     (if (test-equal<list-elements
          sorted-projected-dataset vector+datapoint)
       (list first-datapoint))
     (maximal-translatable-pattern>
      vector projected-dataset n
      (rest sorted-projected-dataset)))))
|#

#| Example:
(maximal-translatable-pattern-sorted '(2 0)
 '((0 1/2) (0 1) (1 1) (2 1/2) (2 1) (3 2)))
gives
((0 1) (0 1/2)).

This function assumes that the vector argument
provided has a non-negative first element (hence the
'>') in the name.  It also assumes that the dataset is
sorted ascending. This enables a more efficient search
for the maximal translatable pattern of an arbitrary
vector u, searching in some dataset D, defined by
$MTP(u, D) = \{ d \in D \mid d + u in D \}$. |#

(defun maximal-translatable-pattern-sorted
       (vector dataset &optional
        (first-datapoint
         (first dataset))
        (vector+datapoint
         (add-two-lists first-datapoint vector)))
  (if (null dataset) ()
    (append
     (if (test-equal<list-elements
          dataset vector+datapoint)
       (list first-datapoint))
     (maximal-translatable-pattern-sorted
      vector (rest dataset)
      ))))

#| Example:
(orthogonal-projection-not-unique-equalp
 '((2 4 -1 6 9) (0 0 4 2 -7) (-3 -2 -1 -1 1)
   (12 0 -7 5 3) (1 2 3 4 3) (1 2 5 4 5))
 '(1 1 0 1 0))
gives
((2 4 6) (0 0 2) (-3 -2 -1) (12 0 5) (1 2 4) (1 2 4)).

Given a set of vectors (all members of the same n-
dimensional vector space), and an n-tuple of zeros and
ones indicating a particular orthogonal projection,
this function returns the projected set of vectors. |#

(defun orthogonal-projection-not-unique-equalp
       (vector-set projection-indicator &optional
        (nth-list-indexed
         (nth-list-index projection-indicator)))
  (if (null vector-set) ()
    (cons
     (nth-list nth-list-indexed (first vector-set))
     (orthogonal-projection-not-unique-equalp
      (rest vector-set) projection-indicator
      nth-list-indexed))))

#| Example:
(orthogonal-projection-unique-equalp
 '((2 4 -1 6 9) (0 0 4 2 -7) (-3 -2 -1 -1 1)
   (12 0 -7 5 3) (1 2 3 4 3) (1 2 5 4 5)
   (12 0 -6 5 4) (-3 -2 1 -1 0) (12 0 -7 5 4))
 '(1 1 0 1 0))
gives
((2 4 6) (0 0 2) (-3 -2 -1) (12 0 5) (1 2 4)).

Given a set of vectors (all members of the same n-
dimensional vector space), and an n-tuple of zeros and
ones indicating a particular orthogonal projection,
this function returns the projected set of vectors.
Coincidences are reduced to single vectors. |#

(defun orthogonal-projection-unique-equalp
       (vector-set projection-indicator &optional
        (projected-not-unique
         (orthogonal-projection-not-unique-equalp
          vector-set projection-indicator)))
  (sort-dataset-asc
   projected-not-unique))

#| Example:
(pair-off-lists '("asc" "asc" "asc") '(0 1 2))
gives
(("asc" 0) ("asc" 1) ("asc" 2)).

Two lists A and B of equal length are provided as
arguments to this function. The first element a1
of A is paired off with the first element b1 of B
to become the first sublist of a new list, and so
on for a2 and b2, a3 and b3. |#

(defun pair-off-lists (a-list b-list)
  (if (null a-list) ()
    (cons
     (list (first a-list) (first b-list))
     (pair-off-lists
      (rest a-list) (rest b-list)))))

#| Example:
(test-equal<subset '((4 6) (6 5) (6 5) (6 7))
 '((0 1) (0 2) (1 3) (1 4) (4 6) (6 5) (6 7)
   (7 9) (7 10) (11 11) (14 1) (14 3) (14 14)))
gives
T.

There are two arguments to this function, both lists
of n-tuples. If when written as sets, the first
argument is a subset of the second, then T is
returned. Otherwise NIL is returned (and an empty
first argument is permissible). The '<' in the
function name indicates that a subfunction,
test-equal<list-elements, assumes an argument has
been sorted ascending by each of its elements. |#    

(defun test-equal<subset
       (a-list b-list &optional
        (b-1st-elements
         (nth-list-of-lists 0 b-list))
        (start-search
	 (if (null a-list) ()
	   (index-1st-sublist-item>=
	    (first (first a-list))
	    b-1st-elements)))
        (end-search
	 (if (null a-list) ()
	   (index-1st-sublist-item<=
	    (first (my-last a-list))
	    (reverse b-1st-elements))))
        (c-list
         (if (and (not (null a-list))
                  (not (null start-search))
                  (not (null end-search)))
           (subseq
            b-list
            start-search
            (- (length b-list) end-search)))))
  (if (null a-list) (identity T)
    (if (test-equal<list-elements
         c-list (first a-list))
      (test-equal<subset
       (rest a-list) b-list
       b-1st-elements start-search
       end-search c-list))))

#| Example:
(translation '((8 -2 -3) (4 6 6) (4 7 -3))
             '(3 1 0))
gives
((11 -1 -3) (7 7 6) (7 8 -3)).

The first argument is a list of sublists, but we
imagine it as a set of vectors (all members of the
same n-dimensional vector space). The second
argument---another list---is also an n-dimensional
vector, and this is added to each of the members
of the first argument. `Added' means vector
addition, that is element-wise, so the resulting
set is a translation of the first argument by the
second. |#

(defun translation (a-list b-list)
  (if (or (null a-list) (null b-list)) ()
    (cons
     (add-two-lists (first a-list) b-list)
     (translation (rest a-list) b-list))))

#| Example:
(translational-equivalence-class
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
(((6 2) (7 1/2) (15/2 1/4)
  (31/4 1/4) (8 1) (9 1))
 ((9 2) (10 1/2) (21/2 1/4)
  (43/4 1/4) (11 1) (12 1))
 ((12 2) (13 1/2) (27/2 1/4)
  (55/4 1/4) (14 1) (15 1))).

The function takes two arguments: a pattern P and a
dataset D. It returns the translational equivalence
class of P in D.

This is the latest (most efficient) way to find the
translational equivalence class of a pattern. It
calls the function translators-of-pattern-in-dataset.
A previous version is given at the bottom of this
file, but it's incomplete and not as efficient. |#

(defun translational-equivalence-class
       (pattern dataset &optional
	(translators
	 (translators-of-pattern-in-dataset
	  pattern dataset)))
  (if (null translators) ()
    (cons
     (translation pattern (first translators))
     (translational-equivalence-class
      pattern dataset (rest translators)))))




