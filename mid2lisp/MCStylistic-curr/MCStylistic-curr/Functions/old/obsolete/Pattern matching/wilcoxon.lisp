#|
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-compose.lisp")
(load "//Applications/CCL/Lisp code/SMC 2009/maximal-translatable-pattern.lisp")
(load "//Applications/CCL/Lisp code/SMC 2009/translational-equivalence-class.lisp")
|#

#|
(setq *a-sample* '(1 3 3 4 5 7))
(setq *b-sample* '(5 7 7 10 11 13 15))
|#

(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Possibly redundant"
  "/chords.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern matching"
  "/SIA-specific.lisp"))


(defun test-wilcoxon2-two-sided
       (a-sample b-sample &optional (alpha 0.05))
  (let* ((m (length a-sample)) (n (length b-sample))
	 (m>n (> m n))
	 (swap-a-b
	  (if m>n
	    (identity a-sample)
	    (identity b-sample)))
	 (a-sample
	  (if m>n
	    (identity b-sample)
	    (identity a-sample)))
	 (b-sample
	  (if m>n
	    (identity swap-a-b)
	    (identity b-sample)))
	 (swap-m-n (if m>n (identity m) (identity n)))
	 (m (if m>n (identity n) (identity m)))
	 (n (if m>n (identity swap-m-n) (identity n)))
	 (a-cap-b
	  (unique-equalp
	   (intersection a-sample b-sample)))
	 (EW '()) (VW '()) (z '()) (u* '()) (u '())
	 (alpha-level
	  (if (equal alpha 0.1) (identity 0)
	    (if (equal alpha 0.05) (identity 1)
	      (if (equal alpha 0.02) (identity 2)
		(if (equal alpha 0.01) (identity 3))))))
	 (critical-value
	  (nth alpha-level  
	       (nth (- n 1)
		    (nth (- m 1)
 '(()
   (() () () () (0) (0) (0) (1 0) (1 0) (1 0) (1 0) (2 1) (2 1 0) (3 1 0) (3 1 0) (3 1 0) (3 2 0) (4 2 0) (4 2 1 0) (4 2 1 0))
   (() () (0) (0) (1 0) (2 1) (2 1 0) (3 2 0) (4 2 1 0) (4 3 1 0) (5 3 1 0) (5 4 2 1) (6 4 2 1) (7 5 2 1) (7 5 3 2) (8 6 3 2) (9 6 4 2) (9 7 4 2) (10 7 4 3) (11 8 5 3))
   (() () () (1 0) (2 1 0) (3 2 1 0) (4 3 1 0) (5 4 2 1) (6 4 3 1) (7 5 3 2) (8 6 4 2) (9 7 5 3) (10 8 5 3) (11 9 6 4) (12 10 7 5) (14 11 7 5) (15 11 8 6) (16 12 9 6) (17 13 9 7) (18 14 10 8))
   (() () () () (4 2 1 0) (5 3 2 1) (6 5 3 1) (8 6 4 2) (9 7 5 3) (11 8 6 4) (12 9 7 5) (13 11 8 6) (15 12 9 7) (16 13 10 7) (18 14 11 8) (19 15 12 9) (20 17 13 10) (22 18 14 11) (23 19 15 12) (25 20 16 13))
   (() () () () () (7 5 3 2) (8 6 4 3) (10 8 6 4) (12 10 7 5) (14 11 8 6) (16 13 9 7) (17 14 11 9) (19 16 12 10) (21 17 13 11) (23 19 15 12) (25 21 16 13) (26 22 18 15) (30 25 20 17) (32 27 22 18))
   (() () () () () () (11 8 6 4) (13 10 7 6) (15 12 9 7) (17 14 11 9) (19 16 12 10) (21 18 14 12) (24 20 16 13) (26 22 17 15) (28 24 19 16) (30 26 21 18) (33 28 23 19) (35 30 24 21) (37 32 26 22) (39 34 28 24))
   (() () () () () () () (15 13 9 7) (18 15 11 9) (20 17 13 11) (23 19 15 13) (26 22 17 15) (28 24 20 17) (31 26 22 18) (33 29 24 20) (36 31 26 22) (39 34 28 24) (41 36 30 26) (44 38 32 28) (47 41 34 30))
   (() () () () () () () () (21 17 14 11) (24 20 16 13) (27 23 18 16) (30 26 21 18) (33 28 23 20) (36 31 26 22) (39 34 28 24) (42 37 31 27) (45 39 33 29) (48 42 36 31) (51 45 38 33) (54 48 40 36))
   (() () () () () () () () () (27 23 19 16) (31 26 22 18) (34 29 24 21) (37 33 27 24) (41 36 30 26) (44 39 33 29) (48 42 36 31) (51 45 38 34) (55 48 41 37) (58 52 44 39) (62 55 47 42))
   (() () () () () () () () () () (34 30 25 21) (38 33 28 24) (42 37 31 27) (46 40 34 30) (50 44 37 33) (54 47 41 36) (57 51 44 39) (61 55 47 42) (65 58 50 45) (69 62 53 48))
   (() () () () () () () () () () () (42 37 31 27) (47 41 35 31) (51 45 38 34) (55 49 42 37) (60 53 46 41) (64 57 49 44) (68 61 53 47) (72 65 56 51) (77 69 60 54))
   (() () () () () () () () () () () () (51 45 39 34) (56 50 43 38) (61 54 47 42) (65 59 51 45) (70 63 55 49) (75 67 59 53) (80 72 63 57) (84 76 67 60))
   (() () () () () () () () () () () () () (61 55 47 42) (66 59 51 46) (71 64 56 50) (77 69 60 54) (82 74 65 58) (87 78 60 63) (92 83 73 67))
   (() () () () () () () () () () () () () () (72 64 56 51) (77 70 61 55) (83 75 66 60) (88 80 70 64) (94 85 75 69) (100 90 80 73))
   (() () () () () () () () () () () () () () () (83 75 66 60) (89 81 71 65) (95 86 76 70) (101 92 82 74) (107 98 87 79))
   (() () () () () () () () () () () () () () () () (96 87 77 70) (102 92 82 75) (109 99 88 81) (115 105 93 86))
   (() () () () () () () () () () () () () () () () () (109 99 88 81) (116 106 94 87) (123 112 100 92))
   (() () () () () () () () () () () () () () () () () () (123 113 101 93) (130 119 107 99))
   (() () () () () () () () () () () () () () () () () () () (138 127 114 105)))))))
	 (ranks
	  (add-to-nth-list
	   1 3
	   (enumerate-append
	    (sort-by
	     '((0 "asc"))
	     (append
	      (pair-off-lists
	       a-sample
	       (constant-vector 1 m))
	      (pair-off-lists
	       b-sample
	       (constant-vector 0 n)))))))
	 (ranks
	  (if a-cap-b
	    (update-tied-ranks ranks a-cap-b)
	    (identity ranks)))
	 (w
	  (add-pairwise-products ranks 1 2)))
    (if (null alpha-level)
      (print "Non-standard value of alpha")
      (if (null critical-value)
	(if (or (> m 20) (> n 20))
	  (progn
	    (setf EW (/ (* m (+ m n 1)) 2))
	    (setf VW (/ (* m n (+ m n 1)) 12))
	    (setf z (/ (- w EW) (sqrt VW)))
	    (if (>
		 (abs z)
		 (nth alpha-level '(1.6449 1.9600
		                    2.3263 2.5758)))
	      (identity T)))
	  (print "Insufficient sample sizes to test"))
	(progn
	  (setf u* (- w (/ (* m (+ m 1)) 2)))
	  (setf u (min-item (list u* (- (* m n) u*))))
	  (if (<= u critical-value)
	    (identity T)))))))
  
#| Example:
(update-nth-item-in-list '(6 -9 0 4 6 2 2 3 8 10) 7 4.8)
gives
(6 -9 0 4 6 2 2 4.8 8 10).

This function takes three arguments: a list L, an index i
and an element x. The ith element of L is replaced by x
in the output. |#

(defun update-nth-item-in-list
       (a-list an-index an-item &optional
        (length-list (length a-list)))
  (if (and (integerp an-index)
           (>= an-index 0)
           (< an-index length-list))
  (append
   (firstn an-index a-list)
   (list an-item)
   (lastn (- (- (length a-list) 1) an-index) a-list))))

#| Example:
(update-i2jth-items-in-list
 '(6 -9 0 4 6 2 2 3 8 10) 2 5 '(99 99 97 "Ah"))
gives
(6 -9 99 99 97 "Ah" 2 3 8 10).

This function takes four arguments: a list L, two
indices i < j and a list l assumed to be of length
j - i + 1. The ith element of L is replaced by l1,
the (i + 1)th element of L is replaced by l2, and so
on, up until the (j - i + 1)th element being replaced
by lj. |#

(defun update-i2jth-items-in-list
       (a-list i j items &optional
       (k i) (l (length a-list)))
  (if (> k j) (identity a-list)
    (update-i2jth-items-in-list
     (update-nth-item-in-list
      a-list k (first items) l)
     i j (rest items) (+ k 1))))

#| Example:
(mean '(4 5 3 60))
gives
18.

The mean of a list of number is returned. (The function
fibonacci-list is called.) |#

(defun mean (a-list)
  (/ (my-last (fibonacci-list a-list)) (length a-list)))

#| 
(update-tied-rank
 '((3 0 1)   (4.2 0 2) (5 1 3)  (5.2 0 4) (7 1 5)
   (7 0 6)   (7 1 7)   (10 1 8) (11 1 9)  (11 0 10)
   (13 1 11) (15 1 12)) 7)
gives
((3 0 1) (4.2 0 2) (5 1 3) (5.2 0 4) (7 1 6)
 (7 0 6) (7 1 6) (10 1 8) (11 1 9) (11 0 10)
 (13 1 11) (15 1 12)). |#

(defun update-tied-rank
       (list-of-triples tied-datum &optional
        (l (length list-of-triples))
        (data (nth-list-of-lists 0 list-of-triples))
        (ranks (nth-list-of-lists 2 list-of-triples))
        (i
         (index-item-1st-occurs tied-datum data))
        (j
         (-
          l
          (+ (index-item-1st-occurs tied-datum
                                    (reverse data))
             1))))
  (triple-off-lists
   data
   (nth-list-of-lists 1 list-of-triples)
   (update-i2jth-items-in-list
    ranks
    i j
    (constant-vector (mean
                      (subseq
                       ranks
                       i (+ j 1)))
                     (+ (- j i) 1))
    i l)))

#| 
(update-tied-ranks
 '((3 0 1)   (4.2 0 2) (5 1 3)  (5.2 0 4) (7 1 5)
   (7 0 6)   (7 1 7)   (10 1 8) (11 1 9)  (11 0 10)
   (13 1 11) (15 1 12)) '(7 11))
gives
((3 0 1) (4.2 0 2) (5 1 3) (5.2 0 4) (7 1 6)
 (7 0 6) (7 1 6) (10 1 8) (11 1 19/2) (11 0 19/2)
 (13 1 11) (15 1 12)). |#

(defun update-tied-ranks
       (list-of-triples tied-data &optional
        (l (length list-of-triples))
        (data (nth-list-of-lists 0 list-of-triples)))
  (if (null tied-data) (identity list-of-triples)
    (update-tied-ranks
     (update-tied-rank
      list-of-triples (first tied-data) l data)
     (rest tied-data) l data)))

(defun triple-off-lists (a-list b-list c-list)
  (if (null a-list) ()
    (cons
     (list (first a-list)
           (first b-list)
           (first c-list))
     (triple-off-lists
      (rest a-list) (rest b-list) (rest c-list)))))

(defun add-pairwise-products
       (a-list &optional (i 0) (j 1) (partial-sum 0))
  (if (null a-list) (identity partial-sum)
    (add-pairwise-products
     (rest a-list) i j
     (+
      partial-sum
      (* (nth i (first a-list))
         (nth j (first a-list)))))))

(defun add-to-nth-list
       (a-number an-index a-list)
  (if (null a-list) ()
    (cons
     (add-to-nth a-number an-index (first a-list))
     (add-to-nth-list
      a-number an-index (rest a-list)))))