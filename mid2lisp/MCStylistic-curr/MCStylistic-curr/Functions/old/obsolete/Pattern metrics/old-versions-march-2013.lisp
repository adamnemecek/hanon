#| Old versions from 8/3/2013.
(defun score-matrix
       (P-occurrences Q-occurrences &optional
        (compare-fn #'cardinality-score) (tolp nil)
        (translationp nil) (mP (length P-occurrences))
        (i 0)
        (matrix-row
         (if (< i mP)
           (mapcar
            #'(lambda (x)
                (funcall
                 compare-fn (nth i P-occurrences) x
                 tolp translationp))
            Q-occurrences))))
  (if (>= i mP) ()
    (cons
     matrix-row
     (score-matrix
      P-occurrences Q-occurrences compare-fn tolp
      translationp mP (+ i 1)))))
|#




