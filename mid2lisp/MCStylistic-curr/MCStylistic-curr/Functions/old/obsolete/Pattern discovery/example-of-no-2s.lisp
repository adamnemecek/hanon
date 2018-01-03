
#| This dataset is interesting in that it no MTP in
the dataset has a TEC with cardinality 2. (All TECs
have cardinality 1, 3 or 9.

(setq
 dataset
 '((1 1) (1 2) (2 2) (2 4) (2 5) (3 5)
   (6 2) (6 3) (7 3)))

(reflected-SIA-scaling
 dataset
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/3-point-pat")
 50)

(remove-translations
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/3-point-pat")
 (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/3-point-pat translations"
  " translations")
 50 50 1)
