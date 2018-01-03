; Tom and Iris. 21/12/2017.

; Importing and spelling MIDI files.

; Set paths
(setq
 midi-data-directory
 (make-pathname
  :directory
  '(:absolute "Users" "tomthecollins" "Downloads"
    "iris_midi")))
(setq
 point-set-dest
 (merge-pathnames
  (make-pathname
   :directory
   '(:absolute "Users" "tomthecollins" "Downloads"
    "iris_point_sets"))))

; Parse the directory
(setq fnam (list-directory midi-data-directory))

; Import and process MIDI files.
(loop for i from 0 to (- (length fnam) 1) do
  (setq curr-nam (nth i fnam))
  (if (equalp (pathname-type curr-nam) "mid")
      (progn
        (setq ps-raw (load-midi-file curr-nam))
        #| Some notes appear to have 1/120 subtracted
        from ontimes and durations. Others 1/60. So
        round to nearest member of farey(6).
        (setq
         ps
         (loop for j from 0 to (- (length ps-raw) 1)
           collect
           (progn
             (setq on-raw (first (nth j ps-raw)))
             (setq
              a (multiple-value-list (floor on-raw)))
             ; Find closest value of farey(6).
             (setq
              min-a
              (min-argmin
               (mapcar
                #'(lambda (x)
                    (abs (- x (second a)))) farey6)))
             ; Add it to the integer part of a.
             (setq
              on
              (+
               (first a)
               (nth (second min-a) farey6)))
             ; Do the same for durations.
             (setq dur-raw (third (nth j ps-raw)))
             (setq
              b (multiple-value-list (floor dur-raw)))
             ; Find closest value of farey(6).
             (setq
              min-a
              (min-argmin
               (mapcar
                #'(lambda (x)
                    (abs (- x (second b)))) farey6)))
             ; Add it to the integer part of a.
             (setq
              dur
              (+
               (first b)
               (nth (second min-a) farey6)))
             (list
              on
              (second (nth j ps-raw))
              dur
              (fourth (nth j ps-raw))
              (fifth (nth j ps-raw))))))
        |#
        #| Estimate key using KS algorithm and use it
        to estimate morphetic pitch numbers. |#
        (setq ps ps-raw)
        (setq
         fsm
         (fifth-steps-mode
          ps *Krumhansl&Kessler-key-profiles*))
        (setq
         ps
         (loop for j from 0 to (- (length ps) 1)
           collect
           (append
            (subseq (nth j ps) 0 2)
            (list
             (guess-morphetic
              (second (nth j ps)) fsm))
            (subseq (nth j ps) 2))))
        (dataset2csv
         ps
         (merge-pathnames
          (make-pathname
           :name (pathname-name curr-nam) :type "csv")
          point-set-dest))
        )))



