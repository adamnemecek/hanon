
(progn
  (setq
   X
   '((-1 81) (-3/4 76) (-1/2 85) (-1/4 81)
     (0 88) (1 57) (1 61) (1 64) (2 73)
     (9/4 69) (5/2 76) (11/4 73) (3 81) (4 45)
     (4 49) (4 52) (4 57) (5 61) (21/4 57)
     (11/2 64) (23/4 61) (6 57) (6 69) (7 54)
     (7 59) (7 63) (7 69) (8 51) (8 59) (8 66)
     (8 69) (9 52) (9 59) (9 66) (9 69)
     (10 40) (10 64) (10 68)))
  (setq
   Y-all
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "mutantBeethovenOp2No2Mvt3"
      :type "txt")
     *example-files-path*)))
  (setq
   Y
   (orthogonal-projection-unique-equalp
    Y-all '(1 1 0 0 0)))
  (setq Y (firstn 500 Y))
  (setq
   X-fgp (symbolic-fingerprint X "query"))
  (setq
   Y-fgp (symbolic-fingerprint Y "mutant"))
  "Yes!")
(match-score-histogram X-fgp Y-fgp)

(defun match-score-histogram
       (X-fgp Y-fgp &optional (res 1)
        (flexitime nil)
        (XY-idx
         (matching-lists-indices
          (nth-list-of-lists 0 X-fgp)
          (nth-list-of-lists 0 Y-fgp)
          flexitime))
        (X-idx (first XY-idx))
        (Y-idx (second XY-idx))
        ; Time stamps of matching tokens.
        (X-ts
         (nth-list-of-lists
          1
          (nth-list-of-lists
           1 (nth-list X-idx X-fgp))))
        (Y-ts
         (nth-list-of-lists
          1
          (nth-list-of-lists
           1 (nth-list Y-idx Y-fgp))))
        ; Time differences of matching tokens.
        (X-td
         (nth-list-of-lists
          2
          (nth-list-of-lists
           1 (nth-list X-idx X-fgp))))
        (Y-td
         (nth-list-of-lists
          2
          (nth-list-of-lists
           1 (nth-list Y-idx Y-fgp))))
        ; Apply affine transformation.
        (r
         (mapcar
          #'(lambda (x y) (/ y x))
          X-td Y-td))
        (s
         (mapcar
          #'(lambda (x y z) (- y (* x z)))
          X-ts Y-ts r))
        (edges
         (loop for i from (min-item s) to
           (max-item s) by res collect i)))
  (histogram s edges))
        



(setq res 1)
(setq flexitime nil)
(progn
  (setq XY-idx
        (matching-lists-indices
         (nth-list-of-lists 0 X-fgp)
         (nth-list-of-lists 0 Y-fgp)
         flexitime))
  (setq X-idx (first XY-idx))
  (setq Y-idx (second XY-idx))
  ; Time stamps of matching tokens.
  (setq X-ts
   (nth-list-of-lists
    1
    (nth-list-of-lists
     1 (nth-list X-idx X-fgp))))
  (setq Y-ts
   (nth-list-of-lists
    1
    (nth-list-of-lists
     1 (nth-list Y-idx Y-fgp))))
  "Yes!"
  ; Time differences of matching tokens.
  (setq X-td
   (nth-list-of-lists
    2
    (nth-list-of-lists
     1 (nth-list X-idx X-fgp))))
  (setq Y-td
   (nth-list-of-lists
    2
    (nth-list-of-lists
     1 (nth-list Y-idx Y-fgp))))
  "Yes!"
  ; Apply affine transformation.
  (setq r
   (mapcar
    #'(lambda (x y) (/ y x))
    X-td Y-td))
  (setq s
   (mapcar
    #'(lambda (x y z) (- y (* x z)))
    X-ts Y-ts r))
  (setq edges
   (loop for i from (min-item s) to
     (max-item s) by res collect i))
  "Yes!")

(setq *ans* (histogram s edges))







