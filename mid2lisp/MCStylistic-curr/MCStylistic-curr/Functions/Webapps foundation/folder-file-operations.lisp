#| Copyright 2008-2013 Tom Collins
   Thursday 8 April 2010
   Incomplete

As part of most web applications, the user has to be
able to organise their files in folders of their own
choosing. These functions are the ground work for
achieving this aim. |#

; REQUIRED PACKAGES
; (in-package :common-lisp-user)
(load
 (merge-pathnames
  (make-pathname
   :directory '(:relative "File conversion")
   :name "text-files"
   :type "lisp")
  *MCStylistic-MonthYear-functions-path*))

#|
\noindent Example:
\begin{verbatim}
(setq *a-string* "String quartet")
(setq *permissible-characters* " Saeginqrtu")
(alpha-numeric-spacep
 *a-string* *permissible-characters*)
--> T.
\end{verbatim}

\noindent Checks whether the first argument (assumed
to be a string) consists solely of alpha-numeric
characters and space. If so T is returned, otherwise
NIL. |#

(defun alpha-numeric-spacep
       (a-string &optional
	(permissible-characters
	 (concatenate
	  'string
	  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	  "abcdefghijklmnopqrstuvwxyz"
	  "0123456789 ")))
  (if (<= (length a-string) 0) (identity t)
    (if (find
	 (char a-string 0) permissible-characters
	 :test #'string=)
      (alpha-numeric-spacep
       (subseq a-string 1) permissible-characters))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *a-list*
 '(("composition 1" . "compose")
   ("analysis 1" . "analyse")
   ("folder 1"
    (("composition 2" . "compose")
     ("composition 3" . "compose")
     ("fun 1" . "ARCA")
     ("folder 2" (("analysis 2" . "analyse")))))
   ("fun 2" . "ARCA")))
(setq *indices* '(2 1 3 1))
(append-recursive *indices* *a-list*
		  '("prelude" . "compose"))
--> (("composition 1" . "compose")
     ("analysis 1" . "analyse")
     ("folder 1"
      (("composition 2" . "compose")
       ("composition 3" . "compose")
       ("fun 1" . "ARCA")
       ("folder 2" (("analysis 2" . "analyse")
		    ("prelude" . "compose")))))
     ("fun 2" . "ARCA")).
\end{verbatim}

\noindent A list of indices and a list are supplied to
this function. The aim is to update the list by
appending the third argument in the appropriate
place. |#

(defun append-recursive
       (indices substruct new-element)
  (if (null indices)
    (append substruct (list new-element))
    (append
     (subseq substruct 0 (first indices))
     (list
      (append-recursive
       (rest indices)
       (nth (first indices) substruct)
       new-element))
     (subseq substruct (+ (first indices) 1)))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *user-dir*
 (concatenate
  'string
  "/Applications/CCL/Lisp Code/Webapps foundation"
  "/Examples/user123/projects/"))
(create-folder-writing-stage
 (concatenate
  'string *user-dir* "projects/folder 1/"))
--> "name already taken".
\end{verbatim}

\noindent By this stage the name of a new folder has
been approved (in terms of whether it contains illegal
characters. This function creates a folder with the
supplied path&name by creating a text file called
"status.txt". If there already exists a path&name the
same as that supplied and whose status is "in use" 
then "name already taken" is returned.

It could be that a folder with the same path&name and
its contents have been `deleted', in which case the
folder will still exist, but its status will be
"deleted". In this case the status reverts to "in
use". |#

(defun create-folder-writing-stage
       (path&name &optional
	(actual
	 (concatenate
	  'string path&name "status.txt")))
  (if (probe-file actual)
    (if (string=
	 (first (read-from-file actual)) "in use")
      (identity "name already taken")
      (write-to-file (list "in use") actual))
    (write-to-file-with-open-file
     "in use" actual)))

#|
\noindent Example:
\begin{verbatim}
(setq
 *projects-folder-structure*
 '(("composition 1" . "compose")
   ("analysis 1" . "analyse")
   ("folder 1"
    (("composition 2" . "compose")
     ("composition 3" . "compose")
     ("fun 1" . "ARCA")
     ("folder 2" (("analysis 2" . "analyse")))))
   ("fun 2" . "ARCA")))
(setq *projects-folder-indices* '(2 1 3 1))
(folder-indices2path&name
  *projects-folder-indices*
  *projects-folder-structure*)
--> "folder 1/folder 2/".
\end{verbatim}

\noindent A list is provided indicating the
position of the current project within a folder
structure, which is also given. The idea is to
return the correct path&name for the position. |#

(defun folder-indices2path&name
       (indices substruct &optional
        (path&name ""))
  (if (null indices)
    (identity path&name)
    (folder-indices2path&name
     (rest (rest indices))
     (nth-recursive
      (subseq indices 0 2) substruct)
     (concatenate
      'string
      path&name
      (nth-recursive
       (list (first indices) 0) substruct) "/"))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *a-list*
 '(("composition 1" . "compose")
   ("analysis 1" . "analyse")
   ("folder 1"
    (("composition 2" . "compose")
     ("composition 3" . "compose")
     ("fun 1" . "ARCA")
     ("folder 2" (("analysis 2" . "analyse")))))
   ("fun 2" . "ARCA")))
(nth-recursive '(2 1 3) *a-list*)
--> ("folder 2" (("analysis 2" . "analyse"))).
\end{verbatim}

\noindent A list of indices and a list are supplied to
this function. The function nth is applied to the
first index and list recursively, returning deeper and
deeper levels of the list. If the original indices are
empty, the original list is returned. |#

(defun nth-recursive
       (indices a-list &optional
	(indices-copy (copy-list indices))
	(a-list-copy (copy-list a-list))
	(b-list
	 (if indices-copy
	   (nth (first indices-copy) a-list-copy))))
  (if (null indices-copy)
    (if (null indices)
      (identity a-list) (identity a-list-copy))
    (nth-recursive
     indices a-list (rest indices-copy) b-list)))

#|
\noindent Example:
\begin{verbatim}
(setq
 path&name
 "/user123/projects/compose projects/GCSE/draft 2/")
(setq divider "/")
(path&name2project-name path&name divider)
--> "draft 2".
\end{verbatim}

\noindent This function takes a full path&name and
returns just the last part of this (the text between
the pen-ultimate and final forward slash, or whatever
divider symbol is being used). The first argument is
assumed non-empty and appropriate. |#

(defun path&name2project-name
       (path&name &optional
	(divider "/")
	(l (- (length path&name) 1)))
  (subseq
   path&name
   (+
    (position
     (coerce divider 'character)
     (subseq path&name 0 l) :from-end t)
    1)
   ;1 to remove divider.
   l))

#|
\noindent Example:
\begin{verbatim}
(setq *project-changed* nil)
(setq *project-path&name* nil)
(setq *project-open-dialogue-window* t)
(setq *project-save-changes-dialogue-window* nil)
(setq *project-save-as-dialogue-window* nil)
(project-onload-logicals
 *project-changed* *project-path&name*
 *project-open-dialogue-window*
 *project-save-changes-dialogue-window*
 *project-save-as-dialogue-window*)
--> html in the file
"/Examples/project-onload-logicals.html".
\end{verbatim}

\noindent This function is obsolete. It was meant to
produce html which causes a modal dialogue window
(selected from the drop-down menu) to appear,
depending on the truth of the arguments. |#

(defun project-onload-logicals
       (changed path&name open-dialogue-window
	save-changes-dialogue-window
	save-as-dialogue-window)
  (if open-dialogue-window
    (if (not changed)
      (html
       (:print
        (concatenate
         'string
         "javascript:openSimDialog"
         "('project-open-dialogue', 400, 300, "
         "setPrefs);return false")))
      (html
       (:print
        (concatenate
         'string
         "openSimDialog"
         "('project-save-changes-dialogue', 400, "
         "300, setPrefs);return false"))))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *substruct*
 '(("composition 2" . "compose")
   ("composition 3" . "compose")
   ("fun 1" . "ARCA")
   ("folder 2" (("analysis 2" . "analyse")))))
(setq *project-type* "compose")
(project-open-radio-buttons
 *substruct* *project-type*)
--> html in the file
"/Examples/project-open-radio-buttons.html".
\end{verbatim}

\noindent A list of file and folder names is produced.
We are referring to files as projects at the moment.
So project names are accompanied by a radio button,
which is enabled if the type of project matches the
variable project-type. Folders are presented as
clickable links. |#

(defun project-open-radio-buttons
       (substruct project-type)
  (loop for i from 0 to (- (length substruct) 1) do
    (if (listp (cdr (nth i substruct)))
      (html
       (:a
	:href
	(:print
	 (concatenate
	  'string
	  "javascript:projectOpenFolder("
	  (write-to-string i)
	  ");"))
	(:print (car (nth i substruct)))) (:br))
      (if (string= (cdr (nth i substruct))
		   project-type)
	(html
	 (:print (car (nth i substruct)))
	 (:input
	  :type "radio" :name "project-open-radio"
	  :value (:print (car (nth i substruct))))
	 (:br))
	(html
	 (:print (car (nth i substruct)))
	 (:input
	  :type "radio" :name "project-open"
	  :value (:print (car (nth i substruct)))
	  :disabled "")
	 (:br))))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *substruct*
 '(("composition 2" . "compose")
   ("composition 3" . "compose")
   ("fun 1" . "ARCA")
   ("folder 2" (("analysis 2" . "analyse")))))
(project-save-folder-contents *substruct*)
--> html in the file
"/Examples/project-save-folder-contents.html".
\end{verbatim}

\noindent A list of file and folder names is produced.
We are referring to files as projects at the moment.
Folders are presented as clickable links. |#

(defun project-save-folder-contents (substruct)
  (loop for i from 0 to (- (length substruct) 1) do
    (if (listp (cdr (nth i substruct)))
      (html
       (:a
	:href
	(:print
	 (concatenate
	  'string
	  "javascript:projectSaveFolder("
	  (write-to-string i)
	  ");"))
	(:print (car (nth i substruct)))) (:br))
      (html
       (:print (car (nth i substruct))) (:br)))))

#|
\noindent Example:
\begin{verbatim}
(setq
 *a-list*
 '(("composition 1" . "compose")
   ("analysis 1" . "analyse")
   ("folder 1"
    (("composition 2" . "compose")
     ("composition 3" . "compose")
     ("fun 1" . "ARCA")
     ("folder 2" (("analysis 2" . "analyse")))))
   ("fun 2" . "ARCA")))
(setq *indices* '(2 1 3 1))
(rplcd-recursive
 *indices* *a-list* '("analysis 2" . "fun"))
--> (("composition 1" . "compose")
     ("analysis 1" . "analyse")
     ("folder 1"
      (("composition 2" . "compose")
       ("composition 3" . "compose")
       ("fun 1" . "ARCA")
       ("folder 2" (("analysis 2" . "fun")))))
     ("fun 2" . "ARCA")).
\end{verbatim}

\noindent A list of indices and a list are supplied to
this function. The aim is to update the list by
replacing the file type of the appropriate pair as
specified in the third argument. |#

(defun rplacd-recursive
       (indices substruct new-pair)
  (if (null indices)
    (progn
      (rplacd
       (assoc
	(car new-pair) substruct :test #'string=)
       (cdr new-pair))
      (identity substruct))
    (append
     (subseq substruct 0 (first indices))
     (list
      (rplacd-recursive
       (rest indices)
       (nth (first indices) substruct) new-pair))
     (subseq substruct (+ (first indices) 1)))))
