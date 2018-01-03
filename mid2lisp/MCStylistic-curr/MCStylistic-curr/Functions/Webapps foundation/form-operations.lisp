#| Copyright 2008-2013 Tom Collins
   Monday 15 March 2010
   Incomplete

These lisp functions help with using html forms to
display and update variables in the lisp environment.
If you are not already in the web package in Emacs,
steps 1-7 below should help.

1 Load the packages from Chapter 26 and
2 AllegroServe.
3 Create a new package.
4 Get into new package. 
5 Start a server listening on port 2001. Pointing a
  browser to http://localhost:2001/ should come up
  with an AllegroServe error.
6 Default value for this variable is 10, which
  results in ellipses where we really do not want
  them.
7 Default value for this variable is t, which results
  in problems writing/reading text files.

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(oos 'load-op :chapter-26)
(require :aserve)
(defpackage :com.gigamonkeys.web
  (:use :cl :net.aserve :com.gigamonkeys.html))
(in-package :com.gigamonkeys.web)
(start :port 2001)
(setq *print-length* nil)
(setq *print-pretty* nil)
|#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "csv-files"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "kern"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "text-files"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))

#| Example:
(forwardslash-positions "3/4/zebra")
gives
(1 3).

This function returns the positions at which
backslahses occur in a string. |#

(defun forwardslash-positions
       (string &optional (start 0)
        (local-result
         (position #\/
                   (subseq string start)))
        (result
         (if local-result
           (+ start local-result))))
  (if (null result) ()
    (cons result
          (forwardslash-positions
	   string (+ result 1)))))

#| Example:
(indicator-for-string
 '("yes" "please" "no" "yes") "yes")
gives
(T NIL NIL T).

If the nth string in a list of strings is equal to the
second argument, a probe string, then the nth element
of the output vector is t; nil otherwise. |#

(defun indicator-for-string (list-of-strings probe)
  (if (null list-of-strings) ()
    (cons
     (string= (first list-of-strings) probe)
     (indicator-for-string (rest list-of-strings)
                           probe))))

#| Example:
(indices-strings-1st-occur
 (list "Aug" "Feb")
 (list "Jan" "Feb" "Mar" "Apr" "May" "Jun"
       "Jul" "Aug" "Sep" "Oct" "Nov" "Dec" "Feb"))
gives
(7 1).

Returns indices at which the strings in the first list
appear for the first time in the second. |#

(defun indices-strings-1st-occur
       (list-of-strings list-to-probe)
  (if (null list-of-strings) ()
    (cons
     (position (first list-of-strings)
	       list-to-probe :test #'string=)
     (indices-strings-1st-occur
      (rest list-of-strings) list-to-probe))))

#|
\noindent Example:
\begin{verbatim}
(move-mth-to-nth
 2 4 '("a" "u" "t" "j" "e" "d" "c"))
--> ("a" "u" "j" "e" "t" "d" "c").
\end{verbatim}

\noindent Moves the mth element of a list to the
nth element, counting from zero. |#

(defun move-mth-to-nth (m n a-list)
  (if (< m n)
    (append
     (subseq a-list 0 m)
     (subseq a-list (+ m 1) (+ n 1))
     (list (nth m a-list))
     (subseq a-list (+ n 1)))
    (if (> m n)
      (append
       (subseq a-list 0 n)
       (list (nth m a-list))
       (subseq a-list n m)
       (subseq a-list (+ m 1)))
      (identity a-list))))

#| This function will develop into something more than
just reading a request.

(defun params-to-list (request entity)
  (with-http-response
      (request entity :content-type "text/html")
    (with-http-body (request entity)
      (with-html-output
          ((request-reply-stream request))
        (progn
          (setq *request*
                (request-query request))       
        (write-to-file
           (request-query request)
           "/Users/tec69/Desktop/request.txt")
          (html
           (:html
            (:head (:title "Changes submitted")
                   (:meta
                    :http-equiv "refresh"
                    :content
"0.1;url=http://localhost:2001/main-page"))
            (:body
             (:p "Loading simple form.")
             ))))))))

(publish :path "/params-to-list"
         :function 'params-to-list)
|#

#| Example:
(point-positions "3/4/.zebra")
gives
(4).

This function returns the positions at which full
stops occur in a string. |#

(defun point-positions
       (string &optional (start 0)
        (local-result
         (position #\.
                   (subseq string start)))
        (result
         (if local-result
           (+ start local-result))))
  (if (null result) ()
    (cons result
          (point-positions
	   string (+ result 1)))))

#| Example:
(rational-string2rational "6/8/5/zebra")
gives
3/4.

This function turns a forwardslash-separated string
into a rational, where this is possible. |#

(defun rational-string2rational
       (rational-string &optional
	(point-positioned
	 (point-positions rational-string))
	(forwardslash-positioned
	 (forwardslash-positions rational-string))
	(numerator
	 (if (not point-positioned)
	   (parse-integer
	    (subseq
	     rational-string
	     0 (first forwardslash-positioned))
	    :junk-allowed t)))
	(denominator
	 (if (first forwardslash-positioned)
	   (parse-integer
	    (subseq
	     rational-string
	     (+ (first forwardslash-positioned) 1)
	     (second forwardslash-positioned))
	    :junk-allowed t))))
  (if (and numerator denominator
	   (not (zerop denominator)))
    (/ numerator denominator)
    (identity numerator)))

#| Example:
(read-from-strings
 '("yes" "please"))
gives
(YES PLEASE).

Applies the function read-from-string recursively to a
list of strings. This is no longer required
hopefully! |#

(defun read-from-strings (list-of-strings)
  (if (null list-of-strings) ()
    (cons
     (read-from-string
      (first list-of-strings))
     (read-from-strings
      (rest list-of-strings)))))

#|
\noindent Example:
\begin{verbatim}
(setq A (make-hash-table :test #'equal))
(setf (gethash '"hair colour" A) "brown")
(setf (gethash '"gender" A) "male")
(setq
 form-list
 '(("gender" . "female") ("eye colour" . "green")
   ("hair colour" . "brown")))
(disp-ht-el A)
(update-hash-table-with-form-list form-list A)
(disp-ht-el A)
--> (("gender" . "male") ("hair colour" . "brown"))
--> (("gender" . "female")
     ("hair colour" . "brown")
     ("eye colour" . "green")).
\end{verbatim}

\noindent This function takes a submitted form, in
the form of a list of key-value pairs, and uses
this information to update (either replacing or
creating) entries in the hash table supplied as the
second argument. |#

(defun update-hash-table-with-form-list
       (form-list hash-table)
  (mapcar
   #'(lambda (x)
       (setf
        (gethash
         (car x) hash-table) (cdr x)))
   form-list)
  hash-table)
