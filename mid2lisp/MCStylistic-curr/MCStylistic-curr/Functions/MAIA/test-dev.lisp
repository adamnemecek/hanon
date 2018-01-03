
(setq
 attrb
 (melody2ASSA-attributes
  '((-1 68 65 1 0) (0 70 66 1 0) (1 67 64 2 0)
    (3 68 65 1 0) (4 65 63 2 0) (6 64 62 3/2 0)
    (15/2 65 63 1/2 0) (8 67 64 1 0) (9 70 66 1 0)
    (10 68 65 1 0))
   3 fpath fname))

(setq
 fpath&name
 (merge-pathnames
  (make-pathname
   :name "assa-attrb" :type "csv")
  *example-files-path*))

(list-of-lists2csv attrb fpath&name)

(setq
(list-of-lists2csv
 (list
 (list 1 (float 1/3)) (list 0 0)) fpath&name)
