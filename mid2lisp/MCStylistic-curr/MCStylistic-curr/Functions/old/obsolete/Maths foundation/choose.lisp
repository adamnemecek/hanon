#| Tom Collins
   Friday 26 December 2008
   Incomplete Saturday 30 January 2010

\noindent The functions below are for performing
various combinatorial calculations. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Maths foundation")
   :name "list-processing"
   :type "lisp")
  *MCStylistic-Mar2013-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Maths foundation")
   :name "vector-operations"
   :type "lisp")
  *MCStylistic-Mar2013-path*))

#| Example:
(choices 6 7 4)
gives
'((1 2 3 4) (2 3 4 5) (1 3 4 5) (1 2 4 5) (1 2 3 5)
  (3 4 5 6) (2 4 5 6) (1 4 5 6) (2 3 5 6) (1 3 5 6)
  (1 2 5 6) (2 3 4 6) (1 3 4 6) (1 2 4 6) (1 2 3 6)
  (4 5 6 7) (3 5 6 7) (2 5 6 7) (3 4 6 7) (2 4 6 7)
  (2 3 6 7) (3 4 5 7) (2 4 5 7) (2 3 5 7) (2 3 4 7)).

The arguments of choices are n, bigN and r respectively.
The function returns lists of length r, chosen from a
span of no more than n integers over a range of bigN
integers. |#

(defun choices (n bigN r &optional
                  (current-choice
                   (reverse (first-n-naturals r)))
                  (final-choice current-choice))
  (let ((s (extent current-choice final-choice)))
    (if (> (my-last final-choice) bigN) ()
      (append (list current-choice)
              (choices n bigN r
                       (next-choice current-choice r s)
                       (next-final-choice final-choice
                                          n r s))))))

#| Example:
(choices-step-limit 3 7 4)
gives
'((1 2 3 4) (1 2 3 5) (1 2 3 6) (1 2 4 5) (1 2 4 6)
  (1 2 4 7) (1 2 5 6) (1 2 5 7)           (1 3 4 5)
  (1 3 4 6) (1 3 4 7) (1 3 5 6) (1 3 5 7) 
  (1 3 6 7)                     (1 4 5 6) (1 4 5 7)
            (1 4 6 7)
                      (2 3 4 5) (2 3 4 6) (2 3 4 7)
  (2 3 5 6) (2 3 5 7)           (2 3 6 7) 
            (2 4 5 6) (2 4 5 7)           (2 4 6 7)
                       
  (2 5 6 7)
                                          (3 4 5 6)
  (3 4 5 7)           (3 4 6 7)
                                          (3 5 6 7)
  

                                          
            (4 5 6 7)).
(Note the patterns containing 8+ are missing.)

This function has arguments step, bigN and r. It returns
lists of length r, which contain numbers 1 through bigN,
in ascending order, such that there does not exist a
step between any two items of a list which exceeds the
variable step. |#

(defun choices-step-limit
       (step bigN r
        &optional (last-subset
                   (reverse 
                    (first-n-naturals r)))
                  (modulo-vector
                   (mod-list
                    (add-to-nth
                     -1 r (constant-vector 1 r)) step))
                  (n (+
                      (* (- bigN r)
                         (expt step (- r 1))) 1)))
  (if (equal n 0) ()
    (append
     (if (<= (my-last last-subset) bigN)
       (list last-subset)
       ())
     (choices-step-limit
      step bigN r
      (next-subset last-subset r modulo-vector)
      (mod+list-by-list
       modulo-vector (constant-vector 1 r)
       (reverse (power-vector step r)))
      (- n 1)))))

#| Example:
(choices-step-limit1by1 5 6 3 '(2 5 7) '(12 2 0) 42)
gives
'((3 4 5) 5 6 3 (3 4 6) (2 2 0) 27).

The problem with the function choices-step-limit is that
all possible choices are returned in a list. This
function calculates one choice at a time, and so reduces
demands made on memory. Potentially it has six arguments:
1) step;
2) bigN;
3) r;
4) the last subset (which may be inadmissible);
5) the modulo-vector
6) n, which counts down to zero. |#

(defun choices-step-limit1by1
       (variables-list &optional
	(step (second variables-list))
	(bigN (third variables-list))
	(r (fourth variables-list))
	(last-subset
	 (if (null (fifth variables-list))
	   (reverse (first-n-naturals r))
	   (fifth variables-list)))
	(modulo-vector
	 (if (null (sixth variables-list))
	   (mod-list
	    (add-to-nth
	     -1 r (constant-vector 1 r)) step)
	   (sixth variables-list)))
	(n
	 (if (null (seventh variables-list))
	   (+ (* (- bigN r) (expt step (- r 1))) 1)
	   (seventh variables-list))))
  (if (equal n 0) ()
    (let ((potential-next-subset
	   (next-subset last-subset r modulo-vector))
	  (next-modulo-vector
	   (mod+list-by-list
	    modulo-vector (constant-vector 1 r)
	    (reverse (power-vector step r)))))
      (if (> (my-last last-subset) bigN)
	(choices-step-limit1by1
	 (list NIL step bigN r
	       potential-next-subset
	       next-modulo-vector
	       (- n 1)))
	(list last-subset
	      step bigN r
	      potential-next-subset
	      next-modulo-vector
	      (- n 1))))))

#| Example:
(choose 9 5)
gives
126.

This function returns 'n choose r', that is
n!/(r!(n-r)!), where n and r are natural numbers or zero.
|#

(defun choose (n r)
  (/ (factorial-j n (- n (+ r 1)))
     (factorial (- n r))))

#| Example:
(constant-vector 2.4 6)
gives
'(2.4 2.4 2.4 2.4 2.4 2.4).

This function gives a constant vector of prescribed
length. |#

(defun constant-vector (c n &optional (i 0))
  (if (equal i n) ()
    (cons c (constant-vector c n (+ i 1)))))

#| Example:
(extent '(1 2 4 7) '(1 2 3 7))
gives
2.

Counting s from 0 from the start of a list called
current-choice, this function adds 1 to s for each
subsequent entry of current choice which is equal
to the corresponding element of the second list,
called final-choice. |#

(defun extent (current-choice final-choice
                              &optional (s 0))
  (if (or (null current-choice)
          (not (equal (first current-choice)
                      (first final-choice))))
  (identity s)
  (extent (rest current-choice) 
          (rest final-choice)
          (+ s 1))))

#| Example:
(factorial 5)
gives
120.

This function returns n(n-1)(n-2)...3.2.1 where n is
a natural number or zero. |#

(defun factorial (n &optional (m 1))
  (if (or (equal n 1) (equal n 0)) (identity m)
    (* n (factorial (- n 1)))))


#| Example:
(factorial-j 9 3)
gives
3024.

The arguments of this function are n > j, both natural
numbers or zero. The answer n(n-1)(n-2)...(n-j) is
returned. Should j >= n or j < 0, 1 is returned. This
function makes the function 'choose' more efficient by
avoiding direct calculation of n!/r!. |#

(defun factorial-j (n j &optional (m n))
  (if (or (<= n j) (< j 0)) (identity 1)
    (if (equal j 0) (identity m)
       (* n (factorial-j (- n 1) (- j 1))))))

#| Example:
(first-n-naturals 5)
gives
'(5 4 3 2 1).

This function returns the first n natural numbers
as a list. |#

(defun first-n-naturals (n)
  (if (equal n 0) ()
    (cons n (first-n-naturals (- n 1)))))

#| Example:
(mod-list '(1 2 3 4 5 7) 3)
gives
'(1 2 0 1 2 1).

This function gives the value of each item of a list,
modulo b. |#

(defun mod-list (a-list b)
  (if (null a-list) ()
    (cons (mod (first a-list) b)
          (mod-list (rest a-list) b))))

#| Example:
(mod+ 5 6 4)
gives
3.

This function gives the value of a plus an increment,
modulo b. |#

(defun mod+ (a increment b)
  (mod (+ a increment) b))

#| Example:
(mod+list-by-list '(5 2 0) '(3 1 1) '(9 3 1))
gives
'(8 0 0).

This function has three arguments: a list to which is
added the second list, modulo the third list, all
element by element. |#

(defun mod+list-by-list (a-list b-list c-list)
  (if (null a-list) ()
    (cons
     (mod+ (first a-list)
           (first b-list)
           (first c-list))
     (mod+list-by-list (rest a-list)
                       (rest b-list)
                       (rest c-list)))))

#| Example:
(my-last '(1 3 6 7))
gives
7.

Returns the last element of a list as an element,
not as a list. |#

(defun my-last (a-list)
  (first (last a-list)))

#| Example:
(next-choice '(1 2 5 6) 4 2)
gives
'(2 3 4 6).

The first argument here is current-choice, the
second is r and the third is s, the extent. This
function generates the next choice by appending two
lists. |#

(defun next-choice (current-choice r s)
  (if (equal r s)
    (add-to-list
     (+ (- (nth (- s 1) current-choice) r) 1)
     (reverse (first-n-naturals r)))
    (append (add-to-list
             (- (- (nth s current-choice) 1)
                (+ s 1))
             (reverse (first-n-naturals (+ s 1))))
            (lastn (- r (+ s 1)) current-choice))))

#| Example:
(next-final-choice '(1 2 3 5) 6 4 4)
gives
'(1 2 3 6).

The first argument here is the current final
choice, followed by n, r, s. If r is not equal to
s, no change is made to the current final choice.
If on the other hand, r equals s then changes
occur, according to whether the last item of the
current final choice exceeds n. |#

(defun next-final-choice (final-choice n r s)
  (if (not (equal r s)) (identity final-choice)
    (if (>= (my-last final-choice) n)
      (add-to-list 1 final-choice)
      (add-to-nth 1 r final-choice))))

#| Example:
(next-subset '(1 2 3 6) 4 '(3 3 0 0))
gives
'(1 2 4 5).

The next subset is returned, based on the last subset
(first argument) and the index of the first zero entry
in the modulo vector (second argument). It calls two
functions from utilities: index-item-1st-occurs and
firstn. |#

(defun next-subset (last-subset subset-size
                    modulo-vector)
  (let ((splice (index-item-1st-occurs
                 0 modulo-vector)))
    (append (firstn splice last-subset)
            (add-to-list
             (nth splice last-subset)
             (reverse
              (first-n-naturals
               (- subset-size splice)))))))

#| Example:
(power-vector 5 3)
gives
(1 5 25).

A vector is returned containing increasing powers of the
base number, ending with base-number^(l-1). |#

(defun power-vector (base-number l
                     &optional (i 0)
                               (last-value 1))
  (if (equal i l) ()
    (cons last-value
          (power-vector base-number l(+ i 1)
                        (* base-number last-value)))))