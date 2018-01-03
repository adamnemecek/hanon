#| Tom Collins, 15/8/2013.
I wrote these functions to snake over the rational
numbers and return a list of zoom options for
freshjam. |#

(first-n-rats-as-strings 136)
(first-n-rats-as-floats 150)

(defun first-n-rats-as-strings
       (n &optional (i 1) (j 1) (k 0) (switch nil))
  (if (>= k n) ()
    (if (and (equalp j 1) (equalp i 1))
      (cons
       (write-to-string (/ i j))
       (first-n-rats-as-strings
        n (+ i 1) j (+ k 1) switch))
      (if (equalp j 1)
        (if switch
          (cons
           (write-to-string (/ i j))
           (first-n-rats-as-strings
            n (+ i 1) j (+ k 1) nil))
          (cons
           (write-to-string (/ i j))
           (first-n-rats-as-strings
            n (- i 1) (+ j 1) (+ k 1) switch)))
        (if (equalp i 1)
          (if (not switch)
            (cons
             (write-to-string (/ i j))
             (first-n-rats-as-strings
              n i (+ j 1) (+ k 1) t))
            (cons
             (write-to-string (/ i j))
             (first-n-rats-as-strings
              n (+ i 1) (- j 1) (+ k 1) switch)))
          (if switch
            (cons
             (write-to-string (/ i j))
             (first-n-rats-as-strings
              n (+ i 1) (- j 1) (+ k 1) switch))
            (cons
             (write-to-string (/ i j))
             (first-n-rats-as-strings
              n (- i 1) (+ j 1) (+ k 1) switch))))))))


(defun first-n-rats-as-floats
       (n &optional (i 1) (j 1) (k 0) (switch nil))
  (if (>= k n) ()
    (if (and (equalp j 1) (equalp i 1))
      (cons
       (float (/ i j))
       (first-n-rats-as-floats
        n (+ i 1) j (+ k 1) switch))
      (if (equalp j 1)
        (if switch
          (cons
           (float (/ i j))
           (first-n-rats-as-floats
            n (+ i 1) j (+ k 1) nil))
          (cons
           (float (/ i j))
           (first-n-rats-as-floats
            n (- i 1) (+ j 1) (+ k 1) switch)))
        (if (equalp i 1)
          (if (not switch)
            (cons
             (float (/ i j))
             (first-n-rats-as-floats
              n i (+ j 1) (+ k 1) t))
            (cons
             (float (/ i j))
             (first-n-rats-as-floats
              n (+ i 1) (- j 1) (+ k 1) switch)))
          (if switch
            (cons
             (float (/ i j))
             (first-n-rats-as-floats
              n (+ i 1) (- j 1) (+ k 1) switch))
            (cons
             (float (/ i j))
             (first-n-rats-as-floats
              n (- i 1) (+ j 1) (+ k 1) switch))))))))








