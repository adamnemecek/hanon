#| Tom Collins
   Tuesday 27 January 2009
   Completed Wednesday 28 January 2009

The functions here are designed to analyse data
according to a Markov-chain model. At present the code
handles a first-order analysis. The aim is to build a
state transition matrix for some variables (referenced
by variable-names and catalogue). Hence, the variable
variable-names points to some actual data (note the
use of the function symbol-value) which is indexed by
the variable catalogue. Using the function
write-to-file, the information can be sent to a text
file, to avoid the Listener having to display it. |#

#| Example:
(accumulate-to-stm
 '(((4) ("Piece A")) ((2) ("Piece A")))
 '((4) (((1) ("Piece B")) ((2) ("Piece C"))))
 '(((1) (((5) ("Piece A")) ((4) ("Piece B"))))
   ((2) (((5) ("Piece A"))))
   ((4) (((1) ("Piece B"))
         ((2) ("Piece C"))))
   ((5) (((4) ("Piece B"))))))
gives
'(((4) (((2) ("Piece A")) ((1) ("Piece B"))
        ((2) ("Piece C"))))
  ((1) (((5) ("Piece A")) ((4) ("Piece B"))))
  ((2) (((5) ("Piece A"))))
  ((5) (((4) ("Piece B"))))).

The first argument is a listed state; the second is the
relevant row of the state transition matrix; the third
is the state transition matrix itself. This function is
called when the state of the first item of the listed
state has appeared in the state transition matrix 
before. The references of the event are included. |#

(defun accumulate-to-stm (listed-state
                          relevant-row
                          stm)
  (cons (list (first (first listed-state))
              (cons (second listed-state)
                      (second relevant-row)))
          (remove relevant-row stm :test #'equalp)))

#| Example:
(add-to-stm '(((3) ("Piece A")) ((4) ("Piece A")))
            '(((1) (((5) ("Piece A")) ((4) ("Piece B"))))
              ((2) (((5) ("Piece A"))))
              ((4) (((1) ("Piece B"))
                    ((2) ("Piece C"))))
              ((5) (((4) ("Piece B"))))))
gives
'(((3) (((4) ("Piece A"))))
  ((1) (((5) ("Piece A")) ((4) ("Piece B"))))
  ((2) (((5) ("Piece A"))))
  ((4) (((1) ("Piece B")) ((2) ("Piece C"))))
  ((5) (((4) ("Piece B"))))).

The first argument is a listed state; the second is the
state transition matrix. This function is called when
the state of the first item of the listed state has not
appeared in the state transition matrix before. It is
added. |#

(defun add-to-stm (listed-state stm)
  (cons (list (first (first listed-state))
              (list
               (second listed-state))) stm))

#| Example:
(setq variable-1 '((0 30 1 1 84) (0 33 1 1 84)
                   (1 40 1 1 84) (1 41 1 1 84)))
(setq variable-2 '((0 60 1 1 84) (0 63 1 1 84)
                   (1 62 1 1 84) (1 63 1 1 84)))
(setq *variable-names* '(variable-1 variable-2))
(setq *catalogue* '("variable-1" "variable-2"))
(construct-initial-states (*variable-names*
			   *catalogue*))
gives
'((((3) (0 0)) (NIL 1 "variable-1" ((0 30 1 1 84 1 0)
				    (0 33 1 1 84 1 1))))
  (((3) (0 0)) (NIL 1 "variable-2" ((0 60 1 1 84 1 0)
				    (0 63 1 1 84 1 1))))).

This recursion analyses one variable name at a
time, taking a catalogue name from the variable
catalogue, and updates the initial states
accordingly. The output "Finished!" is preferable to
the transition matrix, which is large enough that it can
cause the Listener to crash. |#

(defun construct-initial-states
       (variable-names
	catalogue
	&optional (depth-check 10))
  (if (null variable-names) ()
    (cons
     (first
      (spacing-ties-states
       (firstn depth-check
	       (symbol-value (first variable-names)))
       (first catalogue)))
     (construct-initial-states
      (rest variable-names)
      (rest catalogue)
      depth-check))))

#| Example:
(setq variable-1 '((0 30 1 1 84) (0 33 1 1 84)
                   (1 40 1 1 84) (1 41 1 1 84)))
(setq variable-2 '((0 60 1 1 84) (0 63 1 1 84)
                   (1 62 1 1 84) (1 63 1 1 84)))
(setq *variable-names* '(variable-1 variable-2))
(setq *catalogue* '("variable-1" "variable-2"))
(construct-stm *variable-names* *catalogue*)
gives
"Finished!".

This recursion analyses one variable name at a
time, taking a catalogue name from the variable
catalogue, and updates the transition matrix
accordingly. The output "Finished!" is preferable to
the transition matrix, which is large enough that it can
cause the Listener to crash. |#

(defun construct-stm (variable-names catalogue)
  (if (null variable-names) (print "Finished!")
    (progn
      (markov-analyse
       (spacing-ties-states
        (symbol-value (first variable-names))
        (first catalogue)))
      (construct-stm (rest variable-names)
                     (rest catalogue)))))

#| Example:
(firstn-list 3 '(1 2 3 4 5)
gives
'((1 2 3) (2 3 4) (3 4 5)).

This function applies the function firstn
recursively to a list. It is like producing an n-
gram, and is useful for building a first-order
Markov model. I call the output 'listed states'. |#

(defun firstn-list (n a-list)
  (if (equal (length a-list) (- n 1)) ()
    (cons (firstn n a-list)
          (firstn-list n (rest a-list)))))

#| Example:
(markov-analyse '(((3) ("Piece A")) ((6) ("Piece A"))
                  ((4) ("Piece A")) ((4) ("Piece A"))
                  ((3) ("Piece A")) ((2) ("Piece A"))))
gives
'(((3) (((2) ("Piece A")) ((6) ("Piece A"))))
  ((4) (((3) ("Piece A")) ((4) ("Piece A"))))
  ((6) (((4) ("Piece A"))))), or "It's done!".

This function has one argument - some states which are
to be analysed according to a first-order Markov
model. Note the need to define a variable here,
*transition-matrix*. The output "Finished!" is
preferable to the transition matrix, which is large
enough that it can cause the Listener to crash. |#

(defvar *transition-matrix* ())

(defun markov-analyse (states)
  (if (update-stm (firstn-list 2 states)) t)
  "It's done!")

#| Example:
(present-to-stm '(((4) ("Piece A")) ((2) ("Piece A")))
                '(((1) (((5) ("Piece A"))
                        ((4) ("Piece B"))))
                  ((2) (((5) ("Piece A"))))
                  ((4) (((1) ("Piece B"))
                        ((2) ("Piece C"))))
                  ((5) (((4) ("Piece B"))))))
gives
'(((4) (((2) ("Piece A")) ((1) ("Piece B"))
        ((2) ("Piece C"))))
  ((1) (((5) ("Piece A")) ((4) ("Piece B"))))
  ((2) (((5) ("Piece A"))))
  ((5) (((4) ("Piece B"))))).

This function calls either the function
accumulate-to-stm, or add-to-stm, depending on whether
the first argument, a listed-state, has appeared in the
second argument, a state-transition matrix, before. The
example above results in accumulate-to-stm being called,
as the state of (4) has occurred before. However,
changing this state to (3) in the argument would result
in add-to-stm being called. |#

(defun present-to-stm (listed-state stm)
  (let ((relevant-row (assoc
                       (first (first listed-state))
                       stm
                       :test #'equalp)))
    (if (identity relevant-row) 
      (accumulate-to-stm listed-state
                         relevant-row
                         stm)
      (add-to-stm listed-state stm))))

#| Example:
(update-stm '((((3) ("Piece A")) ((6) ("Piece A")))
              (((6) ("Piece A")) ((4) ("Piece A")))
              (((4) ("Piece A")) ((4) ("Piece A")))
              (((4) ("Piece A")) ((3) ("Piece A")))
              (((3) ("Piece A")) ((2) ("Piece A")))))
gives
'(((3) (((2) ("Piece A")) ((6) ("Piece A"))))
  ((4) (((3) ("Piece A")) ((4) ("Piece A"))))
  ((6) (((4) ("Piece A"))))).

This function has as its argument listed states, and it
applies the function present-to-stm recursively to these
listed states. The variable *transition-matrix* is
updated as it proceeds. |#

(defun update-stm (listed-states
                   &optional (stm
                              *transition-matrix*))
  (if (null listed-states)
    (setq *transition-matrix* stm)
    (update-stm (rest listed-states)
                (present-to-stm
                 (first listed-states) stm))))

#| Example:
(write-to-file '(5 7 8 "hello" 9)
               "//Users/tec69/Desktop/test.txt")
gives
(have a look at the desktop).

This function writes the data provided in the first list
to a file with the path and name provided in the second
list. The s in the format argument is essential for
retaining strings as they appear in the data. |#

(defun write-to-file
       (variable path&name
        &optional
        (file (open path&name
                    :direction
                    :output
                    :if-does-not-exist
                    :create
                    :if-exists
                    :overwrite)))
  (if (null variable) (close file)
    (progn (format file
                   "~s~%" (first variable))
      (write-to-file (rest variable)
                     path&name
                     file))))