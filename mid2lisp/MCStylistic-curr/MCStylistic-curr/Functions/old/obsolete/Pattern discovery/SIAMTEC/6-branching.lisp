#| Tom Collins
   Wednesday 23 December 2009
   Incomplete

The functions below ... |#

#| Example:

This function is not designed to check for translations
as it proceeds. Notice that there's been a debate about
checking for single-point intersections, and that at
present it is deemed not to be worthwhile. |#



#| Alternative trying to account for (1 2 3 6). 
Working at the mo. Uses subsetp. |#

(defun branching-intersections
       (TECs &optional (length-TECs (length TECs))
        (i 1)
        (indices
         (new-indices-for-indices
          (first-n-naturals-listed-asc length-TECs)
          length-TECs))
        (growing-list
         (growing-list-branching
          TECs length-TECs))
        (next-indices nil)
        (index (first indices))
        (probe
         (if index
           (intersection-multidimensional
            (first
             (rassoc
              (subseq index 0 i)
              growing-list :test #'subsetp))
            (nth (my-last index) TECs))))
        (result
         (if probe
           (assoc probe growing-list :test #'equalp)))
        (special-next-index
         (if result
           (sort
             (copy-list
              (union (cdr result) index)) '<))))
  (if (null indices)
    (if (null next-indices)
      (identity growing-list)
#| Generate next set of indices: |#
      (branching-intersections
       TECs length-TECs (+ i 1)
       (new-indices-for-indices
        next-indices length-TECs)
       growing-list))
#| There are still some indices and the probe has
length greater than 1. |#
    (if probe
        ;(> (length probe) 1)
#| Probe has been discovered before: |#      
      (if result
        (branching-intersections
         TECs length-TECs i (rest indices)
         (progn
           (rplacd
            (assoc probe growing-list :test #'equalp)
            ;(cons
             ;probe
             special-next-index)
           (identity growing-list))
         next-indices
     #| This makes next-indices longer, but
        unnecessarily so, because the correct
        predecessors are still in the list. So changed
        to the above call to next-indices.
         (append
          next-indices (list special-next-index)) |#
     )
#| Probe is new: |#
        (branching-intersections
         TECs length-TECs i (rest indices)
         (append growing-list (list (cons probe index)))
         (append next-indices (list index))))
#| Probe is empty: |#
      (branching-intersections
       TECs length-TECs i (rest indices) growing-list
       next-indices))))

#| Old version. 
(defun branching-intersections
       (TECs &optional (length-TECs (length TECs))
        (indices
         (new-indices-for-indices
          (first-n-naturals-listed-asc length-TECs)
          length-TECs))
        (growing-list
         (growing-list-branching
          TECs length-TECs))
        (next-indices nil)
        (index (first indices))
        (probe
         (if index
           (intersection-multidimensional
            (first
             (rassoc
              (list (butlast index))
              growing-list :test #'equalp))
            (nth (my-last index) TECs))))
        (result
         (if probe
           (assoc probe growing-list :test #'equalp)))
        (special-next-index
         (if result
           (list
            (sort
             (copy-list
              (union (my-last result) index)) '<)))))
  (if (null indices)
    (if (null next-indices)
      (identity growing-list)
#| Generate next set of indices: |#
      (branching-intersections
       TECs length-TECs
       (new-indices-for-indices
        next-indices length-TECs)
       growing-list))
#| There are still some indices and probe non-empty: |#
    (if probe
#| Probe has been discovered before: |#      
      (if result
        (branching-intersections
         TECs length-TECs (rest indices)
         (progn
           (rplacd
            (assoc probe growing-list :test #'equalp)
            ;(list
             ;probe
            special-next-index)
           (identity growing-list))
         (append
          next-indices special-next-index))
#| Probe is new: |#
        (branching-intersections
         TECs length-TECs (rest indices)
         (append growing-list (list (list probe index)))
         (append next-indices (list index))))
#| Probe is empty: |#
      (branching-intersections
       TECs length-TECs (rest indices) growing-list
       next-indices))))
|#

#| Example:
(first-n-naturals-listed-asc 5)
gives
((0) (1) (2) (3) (4)).

Does what is says on the tin. |#

(defun first-n-naturals-listed-asc
       (n &optional (i 0))
  (if (>= i n) ()
    (cons
     (list i)
     (first-n-naturals-listed-asc n (+ i 1)))))

#| Example:
(growing-list-branching
 '(((154 67 64 1) (155 67 64 1) (156 65 63 1))
   ((161 62 61 1) (162 62 61 1) (163 62 61 1))
   ((164 62 61 1) (174 72 67 1))))
gives
((((154 67 64 1) (155 67 64 1) (156 65 63 1)) (1))
 (((161 62 61 1) (162 62 61 1) (163 62 61 1)) (2))
 (((164 62 61 1) (174 72 67 1)) (3))).

A list of translational equivalence classes is
paired off with indices. |#

(defun growing-list-branching
       (TECs &optional (length-TECs (length TECs))
        (i 0))
  (if (>= i length-TECs) ()
    (cons
     (cons (first TECs) (list i))
     (growing-list-branching
      (rest TECs) length-TECs (+ i 1)))))

#| Example:
(intersection-multidimensional
 '((2 0 0) (4 7 6) (4 8 8) (5 -1 0))
 '((2 0 0) (4 6 7) (4 7 6)))
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
      (test-equal<list-elements
       b-list
       (first a-list))
     (intersection-multidimensional
      (rest a-list) b-list))))

#| Example:
(new-indices-for-index '(1 3 5 6) 9)
gives
((1 3 5 6 7) (1 3 5 6 8)).

Takes a list and extends it by appending the next
largest natural number, as many times as possible
up (but not equal to) a specified limit (the second
argument). |#

(defun new-indices-for-index
       (index final-increment &optional
        (current-increment 
         (+ (my-last index) 1)))
  (if (>= current-increment final-increment) ()
    (append
     (list
      (append index (list current-increment)))
     (new-indices-for-index
      index final-increment
      (+ current-increment 1)))))

#| Example:
(new-indices-for-indices '((1 2 4 8) (1 3 5 6)) 10)
gives
((1 2 4 8 9) (1 3 5 6 7) (1 3 5 6 8) (1 3 5 6 9)).

Takes existing indices an extends them by applying
the function new-indices-for-index recursively. |#

(defun new-indices-for-indices
       (indices final-increment)
  (if (null indices) ()
    (append
     (new-indices-for-index
      (first indices) final-increment)
     (new-indices-for-indices
      (rest indices) final-increment))))

