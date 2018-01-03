#| Example:
(firstn 3 '(3 4 (5 2) 2 0))
gives
(3 4 (5 2)).

This function returns the first n items of a list. |#

(defun firstn (n a-list)
  (if (or (null a-list) (<= n 0)) ()
    (cons (first a-list)
          (firstn (- n 1) (rest a-list)))))

#| Example:
(my-last '(1 3 6 7))
gives
7.

Returns the last element of a list as an element,
not as a list. |#

(defun my-last (a-list)
  (first (last a-list)))

(progn
  (setq
   TECs
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/Write to files/L 1 (1 1 1 1 0) TECs.txt")))
  (identity "read."))

(progn
  (setq
   few-TECs
   (firstn 10 TECs))
  (identity "read."))

(progn
  (setq
   growing-list
   (growing-list-branching few-TECs))
  (identity "read."))

; See if assoc works as we would wish.
(assoc
 '((154 67 64 1) (155 67 64 1) (156 65 63 1)
   (161 62 61 1) (162 62 61 1) (163 62 61 1)
   (164 62 61 1) (174 72 67 1) (178 72 67 1)
   (203 82 73 1/3))
 growing-list :test #'equalp)
; It does! What about rassoc?
(rassoc
 '((1))
 growing-list :test #'equalp)
; It does!

(setq i 1)
(setq length-TECs (length few-TECs))
(setq indices
         (new-indices-for-indices
          (first-n-naturals-listed-asc length-TECs)
          length-TECs))
(setq growing-list
         (growing-list-branching
          few-TECs length-TECs))
(setq next-indices nil)
(setq index (first indices))
(setq probe
         (if index
           (intersection-multidimensional
            (first
             (rassoc
              (subseq index 0 i)
              growing-list :test #'subsetp))
            (nth (my-last index) TECs))))
(setq result
         (if probe
           (assoc probe growing-list :test #'equalp)))
(setq indices (rest indices))
(setq index (first indices))
(setq probe
         (if index
           (intersection-multidimensional
            (first
             (rassoc
              (subseq index 0 i)
              growing-list :test #'subsetp))
            (nth (my-last index) TECs))))
(setq result
         (if probe
           (assoc probe growing-list :test #'equalp)))
(setq indices (rest indices))
(setq
 growing-list
 (append growing-list (list (cons probe index))))
(setq
 next-indices
 (append next-indices (list index)))


(setq special-next-index
         (if result
           (sort
             (copy-list
              (union (cdr result) index)) '<)))
(rplacd
            (assoc probe growing-list :test #'equalp)
            ;(cons
             ;probe
             special-next-index)
(setq next-indices (append
          next-indices (list special-next-index)))

(setq indices (new-indices-for-indices
        next-indices length-TECs))
(setq i (+ i 1))

(time
 (progn
   (setq
    few-TECs
    (firstn 355 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))
;133.313610 seconds, length 7058.
; with `> 1' change, 219.585920 seconds!
; length now 6998! Doesn't seem worth it.

(write-to-file
 finally
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Write to files/L 1 (1 1 1 1 0) penultimate.txt"))

; 26/12/2009
(time
 (progn
   (setq
    few-TECs
    (firstn 100 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))
; 1.800334 seconds, finally has 999 in.

; Now try it with `> 1'.
(time
 (progn
   (setq
    few-TECs
    (firstn 100 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))
; 1.761703 seconds, finally has 905 in.

; Back to first definition with 200.
(time
 (progn
   (setq
    few-TECs
    (firstn 200 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))
; 24.292091 seconds, finally has 3780 in.

; Now try it with `> 1'.
(time
 (progn
   (setq
    few-TECs
    (firstn 200 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))
; 34.071392 seconds, finally has 3742 in.

#| With 100 TECs, there are 94 single-point sets.
   With 200 TECs, there are 38 single-point sets,
and the algorithm that checks `> 1' takes much
longer to run.

Not absolutely sure about this, so going to check
it out with smaller numbers. |#

; Back to 1st definition.
(time
 (progn
   (setq
    few-TECs
    (firstn 10 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))

; Now with `length > 1'.
(time
 (progn
   (setq
    few-TECs
    (firstn 10 TECs))
   (setq
    finally
    (branching-intersections few-TECs))     
   (identity "read.")))

#| Checking with small numbers suggests that the
algorithm is running correctly. As we take more
TECs, the chances of getting a single-point
intersection seem to be reduced and fewer are
discovered, relative to the number of multi-point
intersections. So it hardly seems worth including
the `length > 1' condition, as it adds a lot of
time to the running of the algorithm. |#