#| Example:
(remove-translations-car
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern"
  " discovery/Write to files/L 1 (1 1 1 1 0) branches")
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern"
  " discovery/Write to files"
  "/L 1 (1 1 1 1 0) penultimate")
 7058 7058 1)
gives a file in the specified location.

This function .. |#

(defun remove-translations-car
       (origin destination partition-origin
        partition-destination number-of-files
        &optional (counter-origin 1)
        (counter-destination 1)
        (growing-list nil) (j 0)
        (TEC-indices-pairs
         (if (<= counter-origin number-of-files)
           (read-from-file
            (concatenate
             'string
             origin " "
             (write-to-string counter-origin)
             ".txt"))))
        (pattern (car (first TEC-indices-pairs)))
        (result-recent
         (assoc pattern growing-list
                :test #'test-translation))
        (result
         (if (and (> counter-destination 1)
                  (null result-recent))
           (assoc-translations
            pattern destination
            (- counter-destination 1))
           (identity result-recent))))
  (if (> counter-origin number-of-files)
    (if (null growing-list) (identity t)
      (write-to-file
       growing-list
       (concatenate
        'string
        destination " "
        (write-to-string counter-destination)
        ".txt")))
    (if (null pattern)
      (remove-translations-car
       origin destination partition-origin
       partition-destination number-of-files
       (+ counter-origin 1) counter-destination
       growing-list j)
      (if (equal j partition-destination)
        (progn
          (write-to-file
           growing-list
           (concatenate
            'string
            destination " "
            (write-to-string counter-destination)
            ".txt"))
          (remove-translations-car
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin (+ counter-destination 1)
           nil 0 TEC-indices-pairs pattern nil))
        (if result
          (remove-translations-car
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin counter-destination
           growing-list j (rest TEC-indices-pairs))
          (remove-translations-car
           origin destination partition-origin
           partition-destination number-of-files
           counter-origin counter-destination
           (append
            growing-list
            (list (list pattern))
            )
           (+ j 1) (rest TEC-indices-pairs))
          )
        )
      )
    ))


