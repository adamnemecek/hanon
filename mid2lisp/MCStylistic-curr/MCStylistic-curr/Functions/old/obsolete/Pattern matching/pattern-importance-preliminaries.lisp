#| Tom Collins
   Tuesday 20 October 2009
   Incomplete

The aim of these functions is to adapt one of the
key ideas from a paper entitled `Feature set patterns
in music', by M. Bergeron and D. Conklin, in Computer
Music Journal 32(1) 2008, 60-70. It is the idea of
pattern interest, and the aim here is to adapt it to
polyphonic music.

NB Some functions have been transferred from the file
pattern-interest.lisp. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/set-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))

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
(direct-product-of-n-sets
 '((1 2) ((59) (60)) (-4 -2)))
gives
((1 59 -4) (1 59 -2) (1 60 -4) (1 60 -2)
 (2 59 -4) (2 59 -2) (2 60 -4) (2 60 -2)).

This function takes a single argument (assumed to be a
list of sets of numbers or sets of sets), and returns
the direct product of these sets. |#

(defun direct-product-of-n-sets
       (n-sets &optional
        (first-set (first n-sets))
        (rest-sets (rest n-sets))       
        (result
         (if (numberp (first first-set))
           (mapcar #'(lambda (x) (list x))
                   first-set)
           (identity first-set)))
        (b-listed
         (if rest-sets
           (if (numberp (first (first rest-sets)))
             (mapcar #'(lambda (x) (list x))
                     (first rest-sets))
             (identity (first rest-sets))))))
  (if (null rest-sets) (identity result)
    (direct-product-of-n-sets
     n-sets first-set (rest rest-sets)
     (direct-product-of-two-sets
      result b-listed))))

#| Example:
(direct-product-of-two-sets '(1/3 1 2) '(59 60))
gives
((1/3 59) (1/3 60) (1 59) (1 60) (2 59) (2 60)).

This function takes two arguments (assumed to be sets
of numbers or sets of sets), and returns the direct
product of these sets. |#

(defun direct-product-of-two-sets
       (a-set b-set &optional
        (a-listed
         (if (numberp (first a-set))
           (mapcar #'(lambda (x) (list x)) a-set)
           (identity a-set)))
        (b-listed
         (if (numberp (first b-set))
           (mapcar #'(lambda (x) (list x)) b-set)
           (identity b-set)))
        (m (length a-set)) (n (length b-set))
        (i 0) (j 0) (result nil))
  (if (>= i m) (identity result)
    (direct-product-of-two-sets
     a-set b-set a-listed b-listed m n
     (if (>= j n) (+ i 1) (identity i))
     (if (>= j n) (identity 0) (+ j 1))
     (append result
             (if (< j n)
               (list
                (append
                 (nth i a-listed)
                 (nth j b-listed))))))))

#| Example:
(empirical-mass '((4 0) (4 0) (0 4)) '())
gives
(((0 4) 1/3) ((4 0) 2/3)).

This function returns the empirical probability mass
function p for a dataset listed d1*, d2*,..., dN*. |#

(defun empirical-mass
       (dataset &optional (mass nil)
        (reciprocal-length (/ 1 (length dataset))))
  (if (null dataset)
    (identity mass)
    (empirical-mass (rest dataset)
                    (present-to-mass
                     (first dataset)
                     mass
                     reciprocal-length)
                    reciprocal-length)))

#| Example:
(events-with-these-ontime-others
 '((6 63) (7 96) (9 112))
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/3 1 37) (6 63 1/2 2 34) (7 91 1 1 56)
   (7 96 1/2 1 73) (7 96 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73))
 1 2)
gives
((6 1/3) (6 1/2) (7 1/2) (7 1) (9 3/4)).

The first argument to this function is a pattern,
under the projection of ontime and MIDI note number
(in which case other-index = 1) or morphetic pitch
(in which case other-index = 2). The corresponding
members of the full dataset are sought out and
returned as ontime-other pairs. |#

(defun events-with-these-ontime-others
       (projected-datapoints unprojected-dataset
        &optional (other-index 1)
	(return-index 3) (ontime-index 0)
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
     (events-with-this-ontime-other
      (first projected-datapoints)
      relevant-dataset
      other-index return-index ontime-index)
     (events-with-these-ontime-others
      (rest projected-datapoints)
      unprojected-dataset
      other-index return-index ontime-index
      ontimes
      relevant-start relevant-finish
      relevant-dataset))))

#| Example:
(events-with-this-ontime-other
 '(7 96)
 '((23/4 86 1/4 2 46) (6 55 1/2 1 37)
   (6 63 1/3 1 37) (6 63 1/2 2 34) (7 91 1 1 56)
   (7 96 1/2 1 73) (7 96 1 1 95) (7 108 3/2 2 50)
   (17/2 109 1/2 2 49) (9 95 1 1 71)
   (9 98 1 1 71) (9 102 1 1 71) (9 112 3/4 2 73))
 1 2)
gives
((7 1/2) (7 1)).

The first argument to this function is a datapoint,
under the projection of ontime and MIDI note number
(in which case other-index = 1) or morphetic pitch
(in which case other-index = 2). The corresponding
members of the full dataset are sought out and
returned as ontime-other pairs. |#

(defun events-with-this-ontime-other
       (projected-datapoint relevant-dataset
        &optional (other-index 1)
	(return-index 3) (ontime-index 0))
  (if (null projected-datapoint) ()
    (if (null relevant-dataset) ()
      (append
       (if (equalp
            (list (nth
                   ontime-index
                   (first relevant-dataset))
                  (nth
                   other-index
                   (first relevant-dataset)))
            projected-datapoint)
         (list
	  (list
	   (nth 0 (first relevant-dataset))
	   (nth return-index
		(first relevant-dataset)))))
       (events-with-this-ontime-other
        projected-datapoint
        (rest relevant-dataset)
        other-index return-index ontime-index)))))

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



#| Example 1:
(likelihood-of-pattern-or-translation
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3)
   (3 60 60 1))
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3) (3 60 60 1)
   (4 62 61 1) (5 64 62 1/2) (6 66 63 1/3) (7 62 61 1)
   (8 69 65 3) (11 59 59 1) (12 60 60 1)))
gives
9/14641 + 4/14641 = 13/14641.

Example 2:
(likelihood-of-pattern-or-translation
 '((0 60 1) (1 61 1) (2 62 1) (3 60 1))
 '((0 60 1) (1 61 1) (1 66 1/2) (3/2 67 1/2) (2 62 1) 
   (2 68 1) (5/2 66 1/2) (3 60 1)))
gives
1/4*1/8*1/8*1/4 = 1/1024.

Example 3:
(likelihood-of-pattern-or-translation
 '((0 60) (1 61) (2 62) (3 60))
 '((0 60) (1 61) (1 66) (3/2 67) (2 62) 
   (2 68) (5/2 66) (3 60)))
gives
1/4*1/8*1/8*1/4 + 1/4*1/8*1/8*1/4 = 1/512.

Example 4:
(likelihood-of-pattern-or-translation
 '((0 1) (1 1) (2 1) (3 1))
 '((0 1) (1 1) (1 1/2) (3/2 1/2) (2 1) 
   (2 1/2) (5/2 1/2) (3 1)))
gives
1/16 + 1/16 = 1/8.

This function takes a pattern and the dataset in which
the pattern occurs. It calculates the potential
translations of the pattern in the dataset and returns
the sum of their likelihoods. |#

(defun likelihood-of-pattern-or-translation
       (pattern dataset &optional
        (pattern-palette
         (orthogonal-projection-not-unique-equalp
          pattern
          (append
           (list 0)
           (constant-vector
            1
            (- (length (first pattern)) 1)))))
        (dataset-palette
         (orthogonal-projection-not-unique-equalp
          dataset
          (append
           (list 0)
           (constant-vector
            1
            (- (length (first pattern)) 1)))))
        (empirical-mass
         (empirical-mass dataset-palette))
        (potential-translations
         (direct-product-of-n-sets
          (potential-n-dim-translations
           (rest (first pattern)) dataset-palette)))
        (result 0))
  (if (null potential-translations) (identity result)
    (likelihood-of-pattern-or-translation
     pattern dataset pattern-palette dataset-palette
     empirical-mass (rest potential-translations)
     (+ result
        (likelihood-of-subset
         (translation pattern-palette
                      (first potential-translations))
         empirical-mass)))))

#| Example:
(likelihood-of-subset
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1))
 '(((60 60 1) 3/11) ((62 61 1/2) 1/11)
   ((64 62 1/3) 1/11) ((62 61 1) 2/11)
   ((64 62 1/2) 1/11) ((66 63 1/3) 1/11)
   ((69 65 3) 1/11) ((59 59 1) 1/11)))
gives
9/14641.

This function takes a pattern-palette and the
empirical mass for the dataset-palette in which the
pattern occurs. The product of the individual masses
is returned, and fasttracked to zero if any pattern
points do not occur in the empirical mass. |#

(defun likelihood-of-subset
       (subset empirical-mass &optional
        (result 1)
        (increment
         (second
          (assoc (first subset)
                 empirical-mass :test #'equalp))))
  (if (null subset) (identity result)
    (if increment
      (likelihood-of-subset
       (rest subset) empirical-mass
       (* result increment))
      (identity 0))))

#| Example:
(likelihood-of-subset-geometric-mean
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1)) 1/4
 '(((60 60 1) 3/11) ((62 61 1/2) 1/11)
   ((64 62 1/3) 1/11) ((62 61 1) 2/11)
   ((64 62 1/2) 1/11) ((66 63 1/3) 1/11)
   ((69 65 3) 1/11) ((59 59 1) 1/11)))
gives
0.1574592.

This function takes a pattern-palette, the reciprocal
length of that pattern, and the empirical mass for the
dataset-palette in which the pattern occurs. The
geometric mean of the individual masses is returned,
and fasttracked to zero if any pattern points do not
occur in the empirical mass. |#

(defun likelihood-of-subset-geometric-mean
       (subset nth-root empirical-mass
        &optional (result 1)
        (mass
         (second
          (assoc (first subset)
                 empirical-mass :test #'equalp)))
        (increment
         (if mass
           (expt mass nth-root))))
  (if (null subset) (identity result)
    (if increment
      (likelihood-of-subset-geometric-mean
       (rest subset) nth-root empirical-mass
       (* result increment))
      (identity 0))))

#| Example 1:
(likelihood-of-translations-geometric-mean
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3)
   (3 60 60 1))
 '((0 60 60 1) (1 62 61 1/2) (2 64 62 1/3) (3 60 60 1)
   (4 62 61 1) (5 64 62 1/2) (6 66 63 1/3) (7 62 61 1)
   (8 69 65 3) (11 59 59 1) (12 60 60 1)))
gives
(9/14641)^(1/4) + (4/14641)^(1/4) = 0.2860241.

Example 2:
(likelihood-of-translations-geometric-mean
 '((0 60 1) (1 61 1) (2 62 1) (3 60 1))
 '((0 60 1) (1 61 1) (1 66 1/2) (3/2 67 1/2) (2 62 1) 
   (2 68 1) (5/2 66 1/2) (3 60 1)))
gives
(1/4*1/8*1/8*1/4)^(1/4) = 0.17677668.

Example 3:
(likelihood-of-translations-geometric-mean
 '((0 60) (1 61) (2 62) (3 60))
 '((0 60) (1 61) (1 66) (3/2 67) (2 62) 
   (2 68) (5/2 66) (3 60)))
gives
(1/4*1/8*1/8*1/4)^(1/4) + (1/4*1/8*1/8*1/4)^(1/4)
 = 0.35355335.

Example 4:
(likelihood-of-translations-geometric-mean
 '((0 1) (1 1) (2 1) (3 1))
 '((0 1) (1 1) (1 1/2) (3/2 1/2) (2 1) 
   (2 1/2) (5/2 1/2) (3 1)))
gives
(1/16)^(1/4) + (1/16)^(1/4) = 1.

This function takes a pattern and the dataset in which
the pattern occurs. It calculates the potential
translations of the pattern in the dataset and returns
the sum of the geometric means of their likelihoods.

2/12/2009. NB This is not really a likelihood, as it
is possible for probabilities to be greater than 1! |#

(defun likelihood-of-translations-geometric-mean
       (pattern dataset &optional
        (pattern-palette
         (orthogonal-projection-not-unique-equalp
          pattern
          (append
           (list 0)
           (constant-vector
            1
            (- (length (first pattern)) 1)))))
        (nth-root (/ 1 (length pattern-palette)))
        (dataset-palette
         (orthogonal-projection-not-unique-equalp
          dataset
          (append
           (list 0)
           (constant-vector
            1
            (- (length (first pattern)) 1)))))
        (empirical-mass
         (empirical-mass dataset-palette))
        (potential-translations
         (direct-product-of-n-sets
          (potential-n-dim-translations
           (rest (first pattern)) dataset-palette)))
        (result 0))
  (if (null potential-translations) (identity result)
    (likelihood-of-translations-geometric-mean
     pattern dataset pattern-palette nth-root
     dataset-palette empirical-mass
     (rest potential-translations)
     (+ result
        (likelihood-of-subset-geometric-mean
         (translation pattern-palette
                      (first potential-translations))
         nth-root
         empirical-mass)))))

#| Example:
(potential-1-dim-translations
 '(60 60 1)
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1)
   (62 61 1) (64 62 1/2) (66 63 1/3) (62 61 1)
   (69 65 3) (59 59 1) (60 60 1)) 0)
gives
(-1 0 2 4 6 9).

This function takes three arguments, the first member
of a pattern palette, the dataset palette and an
index. First of all, the dataset is projected uniquely
along the dimension of index, creating a vector u.
Then the indexth member of the first-pattern-palette
is subtracted from each member of u, giving a list of
potential translations along this dimension. |#

(defun potential-1-dim-translations
       (first-pattern-palette dataset-palette index
        &optional
        (uniques
         (nth-list-of-lists
          0
          (orthogonal-projection-unique-equalp
           dataset-palette
           (append
            (constant-vector 0 index)
            (list 1)
            (constant-vector
             0
             (- (- (length
                    first-pattern-palette)
                   index) 1))))))
        (p1 (nth index first-pattern-palette)))
  (mapcar #'(lambda (x) (- x p1)) uniques))

#| Example:
(potential-n-dim-translations
 '(60 60 1)
 '((60 60 1) (62 61 1/2) (64 62 1/3) (60 60 1)
   (62 61 1) (64 62 1/2) (66 63 1/3) (62 61 1)
   (69 65 3) (59 59 1) (60 60 1)))
gives
((-1 0 2 4 6 9) (-1 0 1 2 3 5) (-2/3 -1/2 0 2)).

This function takes two arguments, the first member of
a pattern palette, the dataset palette and an index.
The function potential-n-dim-translations is applied
recursively to an increment. |#

(defun potential-n-dim-translations
       (first-pattern-palette dataset-palette
        &optional
        (indices
         (add-to-list
          -1
          (reverse
           (first-n-naturals
            (length first-pattern-palette))))))
  (if (null indices) ()
    (append
     (list
      (potential-1-dim-translations
       first-pattern-palette dataset-palette
       (first indices)))
     (potential-n-dim-translations
      first-pattern-palette dataset-palette
      (rest indices)))))

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

