#| Tom Collins
   Wednesday 28 April 2010
   Incomplete Wednesday 28 April 2010

These functions help to convert discovered patterns
into MIDI files. |#

; ?REQUIRED PACKAGES
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/director-musices.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/midi-save.lisp"))
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

#|
\noindent Example:
\begin{verbatim}
(events-with-this-image
 '(4 1)
 '((3 65 63 1 1) (3 77 70 1/3 0) (10/3 76 69 1/3 0)
   (11/3 74 68 1/3 0) (4 67 64 1 1) (4 72 67 1 0)
   (5 65 63 1 1) (5 71 66 1 0))
 '(1 0 0 1 0))
--> ((4 67 64 1 1) (4 72 67 1 0)).
\end{verbatim}

The first argument to this function is a projected
datapoint, under some projection specified by the
third argument. The second argument is an unprojected
dataset, each member of which is tested for equality
with the datapoint under the projection, and a list
of those datapoints that do coincide is returned. |#

(defun events-with-this-image
       (projected-datapoint unprojected-dataset
        projection-indicator &optional
        (indices
         (nth-list-index projection-indicator)))
  (if (null unprojected-dataset) ()
    (append
     (if (equalp
          (nth-list
           indices (first unprojected-dataset))
          projected-datapoint)
       (list (first unprojected-dataset)))
     (events-with-this-image
      projected-datapoint (rest unprojected-dataset)
      projection-indicator indices))))

#|
\noindent Example:
\begin{verbatim}
(events-with-these-images
 '((4 1) (5 1))
 '((3 65 63 1 1) (3 77 70 1/3 0) (10/3 76 69 1/3 0)
   (11/3 74 68 1/3 0) (4 67 64 1 1) (4 72 67 1 0)
   (5 65 63 1 1) (5 71 66 1 0))
 '(1 0 0 1 0))
--> ((4 67 64 1 1) (4 72 67 1 0) (5 65 63 1 1)
     (5 71 66 1 0)).
\end{verbatim}

Applies the function events-with-this-image
recursively to a list of projected datapoints
(probably some pattern). |#

(defun events-with-these-images
       (projected-datapoints unprojected-dataset
        projection-indicator &optional
        (indices
         (nth-list-index projection-indicator)))
  (if (null projected-datapoints) ()
    (append
     (events-with-this-image
      (first projected-datapoints)
      unprojected-dataset projection-indicator
      indices)
     (events-with-these-images
      (rest projected-datapoints)
      unprojected-dataset projection-indicator
      indices))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *path&name*
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation/Example files"
  "/pattern-audition.mid"))
(setq
 *pattern*
 '((26 1/2) (53/2 1/2) (55/2 1/2) (28 1/2) (57/2 3/2)
   (29 1/2)))
(setq
 *region*
 '((26 1/2) (53/2 1/2) (27 1/2) (55/2 1/2) (28 1/2)
   (57/2 3/2) (29 1/2)))
(setq
 *unprojected-dataset*
 '((26 76 69 1/2 0) (53/2 78 70 1/2 0)
   (27 68 64 1/2 0) (55/2 71 66 1/2 0)
   (28 75 68 1/2 0) (57/2 76 69 3/2 0)
   (29 61 60 1/2 2)))
(setq *musical-surface* *unprojected-dataset*)
(pattern2MIDI
 *path&name* 1500 *pattern* *region*
 *unprojected-dataset* *musical-surface*
 "surface projection" '(1 0 0 1 0))
--> well highlighted MIDI file in specified location.
\end{verbatim}

Takes a pattern and converts it to a MIDI file for
auditioning. At the moment it can handle surface
projections (treating durational patterns slightly
differently) and it is hoped that it will deal with
harmonic projections as well. |#

(defun pattern2MIDI
       (path&name scale pattern region
        unprojected-dataset musical-surface
        dataset-type projection-indicator)
  (if (string= dataset-type "surface projection")
    (if (equalp projection-indicator '(1 0 0 1 0))
      (pattern2MIDI-durational
       path&name scale pattern region
       unprojected-dataset projection-indicator)
      (pattern2MIDI-surface
       path&name scale pattern region
       unprojected-dataset projection-indicator))
    (pattern2MIDI-harmonic
     path&name scale pattern region
     unprojected-dataset musical-surface
     projection-indicator)))

#|
\noindent Example:
\begin{verbatim}
(setq
 *path&name*
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation/Example files"
  "/pattern-audition-dur.mid"))
(setq
 *pattern*
 '((26 1/2) (53/2 1/2) (55/2 1/2) (28 1/2) (57/2 3/2)
   (29 1/2)))
(setq
 *region*
 '((26 1/2) (53/2 1/2) (27 1/2) (55/2 1/2) (28 1/2)
   (57/2 3/2) (29 1/2)))
(setq
 *unprojected-dataset*
 '((26 76 69 1/2 0) (53/2 78 70 1/2 0)
   (27 68 64 1/2 0) (55/2 71 66 1/2 0)
   (28 75 68 1/2 0) (57/2 76 69 3/2 0)
   (29 61 60 1/2 2)))
(pattern2MIDI-durational
 *path&name* 1500 *pattern* *region*
 *unprojected-dataset* '(1 0 0 1 0))
--> well highlighted MIDI file in specified location.
\end{verbatim}

Takes a durational pattern and converts it to a MIDI
file for auditioning. |#

(defun pattern2MIDI-durational
       (path&name scale pattern region
        unprojected-dataset projection-indicator
        &optional
        (region-pattern
         (set-difference-multidimensional-sorted-asc
          region pattern))
        (events
         (append
          (modify-to-check-dataset
           (events-with-these-images
            pattern unprojected-dataset
            projection-indicator) scale 1 84)
          (modify-to-check-dataset
           (events-with-these-images
            region-pattern unprojected-dataset
            projection-indicator) scale 1 28)
          (modify-to-check-dataset
           (mapcar
            #'(lambda (x)
                (list
                 (first x) 37 48 ; MPN irrelevant
                 (second x))) pattern)
           scale 10 84))))
  (saveit
   path&name
   (mapcar
    #'(lambda (x)
        (cons
         (- (first x) (first (first events)))
         (rest x))) events)))

#|
\noindent Example:
\begin{verbatim}
(setq
 *path&name*
 (concatenate
  'string
  "/Applications/CCL/Lisp documentation/Example files"
  "/pattern-audition-sur.mid"))
(setq
 *pattern*
 '((84 65 1/2) (169/2 67 1/2) (85 69 1/2)
   (171/2 72 1/2) (86 71 1/2) (173/2 72 1/2)))
(setq
 *region*
 '((84 65 1/2) (169/2 67 1/2) (85 69 1/2)
   (171/2 60 3/2) (171/2 72 1/2) (86 71 1/2)
   (173/2 72 1/2)))
(setq
 *unprojected-dataset*
 '((84 57 58 21/2 3) (84 69 65 1/2 0)
   (169/2 73 67 1/2 0) (85 76 69 1/2 0)
   (171/2 61 60 3/2 2) (171/2 81 72 1/2 0)
   (86 80 71 1/2 0) (173/2 81 72 1/2 0)))
(pattern2MIDI-surface
 *path&name* 1500 *pattern* *region*
 *unprojected-dataset* '(1 0 1 1 0))
--> well highlighted MIDI file in specified location.
\end{verbatim}

Takes a surface-projcetion pattern other than of
the durational kind and converts it to a MIDI file
for auditioning. |#

(defun pattern2MIDI-surface
       (path&name scale pattern region
        unprojected-dataset projection-indicator
        &optional
        (region-pattern
         (set-difference-multidimensional-sorted-asc
          region pattern))
        (events
         (append
          (modify-to-check-dataset
           (events-with-these-images
            pattern unprojected-dataset
            projection-indicator) scale 1 84)
          (modify-to-check-dataset
           (events-with-these-images
            region-pattern unprojected-dataset
            projection-indicator) scale 1 28))))
  (saveit
   path&name
   (mapcar
    #'(lambda (x)
        (cons
         (- (first x) (first (first events)))
         (rest x))) events)))

#|
\noindent Example:
\begin{verbatim}
(projection-type2indicator "MNN")
--> (1 0 0 0 0).
\end{verbatim}

Takes a projection type specified in string form and
converts it into the appropriate projection
indictor. |#

(defun projection-type2indicator (projection-type)
  (if (string= projection-type "MNN")
    (list 1 1 0 0 0)
    (if (string= projection-type "MPN")
      (list 1 0 1 0 0)
      (if (string= projection-type "dur")
        (list 1 0 0 1 0)
        (if (string= projection-type "MNN, dur")
          (list 1 1 0 1 0)
          (list 1 0 1 1 0))))))
