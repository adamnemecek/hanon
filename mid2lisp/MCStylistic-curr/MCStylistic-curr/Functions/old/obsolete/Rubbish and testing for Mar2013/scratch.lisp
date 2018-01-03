

(setq
 *example-files-path*
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Example files"))
  *lisp-code-root*))
(setq
 *algorithm-path*
 (merge-pathnames
  (make-pathname
   :directory
   '(:relative
     "mirexPatternDiscoveryTask" "algorithm1output"))
  *example-files-path*))
(setq
 *piece-path*
 (merge-pathnames
  (make-pathname
   :directory
   '(:relative "beethovenOp2No1Mvt3"))
  *music-data-root*))
(metrics-for-algorithm&piece
 *algorithm-path* *piece-path*)
-->

(setq algorithm-path *algorithm-path*)
(setq piece-path *piece-path*)
(setq algorithm-idx 0)
(setq piece-idx 0)
(setq task-version "polyphonic")
(setq annotations-to-use
 (list
  "bruhn" "barlowAndMorgensternRevised"
  "sectionalRepetitions" "schoenberg"
  "tomCollins"))
(setq metrics-to-calculate
 (list
  "precision-est-card" "recall-est-card"
  "precision-occ-card" "recall-occ-card"))
(setq metric-parameters
 (list (list "score-thresh" .75)))
(setq file-type "csv")
(setq score-thresh
 (nth
  (position
   "score-thresh"
   (nth-list-of-lists 0 metric-parameters)
   :test #'equalp)
  (nth-list-of-lists 1 metric-parameters)))
(setq piece-name
 (pathname-name
  (cl-fad:pathname-as-file piece-path)))
(setq alg-out-path
 (remove-if-not
  #'directory-pathname-p
  (cl-fad:list-directory
   (merge-pathnames
    (make-pathname
     :directory (list :relative piece-name))
    algorithm-path))))
(setq Q-patt&occ
 (read-patts&occs alg-out-path file-type))
(setq annotation-paths
 (mapcar
  #'(lambda (x)
      (merge-pathnames
       (make-pathname
        :directory
        (list
         :relative
         task-version "repeatedPatterns" x))
       piece-path))
  annotations-to-use))
(setq P-patt&occ
 (read-ground-truth-for-piece
  annotation-paths file-type))
(setq nmetric (length metrics-to-calculate))
(setq metric-idx 0)

(establishment-metric P-patt&occ Q-patt&occ)

(establishment-metric
 P-patt&occ Q-patt&occ #'recall-matrix)
         
(occurrence-metric
 P-patt&occ Q-patt&occ #'precision-matrix
 #'cardinality-score nil nil
 score-thresh)
           
(occurrence-metric
 P-patt&occ Q-patt&occ
 #'recall-matrix #'cardinality-score
 nil nil score-thresh)
             


(progn
  (setq a-dataset (nth 0 (nth 3 Q-patt&occ)))
  (setq b-dataset (nth 0 (nth 3 P-patt&occ)))
  "Yes!")

(progn
  (setq S (cardinality-score a-dataset b-dataset))  
  "Yes!")

(setq tolp nil)
(setq translationp nil)
(setq vector&occ
 (most-frequent-difference-vector
  a-dataset b-dataset tolp translationp))
(progn
  (setq
   diff-list (difference-lists a-dataset b-dataset))
  "Yes!")



  
(setq
 d-dataset
 (csv2dataset
  (concatenate
   'string
   "/Users/tomthecollins/Shizz/Data/Music"
   "/gibbonsSilverSwan1612/polyphonic"
   "/repeatedPatterns/tomCollins/D/occurrences/csv"
   "/occ1.csv")))



(setq prec-rec #'precision-matrix)
(setq compare-fn #'cardinality-score)
(setq tolp nil)
(setq translationp nil)
(setq score-thresh .75)
(setq occ-mtx&rel-idx
 (occurrence-matrix&rel-idx
  P-patt&occ Q-patt&occ prec-rec compare-fn
  tolp translationp score-thresh))
(setq prec-rec-idx
 (if (equalp prec-rec #'precision-matrix)
   1 0))
(setq n
 (length
  (remove-duplicates
   (nth-list-of-lists
    prec-rec-idx
    (second occ-mtx&rel-idx))
   :test #'equalp))))







