; This is the root for current Lisp code.
(defvar
    *lisp-code-root*
  (make-pathname
   :directory
   '(:absolute
     "Users" "tomthecollins" "Shizz" "AppCode" "CCL"
     "Lisp code")))

#| Old style.
(defvar
    *lisp-code-root*
  "/Users/tomthecollins/Shizz/AppCode/CCL/Lisp code")
|#

; This is where music data is stored.
(defvar
    *music-data-root*
  (make-pathname
   :directory
   '(:absolute
     "Users" "tomthecollins" "Shizz" "Data" "Music")))

#| Old style.
(defvar
    *music-data-root*
  "/Users/tomthecollins/Shizz/Data/Music")
|#

; This is where example files are stored.
(defvar
    *example-files-path*
  (merge-pathnames
   (make-pathname
    :directory '(:relative "Example files"))
   *lisp-code-root*))
