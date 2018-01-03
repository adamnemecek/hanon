#| Some calls to make the functions from Siebel's book
work. |#
(defpackage :com.gigamonkeys.macro-utilities
  (:use :common-lisp)
  (:export 
   :with-gensyms
   :with-gensymed-defuns
   :once-only
   :spliceable
   :ppme))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31/chapter-31.asd"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31/html.asd"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter26/chapter-26.asd"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter26/url-function.asd"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31/packages.lisp"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31/html.lisp"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31/css.lisp"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter31"
  "/embed-foo-with-conditions-and-restarts.lisp"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter26/packages.lisp"))
(load
 (concatenate
  'string
  "/Applications/lispbox-0.7/practicals-1.0.3"
  "/Chapter26/html-infrastructure.lisp"))









