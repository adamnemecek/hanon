(in-package :common-lisp-user)

(defun ontime-percentage
       (datapoint dataset &optional
        (duration-index 1)
        (total-duration
         (max-item
          (nth-list-of-lists
           (length (first dataset))
           (append-offtimes dataset
                            duration-index)))))
  (float
   (* 100 (/ (first datapoint) total-duration))))

(defun ontime-percentages
       (datapoints &optional
        (dataset datapoints)
        (duration-index 1)
        (total-duration
         (max-item
          (nth-list-of-lists
           (length (first dataset))
           (append-offtimes dataset
                            duration-index)))))
  (if (null datapoints) ()
    (cons
     (ontime-percentage
      (first datapoints) dataset
       duration-index total-duration)
     (ontime-percentages
      (rest datapoints) dataset
      duration-index total-duration))))

#|
(setq *D* '((0 1/2) (1 1) (2 1/2) (3 1) (4 1) (5 1/4) (5 1) (23/4 1/4) (6 1/2) (6 1) (13/2 1/2) (7 3/4) (7 1) (31/4 1/4) (8 1/2) (8 5/3) (35/4 13/40) (109/12 13/40) (113/12 1/4) (29/3 1) (29/3 3/2) (32/3 1) (67/6 1/2) (35/3 3/4) (35/3 1) (149/12 1/4) (38/3 1/2) (38/3 1) (41/3 1/2) (41/3 1) (85/6 1/2) (44/3 1) (47/3 1/4) (47/3 3/4) (197/12 1/4) (50/3 1/2) (50/3 1) (50/3 2) (103/6 1/2) (53/3 1) (56/3 1/2) (56/3 1) (115/6 1/2) (59/3 1)))
|#