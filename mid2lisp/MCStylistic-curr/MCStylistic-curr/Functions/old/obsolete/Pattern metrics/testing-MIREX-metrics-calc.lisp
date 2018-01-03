#| Copyright 2008-2011 Tom Collins
   Friday 12 August 2011

Stylistic composition with Racchmaninof-Oct2010

This code demonstrates |#

; These can stay where they are.
(setq
 *algorithms-output-root*
 (merge-pathnames
  (make-pathname
   :directory
   '(:relative "MIREX 2013 pattern discovery task"))
  *MCStylistic-Mar2013-example-files-path*))
(setq *task-version* "polyphonic")
(setq
 *annotations-poly*
 (list
  "bruhn" "barlowAndMorgensternRevised"
  "sectionalRepetitions" "schoenberg" "tomCollins"))
(setq
 *annotations-mono*
 (list
  "bruhn" "barlowAndMorgenstern"
  "barlowAndMorgensternRevised" "sectionalRepetitions"
  "schoenberg" "tomCollins"))

(setq
 *ground-truth-paths*
 ; (cl-fad:list-directory *jkuPattsDevDB-Mar2013-path*
 ; For now, restrict to a few folders.
 (list
  #P"/Users/tomcollins/Dropbox/temp/jkuPattsDevDB/beethovenOp2No1Mvt3/"
  #P"/Users/tomcollins/Dropbox/temp/jkuPattsDevDB/gibbonsSilverSwan1612/"
  ))
(setq
 *algorithm-output-paths*
 ; (cl-fad:list-directory *algorithms-output-root*
 ; For now, restrict to a few folders.
 (list
  #P"/Users/tomcollins/Dropbox/temp/MCStylistic-Mar2013/Example files/MIREX 2013 pattern discovery task/algorithm1output/"
  #P"/Users/tomcollins/Dropbox/temp/MCStylistic-Mar2013/Example files/MIREX 2013 pattern discovery task/algorithm2output/"
  #P"/Users/tomcollins/Dropbox/temp/MCStylistic-Mar2013/Example files/MIREX 2013 pattern discovery task/algorithm3output/"
  #P"/Users/tomcollins/Dropbox/temp/MCStylistic-Mar2013/Example files/MIREX 2013 pattern discovery task/algorithm6output/"
))
; Save the calculated metrics to this csv file.
(setq
 *csv-save-path&name*
 (merge-pathnames
  (make-pathname
   :name "calculated-metrics" :type "csv")
  *MCStylistic-Mar2013-example-files-path*))

#|
(setq
 *metrics-to-calculate*
 (list
  "precision-est-card" "recall-est-card"
  "precision-occ-card" "recall-occ-card"))
|#
(setq
 *metrics-to-calculate*
 (list
  "precision" "recall" "precision-est-card"
  "recall-est-card" "precision-occ-card"
  "recall-occ-card"))
#|
(setq
 *metrics-to-calculate*
 (list
  "precision-est-card" "recall-est-card"
  "precision-occ-card" "recall-occ-card"
  "precision-est-match" "recall-est-match"))
|#
(setq
 *metric-parameters*
 (list
  (list "score-thresh" .75) (list "tolp" t)
  (list "translationp" nil) (list "card-limit" 150)))
(setq *file-type* "csv")

(setq
 *ans*
 (pattern-discovery-metrics
  *algorithm-output-paths* *ground-truth-paths*
  *csv-save-path&name* *task-version*
  *annotations-poly* *metrics-to-calculate*
  *metric-parameters* *file-type*))















#| SHOULD BE ABLE TO REMOVE THIS CODE, AS EVERYTHING
WILL BE LOADED AUTOMATICALLY.

(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Pattern metrics")
   :name "process-annotated-patterns"
   :type "lisp")
  *lisp-code-root*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Pattern metrics")
   :name "robust-metrics"
   :type "lisp")
  *lisp-code-root*))

; This one needs moving to setup.
(defvar
    *jkuPattsDevDB-root*
  (merge-pathnames
    (make-pathname
     :directory
     '(:relative
       ; "folder1" "folder2, etc."
       ))
    *music-data-root*))
 |#








(setq algorithm-output-paths *algorithm-output-paths*)
(setq ground-truth-paths *ground-truth-paths*)
(setq metrics-to-calculate *metrics-to-calculate*)

(setq nalg (length *algorithm-output-paths*))
(setq ngtr (length *ground-truth-paths*))
(setq nmet (length *metrics-to-calculate*))
(setq metric-mtx *ans*)
(setq csv-save-path&name *csv-save-path&name*)
(setq file
      (if csv-save-path&name
        (open
         csv-save-path&name
         :direction :output :if-does-not-exist
         :create :if-exists :overwrite)))


(setq
 *algorithm-path* (nth 1 *algorithm-output-paths*))
(setq *piece-path* (nth 2 *ground-truth-paths*))
(setq
 *ans*
 (metrics-for-algorithm&piece
  *algorithm-path* *piece-path* 0 0 *task-version*
  *annotations-poly* *metrics-to-calculate*
  *metric-parameters*))

(mapcar #'(lambda (x) (float x)) *ans*)
























(setq metric-parameters
         (list
          (list "score-thresh" .75)
          (list "tolp" t)))
(setq score-thresh
 (if (find
      "score-thresh"
      (nth-list-of-lists 0 metric-parameters)
      :test #'equalp)
   (nth
    (position
     "score-thresh"
     (nth-list-of-lists 0 metric-parameters)
     :test #'equalp)
    (nth-list-of-lists 1 metric-parameters))))
(setq tolp
 (if (find
      "tolp"
      (nth-list-of-lists 0 metric-parameters)
      :test #'equalp)
   (nth
    (position
     "tolp"
     (nth-list-of-lists 0 metric-parameters)
     :test #'equalp)
    (nth-list-of-lists 1 metric-parameters))))
(setq translationp
 (if (find
      "translationp"
      (nth-list-of-lists 0 metric-parameters)
      :test #'equalp)
   (nth
    (position
     "translationp"
     (nth-list-of-lists 0 metric-parameters)
     :test #'equalp)
    (nth-list-of-lists 1 metric-parameters))))
(setq card-limit
 (if (find
      "card-limit"
      (nth-list-of-lists 0 metric-parameters)
      :test #'equalp)
   (nth
    (position
     "card-limit"
     (nth-list-of-lists 0 metric-parameters)
     :test #'equalp)
    (nth-list-of-lists 1 metric-parameters))
   100))







(setq metric-idx 4)
(string=
 (nth
  metric-idx *metrics-to-calculate*)
 "precision-est-match")

(setq piece-name
         (pathname-name
          (cl-fad:pathname-as-file *piece-path*)))
(setq
 alg-out-path
 (remove-if-not
  #'directory-pathname-p
  (cl-fad:list-directory
   (merge-pathnames
    (make-pathname
     :directory (list :relative piece-name))
    *algorithm-path*))))
(setq
 Q-patt&occ
 (read-patts&occs alg-out-path "csv"))
(setq
 annotation-paths
 (mapcar
  #'(lambda (x)
      (merge-pathnames
       (make-pathname
        :directory
        (list
         :relative
         *task-version* "repeatedPatterns" x))
       *piece-path*))
  *annotations-poly*))
(setq P-patt&occ
         (read-ground-truth-for-piece
          annotation-paths "csv"))
"Yes!"
(setq metric-parameters *metric-parameters*)
(setq score-thresh
      (if (find
           "score-thresh"
           (nth-list-of-lists 0 metric-parameters)
           :test #'equalp)
        (nth
         (position
          "score-thresh"
          (nth-list-of-lists 0 metric-parameters)
          :test #'equalp)
         (nth-list-of-lists 1 metric-parameters))))
(setq tolp
      (if (find
           "tolp"
           (nth-list-of-lists 0 metric-parameters)
           :test #'equalp)
        (nth
         (position
          "tolp"
          (nth-list-of-lists 0 metric-parameters)
          :test #'equalp)
         (nth-list-of-lists 1 metric-parameters))))
(setq translationp
      (if (find
           "translationp"
           (nth-list-of-lists 0 metric-parameters)
           :test #'equalp)
        (nth
         (position
          "translationp"
          (nth-list-of-lists 0 metric-parameters)
          :test #'equalp)
         (nth-list-of-lists 1 metric-parameters))))
(setq card-limit
      (if (find
           "card-limit"
           (nth-list-of-lists 0 metric-parameters)
           :test #'equalp)
        (nth
         (position
          "card-limit"
          (nth-list-of-lists 0 metric-parameters)
          :test #'equalp)
         (nth-list-of-lists 1 metric-parameters))))


(setq prec-rec #'precision-matrix)
(setq compare-fn #'matching-score)
(setq establish-mtx
      (establishment-matrix
       P-patt&occ Q-patt&occ compare-fn tolp
       translationp card-limit))
(setq nP (length P-patt&occ))
(setq i 0)
(setq matrix-row
      (if (< i nP)
        (mapcar
         #'(lambda (x)
             (max-matrix
              (score-matrix
               (nth i P-patt&occ) x compare-fn tolp
               translationp card-limit)))
         Q-patt&occ)))

(score-matrix
 (nth i P-patt&occ) (nth i Q-patt&occ) compare-fn tolp
 translationp card-limit)

(setq P-occurrences (nth 0 P-patt&occ))
(setq Q-occurrences (nth 0 Q-patt&occ))

(setq mP (length P-occurrences)) (setq i 0)

(setq matrix-row
         (if (< i mP)
           (mapcar
            #'(lambda (x)
                (if (equalp
                     compare-fn #'cardinality-score)
                  (cardinality-score 
                   (nth i P-occurrences) x tolp
                   translationp)
                  (matching-score
                   (nth i P-occurrences) x
                   card-limit)))
            Q-occurrences)))

(matching-score
 (nth 0 P-occurrences) (nth 1 Q-occurrences)
 card-limit)

(matching-score
 (nth i P-occurrences) x
 card-limit)

(setq a-dataset (nth 0 P-occurrences))
(setq b-dataset (nth 1 Q-occurrences))

(matching-score a-dataset b-dataset card-limit)
(setq n1 5)
(setq n2 5)
(setq d .05) 
(setq trans-invar nil)
(setq res 1)
(setq flexitime nil)
(setq calcp
      (<=
       (max (length a-dataset) (length b-dataset))
       card-limit))
(setq a-fgp
         (if calcp
           (symbolic-fingerprint
            a-dataset "a" n1 n2 d trans-invar)))
(setq b-fgp
         (if calcp
           (symbolic-fingerprint
            b-dataset "b" n1 n2 d trans-invar)))
(setq hist
         (if calcp
           (matching-score-histogram
            a-fgp b-fgp res flexitime)))


(setq X-fgp a-fgp) (setq Y-fgp b-fgp)
(setq XY-idx
         (matching-lists-indices
          (nth-list-of-lists 0 X-fgp)
          (nth-list-of-lists 0 Y-fgp)
          flexitime))
(setq X-idx (first XY-idx))
(setq Y-idx (second XY-idx))
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



(establishment-metric
 P-patt&occ Q-patt&occ
 #'precision-matrix #'matching-score
 tolp translationp card-limit)













#| Let's grab a |#


#|
\noindent Example:
\begin{verbatim}
(most-frequent-difference-vector
 '((0 59) (1/2 60) (1 60) (2 62))
 '((0 59) (0 64) (1/2 60) (1 61) (2 62.000001)) t)
--> ((0 0) 3).
\end{verbatim}

\noindent Returns the most frequent difference vector
between two point sets, and the . |#

(defun most-frequent-difference-vector
       (a-list b-list &optional (tolp nil)
        (translationp nil)
        (a-sorted (sort-dataset-asc a-list))
        (b-sorted (sort-dataset-asc b-list))
        (delta-ab
         (difference-lists a-sorted b-sorted))
        (freq-count
         (frequency-count delta-ab tolp))
        (zero-vector
         (if (not translationp)
           (constant-vector
            0 (length (first a-list)))))
        (max-freq-or-index
         (if translationp
           (max-argmax
            (nth-list-of-lists 1 freq-count))
           (if tolp
             (position
              zero-vector
              (nth-list-of-lists 0 freq-count)
              :test #'equal-up-to-tol)
             (position
              zero-vector
              (nth-list-of-lists 0 freq-count)
              :test #'equalp)))))
  (if translationp
    (list
     (first
      (nth (second max-freq-or-index) freq-count))
     (first max-freq-or-index))
    (list
     (first
      (nth max-freq-or-index freq-count))
     (second
      (nth max-freq-or-index freq-count)))))





