
(setq
 SIA-output
 '(((18 -5 0)
    (0 68 1/2) (1/2 66 1/2) (3/2 63 1/2) (5/2 61 1/2)
    (31 71 1/2) (67/2 78 1/2) (69/2 75 1/2) (39 66 3)
    (55 78 1/2) (147/2 75 1/2) (74 76 1/2)
    (117 66 3/2) (235/2 68 1/2) (118 69 1/2)
    (237/2 64 1/2) (237/2 73 1/2) (119 78 3/2)
    (239/2 61 1/2) (241/2 76 1/2) (243/2 73 1/2)
    (315/2 52 1/2) (323/2 68 1/2) (329/2 68 1/2)
    (339/2 61 1/2) (171 56 1/2) (377/2 73 1/2)
    (209 49 1))
   ((107/2 0 0)
    (0 68 1/2) (17/2 49 1/2) (88 76 1/2)
    (191/2 54 1/2) (96 51 1/2) (193/2 52 1/2)
    (97 51 1/2) (195/2 49 1/2) (100 78 1/2)
    (201/2 76 1/2) (124 68 1/2) (257/2 68 1/2)
    (155 76 1/2) (337/2 64 1/2) (169 63 1/2)
    (339/2 61 1/2) (173 49 1/2))
   ((209/2 -5 0)
    (5/2 61 1/2) (29/2 68 1/2) (24 73 1/2) (28 78 1/2)
    (29 75 1/2) (59/2 73 1/2) (30 71 1/2)
    (61/2 69 1/2) (34 76 1/2) (35 73 1/2) (56 78 1/2)
    (73 73 1/2) (153/2 73 1/2) (213/2 54 1/2)
    (243/2 57 1/2) (122 71 1/2))
   ((96 -29 0)
    (3 73 3/2) (54 81 1/2) (109/2 80 1/2) (55 78 1/2)
    (111/2 76 1/2) (56 78 1/2) (195/2 75 1/2)
    (237/2 73 1/2))))
(load
 (concatenate
  'string
  "//Applications/CCL/Lisp code/Pattern discovery"
  "/Bach preludes/BWV 849.lisp"))
(progn
  (setq
   projected-dataset
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (setq
   path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/SIACT/Write to files"
    "/CT<-> example2.txt")))
(progn (setq dataset projected-dataset) "Yes!")

(setq compactness-threshold 2/3)
(setq cardinality-threshold 5)
(setq region-type "lexicographic")
(setq growing-list nil)
(setq subpatterns
	 (compact-subpatterns
	  (cdr (first SIA-output)) dataset
	  compactness-threshold cardinality-threshold
	  region-type))
(setq nested-subpatterns&compactness
	 (mapcar
	  #'(lambda (x)
	      (compact-subpatterns<-more-output
	       x dataset compactness-threshold
	       cardinality-threshold region-type))
	  subpatterns))
(setq subpatterns&compactness
	 (mapcar
	  #'(lambda (x)
	      (append
	       (list (first (first x)))
	       (list (first (second x)))))
	  nested-subpatterns&compactness))
(setq probes
	 (mapcar
	  #'(lambda (x) (first x))
	  subpatterns&compactness))
(setq compactness-values
	 (mapcar
	  #'(lambda (x) (second x))
	  subpatterns&compactness))
(setq probe (first probes))
(setq compactness-value (first compactness-values))
(setq result
	 (if probe
	   (assoc
	    probe growing-list
	    :test #'test-translation)))

(setq
 growing-list
 (cons
	  (cons
	   probe
	   (list compactness-value
		 (car (first SIA-output))))
	  growing-list))
(setq probes (rest probes))
(setq compactness-values (rest compactness-values))

(setq SIA-output (rest SIA-output))



