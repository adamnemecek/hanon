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
  "precision" "recall" "precision-est-card"
  "recall-est-card" "precision-occ-card"
  "recall-occ-card"))
(setq metric-parameters
 (list
  (list "score-thresh" .75)
  (list "tolp" t)))
(setq file-type "csv")
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
    (nth-list-of-lists 1 metric-parameters))
   .75))
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
(setq piece-name
 (pathname-name
  (cl-fad:pathname-as-file *piece-path*)))
(setq alg-out-path
 (remove-if-not
  #'directory-pathname-p
  (cl-fad:list-directory
   (merge-pathnames
    (make-pathname
     :directory (list :relative piece-name))
    *algorithm-path*))))
(setq Q-patt&occ
 (read-patts&occs alg-out-path file-type))
"Yes!"
(setq annotation-paths
 (mapcar
  #'(lambda (x)
      (merge-pathnames
       (make-pathname
        :directory
        (list
         :relative
         task-version "repeatedPatterns" x))
       *piece-path*))
  annotations-to-use))
(setq P-patt&occ
 (read-ground-truth-for-piece
  annotation-paths file-type))
"Yes!"
(setq nmetric (length metrics-to-calculate))
(setq metric-idx 0)

(if Q-patt&occ "yes" "no")
(length P-patt&occ)

(mapcar
 #'(lambda (x) (float x)) 
 '(4/11 4/7 2892415327/3967092624 716031/740761
   12832195/13545344 716031/740761))











(defun metrics-for-algorithm&piece
       (algorithm-path piece-path &optional
        (algorithm-idx 0) (piece-idx 0)
        (task-version "polyphonic")
        (annotations-to-use
         (list
          "bruhn" "barlowAndMorgensternRevised"
          "sectionalRepetitions" "schoenberg"
          "tomCollins"))
        (metrics-to-calculate
         (list
          "precision" "recall" "precision-est-card"
          "recall-est-card" "precision-occ-card"
          "recall-occ-card"))
        (metric-parameters
         (list
          (list "score-thresh" .75)
          (list "tolp" t)))
        (file-type "csv")
        (score-thresh
         (if (find
              "score-thresh"
              (nth-list-of-lists 0 metric-parameters)
              :test #'equalp)
           (nth
            (position
             "score-thresh"
             (nth-list-of-lists 0 metric-parameters)
             :test #'equalp)
            (nth-list-of-lists 1 metric-parameters))
           .75))
        (tolp
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
        (translationp
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
        (card-limit
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
        (piece-name
         (pathname-name
          (cl-fad:pathname-as-file piece-path)))
        (alg-out-path
         (remove-if-not
          #'directory-pathname-p
          (cl-fad:list-directory
           (merge-pathnames
            (make-pathname
             :directory (list :relative piece-name))
            algorithm-path))))
        (Q-patt&occ
         (read-patts&occs alg-out-path file-type))
        (annotation-paths
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
        (P-patt&occ
         (read-ground-truth-for-piece
          annotation-paths file-type))
        (nmetric (length metrics-to-calculate))
        (metric-idx 0))
  (if (>= metric-idx nmetric) ()
    (progn
      (format
       t
       (concatenate
        'string "Calculating for algorithm ~D, piece"
        " ~D, metric ~D~%")
       (+ algorithm-idx 1) (+ piece-idx 1)
       (+ metric-idx 1))
      (cons
       (if (string=
            (nth metric-idx metrics-to-calculate)
            "precision")
         (establishment-metric
          P-patt&occ Q-patt&occ #'precision-matrix
          #'equalp-score tolp)
         (if (string=
              (nth metric-idx metrics-to-calculate)
              "recall")
           (establishment-metric
            P-patt&occ Q-patt&occ #'recall-matrix
            #'equalp-score tolp)
           (if (string=
                (nth metric-idx metrics-to-calculate)
                "precision-est-card")
             (establishment-metric
              P-patt&occ Q-patt&occ #'precision-matrix
              #'cardinality-score tolp translationp)
             (if (string=
                  (nth
                   metric-idx metrics-to-calculate)
                  "recall-est-card")
               (establishment-metric
                P-patt&occ Q-patt&occ #'recall-matrix
                #'cardinality-score tolp translationp)
               (if (string=
                    (nth
                     metric-idx metrics-to-calculate)
                    "precision-occ-card")
                 (occurrence-metric
                  P-patt&occ Q-patt&occ
                  #'precision-matrix
                  #'cardinality-score tolp
                  translationp score-thresh)
                 (if (string=
                      (nth
                       metric-idx
                       metrics-to-calculate)
                      "recall-occ-card")
                   (occurrence-metric
                    P-patt&occ Q-patt&occ
                    #'recall-matrix
                    #'cardinality-score tolp
                    translationp score-thresh)
                   (if (string=
                        (nth
                         metric-idx
                         metrics-to-calculate)
                        "precision-est-match")
                     (establishment-metric
                      P-patt&occ Q-patt&occ
                      #'precision-matrix
                      #'matching-score tolp
                      translationp card-limit)
                     (if (string=
                          (nth
                           metric-idx
                           metrics-to-calculate)
                          "recall-est-match")
                       (establishment-metric
                        P-patt&occ Q-patt&occ
                        #'recall-matrix
                        #'matching-score
                        tolp translationp card-limit)
                       (if (string=
                            (nth
                             metric-idx
                             metrics-to-calculate)
                            "precision-occ-match")
                         (occurrence-metric
                          P-patt&occ Q-patt&occ
                          #'precision-matrix
                          #'matching-score tolp
                          translationp card-limit
                          score-thresh)
                         (if (string=
                              (nth
                               metric-idx
                               metrics-to-calculate)
                              "recall-occ-match")
                           (occurrence-metric
                            P-patt&occ Q-patt&occ
                            #'recall-matrix
                            #'matching-score tolp
                            translationp card-limit
                            score-thresh)))))))))))
       (metrics-for-algorithm&piece
        algorithm-path piece-path algorithm-idx
        piece-idx task-version annotations-to-use
        metrics-to-calculate metric-parameters
        file-type score-thresh tolp translationp
        card-limit piece-name alg-out-path Q-patt&occ
        annotation-paths P-patt&occ nmetric
        (+ metric-idx 1))))))












(defun pattern-discovery-metrics
       (algorithm-output-paths ground-truth-paths
        &optional
        (csv-save-path&name nil)
        (task-version "polyphonic")
        (annotations-to-use
         (list
          "bruhn" "barlowAndMorgensternRevised"
          "sectionalRepetitions" "schoenberg"
          "tomCollins"))
        (metrics-to-calculate
         (list
          "precision-est-card" "recall-est-card"
          "precision-occ-card" "recall-occ-card"))
        (metric-parameters
         (list
          (list "score-thresh" .75)
          (list "tolp" t)))
        (file-type "csv")
        (nalg (length algorithm-output-paths))
        (ngtr (length ground-truth-paths))
        (nmet (length metrics-to-calculate))
        (metric-mtx
         (loop for i from 0 to (- nalg 1) collect
           (loop for j from 0 to (- ngtr 1) collect
             (metrics-for-algorithm&piece
              (nth i algorithm-output-paths)
              (nth j ground-truth-paths) i j
              task-version annotations-to-use
              metrics-to-calculate metric-parameters
              file-type))))
        (file
         (if csv-save-path&name
           (open
            csv-save-path&name
            :direction :output :if-does-not-exist
            :create :if-exists :overwrite)))
        )
  (if (null csv-save-path&name)
    metric-mtx
    (progn
      (loop for i from 0 to (- nalg 1) do
        (progn
          (format
           file "~S~%"
           (nth i algorithm-output-paths))
          (format file "piece,")
          (loop for k from 0 to (- nmet 2) do
             (format
              file "~S,"
              (nth k metrics-to-calculate)))
          (format
           file "~S~%" (my-last metrics-to-calculate))
          (loop for j from 0 to (- ngtr 1) do
            (progn
              (format
               file "~S," (nth j ground-truth-paths))
              (loop for k from 0 to (- nmet 2) do
                (format
                 file "~5$,"
                 (nth k (nth j (nth i metric-mtx)))))
              (format
               file "~5$~%"
               (my-last
                (nth j (nth i metric-mtx)))))))
        (format file "~%~%"))
      (close file))))






