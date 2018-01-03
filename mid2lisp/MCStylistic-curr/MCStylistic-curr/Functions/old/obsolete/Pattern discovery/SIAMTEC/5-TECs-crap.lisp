#| Tom Collins
   Tuesday 22 December 2009
   Incomplete

The functions below ... (output of stage 4). |#

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
(check-potential-translators
 '(3 52) '((0 0) (1 2) (1 5) (2 7))
 '((0 60) (3 52) (4 57) (5 59)))
gives
((0 0) (1 5) (2 7)).

Checks whether the first argument, when translated by
each member of the second argument, is a member of the
third argument. Members of the second argument that
satisfy this property are returned. |#

(defun check-potential-translators
       (patternpoint potential-translators dataset
        &optional (length-dataset (length dataset)))
  (if (null potential-translators) ()
    (append
     (test-equal-potential-translator
      dataset patternpoint
      (first potential-translators) length-dataset)
     (check-potential-translators
      patternpoint (rest potential-translators)
      dataset length-dataset))))

#| Example:
(nth-list-TEC
 '(0 4 5)
 '(((1 38) (1 62)) ((1 62) (2 63))
   ((0 60) (1 62) (2 63)) ((2 39) (4 59))
   ((2 63) (4 59)) ((0 60) (2 63) (4 59)))
 '((0 60) (1 38) (1 62) (2 39) (2 63) (4 59)))
gives
(((1 38) (1 62)) ((2 39) (2 63)) ((2 63) (4 59))
  ((0 60) (2 63) (4 59))).

This function applies the functions nth and
translational equivalence class recursively to
the second list argument, according to the items of
the first list argument. |#

(defun nth-list-TEC
       (output-indices all-translations dataset)
  (if (null output-indices) ()
    (append
     (translational-equivalence-class
      (car (nth (car output-indices) all-translations))
      dataset)
     (nth-list-TEC
      (rest output-indices)
      all-translations dataset))))

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
(test-equal-list-elements
 '((0 1) (0 2) (1 1) (3 1/4))
 '(1 1))
gives
((1 1)).

The first argument is a list of sublists, not assumed
to be ordered. We imagine it as a set of vectors (all
members of the same n-dimensional vector space). The
second argument v (another list) is also an
n-dimensional vector. Each item of the list is checked
for equality with v. If an item of the list is found to
be equal, v is returned and nil otherwise. |#

(defun test-equal-list-elements (a-list probe)
  (loop for i from 0 below (length a-list)
    when (equalp (nth i a-list) probe)
    return (list (nth i a-list))))

#| Example:
(test-equal-potential-translator
 '((0 1) (0 2) (1 2) (3 1/4)) '(0 1) '(1 1))
gives
((1 1)).

This function is very similar in spirit to test-
equal-list-elements. The first argument here is a
dataset, the second is a member of some pattern (so
also a member of the dataset), and the third is a
potential translator of the patternpoint. If the
potential translator is really a translator, it is
returned, and nil otherwise. |#

(defun test-equal-potential-translator
       (dataset patternpoint potential-translator
        &optional
        (length-dataset (length dataset))
        (sum
         (add-two-lists
          patternpoint potential-translator)))
  (loop for i from 0 below length-dataset
    when (equalp (nth i dataset) sum)
    return (list potential-translator)))

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

#| Example:
(translators-of-pattern-in-dataset
 '((8 3) (8 7))
 '((4 7) (8 -3) (8 3) (8 7) (9 -3) (10 7) (11 -3)
   (13 -3) (13 1)))
gives
((0 0) (5 -6)).

A pattern and dataset are provided. The transaltors of
the pattern in the dataset are returned. This could be
made more efficient. It starts well, but at the stage
where the third datapoint of a pattern p3 is being
checked, there is no longer a need to take the
intersection of current translators T and D - p3.
Rather each element of p3 + T should be checked for
membership in D, and a new set U formed from those in
T that lead to membership. |#

(defun translators-of-pattern-in-dataset
       (pattern dataset &optional
        (translators
         (subtract-list-from-each-list
          dataset
          (first pattern)))
        (next-translators
         (if (null (second pattern))
           (identity translators)
           (check-potential-translators
            (second pattern) translators dataset))))
  (if (or
       (equal (length translators) 1) 
       (null (first pattern)))
    (identity translators)
    (translators-of-pattern-in-dataset
     (rest pattern)
     dataset
     next-translators)))

#| Old version.
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
  (if (or
       (equal (length intersection-of-translators) 1) 
       (null (first pattern)))
    (identity intersection-of-translators)
    (translators-of-pattern-in-dataset
     (rest pattern)
     dataset
     intersection-of-translators)))
|#