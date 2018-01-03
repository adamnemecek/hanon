#| Old version (pre Mar 2013).
\noindent Example:
\begin{verbatim}
(setq
 dataset
 '((0 60) (1 61) (2 62) (3 60) (5 60) (5 61) (6 59)
   (6 62) (7 60) (7 63) (8 61)))
(structural-induction-algorithm-r
 dataset 1
 (merge-pathnames
  (make-pathname
   :name "SIA_r example"
   :type "txt")
  *MCStylistic-Mar2013-example-files-results-path*))
--> Writes file to the specified location.
\end{verbatim}

\noindent The first $r$ superdiagonals of the
similarity matrix for the dataset are treated in a
SIA-like fashion to form patterns. For each pattern
$P_i = \{\mathbf{p}_{i,1},\ldots,
\mathbf{p}_{i,l_i}\}$, we calculate the
vector $\mathbf{v} =
\mathbf{p}_{i,j} - \mathbf{p}_{i,1}, 2 \leq j
\leq l_i$. If this vector is not in a growing list,
then its MTP is computed and appended to the
output. |#

(defun structural-induction-algorithm-r
       (dataset r path&name &optional
        (patterns
         (collect-by-cars
          (merge-sort-by
           (subtract&retain-at-fixed-distances
            dataset r))))
        (vectors
         (remove-duplicates-sorted-asc
          (merge-sort-diff-sets-of-datapoints
           patterns))))
  (write-to-file
   (mapcar
    #'(lambda (x)
        (cons
         x (maximal-translatable-pattern x dataset)))
    vectors)
   path&name))

