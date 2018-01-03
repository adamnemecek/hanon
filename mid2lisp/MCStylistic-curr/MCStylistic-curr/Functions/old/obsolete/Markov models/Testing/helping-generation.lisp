
(progn
  (setq
   template-segments
   (butlast
    (segments-strict dataset-template 1 3)))
  (setq
   bisection
   (ceiling
    (/
     (+
      (first (my-last template-segments))
      (first (first template-segments))) 2))))

(setq forwards-candidates
      (make-hash-table :test #'equal))
(setq backwards-candidates
      (make-hash-table :test #'equal))
(setq united-candidates
      (make-hash-table :test #'equal))

(setq i 1)
(progn
  (setq time-a (get-internal-real-time))
  (setf
   (gethash
    (concatenate
     'string "forwards," (write-to-string i))
    forwards-candidates)
   (generate-forwards-or-backwards-no-failure
    "forwards" initial-states stm-> bisection
    dataset-template checklist beats-in-bar
    c-failures c-sources c-bar c-min c-max c-beats
    c-prob template-segments))
  (setq time-b (get-internal-real-time))
  (float
   (/
    (- time-b time-a)
    internal-time-units-per-second)))

(progn
  (setq final-states internal-final-states)
  "Yes!")
(setq i 1)
(progn
  (setq time-a (get-internal-real-time))
  (setf
       (gethash
        (concatenate
         'string "backwards," (write-to-string i))
        backwards-candidates)
       (generate-forwards-or-backwards-no-failure
        "backwards" final-states stm<- bisection
        dataset-template checklist beats-in-bar
        c-failures c-sources c-bar c-min c-max c-beats
        c-prob template-segments))
  (setq time-b (get-internal-real-time))
  (float
   (/
    (- time-b time-a)
    internal-time-units-per-second)))

