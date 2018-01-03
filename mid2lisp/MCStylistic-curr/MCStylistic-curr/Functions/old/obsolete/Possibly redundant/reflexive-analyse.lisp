#| Tom Collins
   Thursday 12 February 2009
   Completed Tuesday 3 March 2009

The aim of these functions is to identify instances
of self-reference (within a single MIDI file or list
of cope events). In order not to make the comments too
long, some of the examples are a little naive. |#

(defvar *transference&repository* '(NIL NIL))

#| This is the all-important variable whose first
element is a `transference' for the MIDI file/list
and whose second element is a `repository' for the
patterns found under certain music-analytic functions
and relations. It is worth explaining the structure
of these variables. A typical element of the
transference looks like this:

'((16 17 18)
  ((("semitone intervals"
     "prime form" "ontime-pitch ascending")
    (4 5) (2009 3 3 19 57 25))
   (("semitone intervals"
     "inversion form" "ontime-pitch ascending")
    (-4 -5) (2009 3 3 20 05 58))))

This means note-indices 16, 17, 18 have twice been
sent to the repository containing semitone intervals:
once looking at patterns in their prime form and at a
later date looking at inversions of patterns. The
date and time information could come in useful at
some stage. On both occasions the events have been
ordered by ontime and then MIDI note number, both
ascending.

A typical element of the repository looks like this:

'((4 5)
  ((("Ex A" (16 17 18))
    (("prime form" "melody"
      (2009 3 3 19 57 25)))
    (("prime form" "ontime-pitch ascending"
      (2009 3 3 20 13 30))))
   (("Ex A" (4 5 6))
    (("prime form" "ontime-pitch ascending"
      (2009 3 3 20 13 30))))))

At the head of the element is the pattern which has
been found, perhaps in various places or using
different walks in the digraph. The latter has
happened in the first instance: note-indices 16, 17,
18 have been found to trace out the semitone
intervals 4, 5, discovered once using a `melody'
walk and a second time using an `ontime-pitch
ascending' walk. Note-indices 4, 5, 6 also trace out
this pattern. |#

(defvar *ordered-results* '())

#| The above global variable and the chunk of code
below can be used to order results (crudely) and just
look at the 10 `most important', say.

(progn
  (setq *ordered-note-indices-list*
	(ordered-note-indices-list
	 (second *transference&repository*)
		"semitone-repository"))
  (print "It's done"))
|#

#| Example:
(setq *transference&repository*
      '((((2 3)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (-1)
	    (2009 3 4 9 16 4))))
	 ((1 2)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (1)
	    (2009 3 4 9 16 4)))))
	(((-1) ((("Ex A" (2 3))
		 (("prime form" "ontime-pitch ascending"
		   (2009 3 4 9 16 4))))))
	 ((1) ((("Ex A" (1 2))
		(("prime form" "ontime-pitch ascending"
		  (2009 3 4 9 16 4)))))))))
(accumulate-to-repository
 1 '(1) "Ex A" '(3 4)
 '((0 60 1) (1 61 1) (0 60 1) (3 61 1/2))
 4 "ontime-pitch ascending" "semitone intervals"
 "prime form" 1 2
 '((1) ((("Ex A" (1 2))
	 (("prime form" "ontime-pitch ascending"
	   (2009 3 4 9 16 4)))))))

gives
'((((2 3)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending") (-1)
      (2009 3 4 9 16 4))))
   ((1 2)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending") (1)
      (2009 3 4 9 16 4)))))
  (((1)
    ((("Ex A" (3 4))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 11 27 26))))
     (("Ex A" (1 2))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((-1)
    ((("Ex A" (2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))).

This function takes variables most of which have been
explained elsewhere. The variable rep-existence is
the relevant element from the repository. The
variables list-existence and update-index are used in
the case of type-3 accumulation (see below).

In type-1 accumulation the vertices have not been
tried before. The pattern exists in the repository
but not for the piece-vertices pair in question. In
type-2 and type-3 accumulation the vertices have been
tried before but not using the analytic-function-
analytic-relation-walk-method triple in question: in
type-2 the pattern is in the repository for some other
piece-vertices pair; in type-3 the pattern is in the
repository for the piece-vertices pair in question,
hence the walk-method or analytic-relation must be
new. |#

(defun accumulate-to-repository
       (accumulation-type music-analysed
        piece-identifier vertices
	walked-events length-walk walk-method
        analytic-function analytic-relation
	step r rep-existence
	#|transference&repository|#)
  (let* ((list-existence
	  (nth-list-of-lists 0
			     (second rep-existence)))
	 (update-index
	  (index-item-1st-occurs
	   (list piece-identifier vertices)
	   list-existence)))
    (progn
      (setf
       *transference&repository*
       (append
	(list (first *transference&repository*))
	(list
	 (if (<= accumulation-type 2)
	   (cons
	    (list
	     music-analysed
	     (cons (list (list piece-identifier
			       vertices)
			 (list (list analytic-relation
				     walk-method
				     (date&time))))
		   (second rep-existence)))
	    (remove rep-existence
		    (second *transference&repository*)
		    :test #'equalp))
	   (cons
	    (list
	     music-analysed
	     (cons
	      (list
	       (list piece-identifier vertices)
	       (cons (list analytic-relation
			   walk-method
			   (date&time))
		     (second
		      (nth update-index
			   (second rep-existence)))))
	      (remove-nth
	       update-index (second rep-existence))))
	    (remove rep-existence
		    (second *transference&repository*)
		    :test #'equalp))))))
      (test-pattern-extension
       (second rep-existence) piece-identifier
       vertices walked-events length-walk walk-method
       analytic-function analytic-relation step r
       #|transference&repository|#)
      (identity *transference&repository*))))

#| Example:
(setq *transference&repository*
      '((((2 3)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (-1)
	    (2009 3 4 9 16 4))))
	 ((1 2)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (1)
	    (2009 3 4 9 16 4)))))
	(((-1) ((("Ex A" (2 3))
		 (("prime form"
		   "ontime-pitch ascending"
		   (2009 3 4 9 16 4))))))
	 ((1) ((("Ex A" (1 2))
		(("prime form" "ontime-pitch ascending"
		  (2009 3 4 9 16 4)))))))))
(accumulate-to-transference
 '(1) '(1 2) "melody"
 "semitone intervals" "prime form"
 '((1 2)
   ((("semitone intervals" "prime form"
      "ontime-pitch ascending") (1)
     (2009 3 4 9 16 4)))))
gives
'((((1 2)
    ((("semitone intervals" "prime form" "melody")
      (1) (2009 3 4 12 1 57))
     (("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (1) (2009 3 4 9 16 4))))
   ((2 3)
    ((("semitone intervals" "prime form"
	     "ontime-pitch ascending")
      (-1) (2009 3 4 9 16 4)))))
  (((-1)
    ((("Ex A" (2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((1)
    ((("Ex A" (1 2))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))).

This function takes variables most of which have been
explained elsewhere. The variable trans-existence is
the relevant element from the transference. It is
used to update the appropriate element of the
transference. |#

(defun accumulate-to-transference
       (music-analysed vertices walk-method
	analytic-function analytic-relation
        trans-existence #|transference&repository|#)
  (setf *transference&repository*
	(append
	 (list
	  (cons (list vertices
		      (cons 
		       (list
			(list analytic-function
			      analytic-relation
			      walk-method)
			music-analysed
			(date&time))
		       (second trans-existence)))
		(remove trans-existence
			(first
			 *transference&repository*)
			:test #'equalp)))
	 (list (second *transference&repository*)))))

#| Example:
(setq *transference&repository*
      '((((2 3)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (-1)
	    (2009 3 4 9 16 4))))
	 ((1 2)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (1)
	    (2009 3 4 9 16 4)))))
	(((-1) ((("Ex A" (2 3))
		 (("prime form" "ontime-pitch ascending"
		   (2009 3 4 9 16 4))))))
	 ((1) ((("Ex A" (1 2))
		(("prime form" "ontime-pitch ascending"
		  (2009 3 4 9 16 4)))))))))
(add-to-repository
 '(3) "Ex A" '(3 4)
 "ontime-pitch ascending" "prime form")
gives
'((((2 3)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (-1) (2009 3 4 9 16 4))))
   ((1 2)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (1) (2009 3 4 9 16 4)))))
  (((3)
    ((("Ex A" (3 4))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 7 32))))))
   ((-1)
    ((("Ex A" (2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((1)
    ((("Ex A" (1 2))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))).

This function takes variables all of which have been
explained elsewhere. For an explanation of when this
function is called, see the preamble to the function
present-to-transference&repository. |#

(defun add-to-repository
       (music-analysed piece-identifier vertices
        walk-method analytic-relation
	#|transference&repository|#)
  (setf *transference&repository*
	(append
	 (list (first *transference&repository*))
	 (list
	  (cons
	   (list 
	    music-analysed
	    (list
	     (list (list piece-identifier
			 vertices)
		   (list
		    (list analytic-relation
			  walk-method
			  (date&time))))))
	   (second *transference&repository*))))))

#| Example:
(setq *transference&repository*
      '((((2 3)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (-1)
	    (2009 3 4 9 16 4))))
	 ((1 2)
	  ((("semitone intervals" "prime form"
	     "ontime-pitch ascending") (1)
	    (2009 3 4 9 16 4)))))
	(((-1) ((("Ex A" (2 3))
		 (("prime form" "ontime-pitch ascending"
		   (2009 3 4 9 16 4))))))
	 ((1) ((("Ex A" (1 2))
		(("prime form" "ontime-pitch ascending"
		  (2009 3 4 9 16 4)))))))))
(add-to-transference
 '(3) '(3 4) "ontime-pitch ascending"
 "semitone intervals" "prime form")
gives
'((((3 4)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (3) (2009 3 4 12 12 5))))
   ((2 3)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (-1) (2009 3 4 9 16 4))))
   ((1 2)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (1) (2009 3 4 9 16 4)))))
  (((-1)
    ((("Ex A" (2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((1)
    ((("Ex A" (1 2))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))).

This function takes variables all of which have been
explained elsewhere. For an explanation of when this
function is called, see the preamble to the function
present-to-transference&repository. |# 

(defun add-to-transference
       (music-analysed vertices walk-method
	analytic-function analytic-relation
        #|transference&repository|#)
  (setf *transference&repository*
	(append
	 (list
	  (cons (list 
		 vertices
		 (list (list (list analytic-function
				   analytic-relation
				   walk-method)
			     music-analysed
			     (date&time))))
		(first *transference&repository*)))
	 (list (second *transference&repository*)))))

#| Example:
(date&time)
gives
'(2009 1 7 20 33 28).

The date and time is output: year, month, day, hour,
minute, second. |#

(defun date&time ()
  (multiple-value-bind
      (second minute hour day month year)
      (get-decoded-time)
    (values (list year month day
		  hour minute second))))

#| Example:
(extension-step-limit '((7 8 9) 2 1 "retrograde form"))
gives
'((6 7 8 9) 2 1 "retrograde form" 4 4 7).

This function calls either the function
extension-step-limit-forward or the function
extension-step-limit-backward, depending on the
variable named as analytic-relation. More about the
details can be read in these functions. It should be
pointed out that the argument to this function is a
single list, making possible incremental calls using
the previous output. |#

(defun extension-step-limit
       (listed-variables &optional
	(walk (first listed-variables))
	(step (second listed-variables))
	(boundary (third listed-variables))
	(analytic-relation
	 (if (null (fourth listed-variables)) 
	   (identity "prime form")
	   (fourth listed-variables)))
	(walk-length
	 (if (null (fifth listed-variables))
	   (length walk)
	   (fifth listed-variables)))
	(new-length
	 (if (null (sixth listed-variables))
	   (+ walk-length 1)
	   (sixth listed-variables)))
	(tf-length (equal walk-length new-length))
	(first-walk (first walk)))
  (if (equal analytic-relation "prime form")
    (extension-step-limit-forward
     walk step boundary analytic-relation
     walk-length new-length tf-length)
    (extension-step-limit-backward
     walk step boundary analytic-relation
     walk-length new-length tf-length first-walk)))

#| Example:
(extension-step-limit-backward '(4 5 8) 3 1
			       "retrograde" 3 3)
gives
'((3 5 8) 3 1 "retrograde" 3 3 4)

This function takes a list of vertex numbers (which
may already have been extended, and continues to
extend backward, until the initial vertex number, or
until the point at which the variable step is
exceeded. Again, we could produce the entire list of
extensions in one go, but iteration is preferable.

The first argument is the current list of vertex
numbers. The second argument is step and the third
the initial vertex. In the example we see that the
vertex numbers have already been extended, since
variables for walk-length and new-length have been
provided. |#

(defun extension-step-limit-backward
       (walk step
	&optional
	(boundary 1)
	(analytic-relation "retrograde")
	(walk-length (length walk))
	(new-length (+ walk-length 1))
	(tf-length (equal walk-length new-length))
	(first-walk (first walk)))
  (if (or (<= first-walk boundary)
	  (and tf-length
	       (>= (- (second walk)
		      first-walk) step))) ()
    (list (if tf-length
	    (add-to-nth -1 1 walk)
	    (cons (- first-walk 1)
		  walk))
	  step boundary analytic-relation
	  new-length new-length first-walk)))

#| Example:
(extension-step-limit-forward '(3 5 8) 5 112)
gives
'((3 5 8 9) 5 112 4 4).

This function takes a list of vertex numbers (which
may already have been extended, and continues to
extend, up until the final vertex number, or until the
point at which the variable step is exceeded. Again,
we could produce the entire list of extensions in one
go, but iteration is preferable.

The first argument is the current list of vertex
numbers. The second argument is step and the third
bigN. In the example we see that the vertex numbers
are yet to be extended, because no length arguments
are provided (but they are output). |#

(defun extension-step-limit-forward
       (walk step bigN
	&optional
	(analytic-relation "prime form")
	(walk-length (length walk))
	(new-length (+ walk-length 1))
	(tf-length (equal walk-length new-length)))
  (if (or (>= (my-last walk) bigN)
	  (and tf-length
	       (>= (- (my-last walk)
		      (penultimate walk)) step))) ()
    (list (if tf-length
	    (add-to-nth 1 walk-length
			walk)
	    (reverse (cons (+ (my-last walk) 1)
			   (reverse walk))))
	  step bigN analytic-relation
	  new-length new-length)))

#| Example:
(first-proper-subsumption
 '(1 3)
 '((1 4 5) (1 3) (2 3 4) (1 2 3) (3 4)))
gives
'(1 2 3).

The first argument A to this function is a list of
numerical elements, the second is a list of lists,
where each sublist is a list of numerical elements.
Let Bi be the ith sublist. Counting from i = 1, this
function returns the first Bi such that A \ Bi is
empty, and A is not equal to Bi, or it returns the
empty list. The notation A \ Bi means the list of all
elements in A which are not in Bi. We ask A be properly
subsumed in Bi because A is always subsumed
in itself. |#

(defun first-proper-subsumption (a-list list-of-lists)
  (if (null list-of-lists) ()
    (if (and
	 (null
	  (set-difference a-list
			  (first list-of-lists)))
	 (not
	  (equal a-list (first list-of-lists))))
      (first list-of-lists)
      (first-proper-subsumption a-list
			 (rest list-of-lists)))))

#| Example:
(music-analytic '((2 45 1 2 77) (2 52 1 2 77)
		  (2 69 1/2 1 63) (2 73 1/2 1 74)
		  (5/2 68 1/2 1 63)))
gives
'(7 17 4 -5).

This function is a generalisation, allowing a music-
analytical function to be applied to any number of
cope events, assumed to be in some kind of order. |#

(defun music-analytic
       (ordered-events &optional
	(method (list "semitone intervals"
		      "prime form")))
  (if (equal method '("semitone intervals"
		      "prime form"))
    (semitone-intervals ordered-events)))

#| Example:
(music-significance-product
 '((2 4 6 8)
   ((("Ex A" (6 7 8 9 10))
     (("prime form" "ontime-pitch ascending"
       (2009 3 4 16 3 36))))
    (("Ex A" (1 2 3 4 5))
     (("prime form" "ontime-pitch ascending"
       (2009 3 4 16 3 36)))))))
gives
8.

A simple product is returned, of the pattern length and
number of distinct vertices sets exhibiting that
pattern. |#

(defun music-significance-product
       (repository-element)
  (*
   (length (first repository-element))
   (length (second repository-element))))

#| Example:
(note-indices-list
 '(((-19 2)
    ((("Ex A" (5 6 7))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((2 4)
    ((("Ex A" (6 7 8))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 7 32))))
     (("Ex A" (1 2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 7 32))))))   
   ((8 -19)
    ((("Ex A" (4 5 6))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((2 4 6 8)
    ((("Ex A" (6 7 8 9 10))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 16 3 36))))
     (("Ex A" (1 2 3 4 5))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 16 3 36))))))
   ((6 8)
    ((("Ex A" (3 4 5))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((4 6)
    ((("Ex A" (2 3 4))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))
 "semitone-intervals repository")
gives
'((2 "semitone-intervals repository" 0)
  (4 "semitone-intervals repository" 1)
  (2 "semitone-intervals repository" 2)
  (8 "semitone-intervals repository" 3)
  (2 "semitone-intervals repository" 4)
  (2 "semitone-intervals repository" 5)).

A list of lists is returned by this function, which
takes as its arguments a repository and a name for
this repository. Each sublist in the output consists
of the result of the music-significance-product
function, the name of the repository, and the index of
the pattern within this repository. |#

(defun note-indices-list
       (repository repository-name &optional (i 0))
  (if (null repository) ()
    (cons
     (list
      (music-significance-product
       (first repository))
      repository-name
      i)
     (note-indices-list
      (rest repository) repository-name (+ i 1)))))

#| Example:
(ordered-note-indices-list
 '(((-19 2)
    ((("Ex A" (5 6 7))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((2 4)
    ((("Ex A" (6 7 8))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 7 32))))
     (("Ex A" (1 2 3))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 7 32))))))   
   ((8 -19)
    ((("Ex A" (4 5 6))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((2 4 6 8)
    ((("Ex A" (6 7 8 9 10))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 16 3 36))))
     (("Ex A" (1 2 3 4 5))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 16 3 36))))))
   ((6 8)
    ((("Ex A" (3 4 5))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4))))))
   ((4 6)
    ((("Ex A" (2 3 4))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 9 16 4)))))))
 "semitone-intervals repository")
gives
'((8 "semitone-intervals repository" 3)
  (4 "semitone-intervals repository" 1)
  (2 "semitone-intervals repository" 0)
  (2 "semitone-intervals repository" 2)
  (2 "semitone-intervals repository" 4)
  (2 "semitone-intervals repository" 5)).

A list of lists is returned by this function, which
takes as its arguments a repository and a name for
this repository. Each sublist in the output consists
of the result of the music-significance-product
function, the name of the repository, and the index of
the pattern within this repository. The results are
sorted descending by the music-significance-product. |#

(defun ordered-note-indices-list
       (repository repository-name)
  (sort-by '((0 "desc"))
	   (note-indices-list repository
			      repository-name)))

#| Example:
(penultimate '(-50 0 -5 5))
gives
-5.

The penultimate item of a list is returned. |#

(defun penultimate (a-list)
  (nth (- (length a-list) 2) a-list))

#| Example:
(setq *transference&repository* '(nil nil))
(present-to-transference&repository
 "Ex A" '((1 2) 1 4 2 (2 3) (0 0) 2)
  '((0 60 1) (1 61 1) (2 63 1) (3 69 12)) 4
  "ontime-pitch ascending" "semitone intervals"
  "prime form" 1 2)
gives
'((((1 2)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending")
      (1) (2009 3 4 12 51 9)))))
  (((1)
    ((("Ex A" (1 2))
      (("prime form" "ontime-pitch ascending"
	(2009 3 4 12 51 9)))))))).

This function takes at least nine arguments: a unique
piece identifier, vertices information, a list of
walked events, their length, a walk-method name, an
analytic-function name, an analytic-relation name, and
variables called step and r. First of all, two extra
variables are created: vertices, which are the
vertices under consideration; music-analysed, which is
the result of applying a music-analytic function.

There are sixteen possible actions to take, based on
the nullity of the variables trans-existence, trans-
index, rep-existence, rep-index. I will explain each
case in turn, using TFFT to signify, for instance,
that trans-index and rep-existence are null:
FFFF - add-to-transference and add-to-repository;
FFFT - contradiction as pattern has not been found
       before, yet an index exists;
FFTF - add-to-transference and accumlate-to-repository
       (type 1 as the pattern exists in the repository
       but not for the piece-vertices pair in
       question);
FFTT - contradiction as pattern exists in the
       repository which seems never to have been sent;
FTFF - contradiction as vertices from this piece are
       new, yet an index exists;
FTFT - "
FTTF - "
FTTT - "
TFFF - accumulate-to-transference and add-to-
       repository (a new type of walk-method or
       analytic function may be in use);
TFFT - contradiction as pattern has not been found
       before, yet an index exists;
TFTF - accumulate-to-transference and accumulate-to-
       repository (type 2 as the vertices have been
       tried before but not using the analytic-
       function-analytic-relation-walk-method triple
       in question, and the pattern is in the
       repository for some other piece-vertices pair);
TFTT - accumulate-to-transference and accumulate-to-
       repository (type 3 as the vertices have been
       tried before but not using the analytic-
       function-analytic-relation-walk-method triple
       in question, hence the walk-method or
       analytic-relation must be new);
TTFF - contradiction as pattern ought to be in the
       analytic repository already;
TTFT - contradiction as pattern has not been found
       before, yet an index exists;
TTTF - contradiction as pattern ought to have an
       index in the repository already;
TTTT - already analysed.

NB I can't image a scenario in reflexive analysis
where TFTF can occur. |#

(defun present-to-transference&repository
 (piece-identifier vertices-info
  walked-events length-walk walk-method
  analytic-function analytic-relation step r
  #|transference&repository|# &optional
  (vertices (first vertices-info))
  (music-analysed 
   (music-analytic
    (nth-list
     (add-to-list -1 vertices)
     walked-events)
    (list analytic-function analytic-relation)))
  (trans-existence (assoc vertices
                          (first
			   *transference&repository*)
                          :test #'equalp))
  (trans-index
   (index-item-1st-occurs
    (list analytic-function
	  analytic-relation
	  walk-method)
    (nth-list-of-lists 0 (second trans-existence))))
  (rep-existence (assoc music-analysed
                        (second
			   *transference&repository*)
                        :test #'equalp))
  (rep-index
   (index-item-1st-occurs
    (list piece-identifier vertices)
    (nth-list-of-lists 0 (second rep-existence)))))
  (if (null trans-existence)
    (if (null trans-index)
      (if (null rep-existence)
        (if (null rep-index)
          (progn
	    (add-to-transference
	     music-analysed vertices walk-method
	     analytic-function analytic-relation
	     #|transference&repository|#)
            (add-to-repository 
	     music-analysed piece-identifier
	     vertices walk-method
	     analytic-relation
	     #|transference&repository|#))
          (print "CONTRADICTION! Pattern has not been
                 found before, yet an index exists."))
        (if (null rep-index)
          (progn
           (add-to-transference
	    music-analysed vertices walk-method
	    analytic-function analytic-relation
	    #|transference&repository|#)
	   (accumulate-to-repository
	    1 music-analysed piece-identifier
	    vertices walked-events length-walk
	    walk-method analytic-function
	    analytic-relation step r
	    rep-existence
	    #|transference&repository|#))
          (print "CONTRADICTION! A pattern exists in
                 the analytic repository which seems
                 never to have been sent.")))
      (print "CONTRADICTION! Vertices from this piece
             are new, yet an index exists."))
    (if (null trans-index)
      (if (null rep-existence)
        (if (null rep-index)
          (progn
	    (accumulate-to-transference
	     music-analysed vertices walk-method
	     analytic-function analytic-relation
	     trans-existence
	     #|transference&repository|#)
	    (add-to-repository
	     music-analysed piece-identifier
	     vertices walk-method
	     analytic-relation
	     #|transference&repository|#))
          (print "CONTRADICTION! Pattern has not been
                 found before, yet an index exists."))
        (if (null rep-index)
	  (progn
	    (accumulate-to-transference
	     music-analysed vertices walk-method
	     analytic-function analytic-relation
	     trans-existence
	     #|transference&repository|#)
	    (accumulate-to-repository
	     2 music-analysed piece-identifier
	     vertices walked-events length-walk
	     walk-method analytic-function
	     analytic-relation step r
	     rep-existence
	     #|transference&repository|#))
	  (progn
	    (accumulate-to-transference
	     music-analysed vertices walk-method
	     analytic-function analytic-relation
	     trans-existence
	     #|transference&repository|#)
	    (accumulate-to-repository
	     3 music-analysed piece-identifier
	     vertices walked-events length-walk
	     walk-method analytic-function
	     analytic-relation step r
	     rep-existence
	     #|transference&repository|#))))
      (if (null rep-existence)
        (if (null rep-index)
          (print "CONTRADICTION! Pattern ought to be
                 in the analytic repository already.")
          (print "CONTRADICTION! Pattern has not been
                 found before, yet an index exists."))
        (if (null rep-index)
          (print "CONTRADICTION! Pattern ought to have
                 an index in the repository already.")
          (print "ALREADY ANALYSED!"))))))

#| Example:
(setq *piece-identifier* "Ex A")
(setq *cope-events*
 '((3 66 1) (4 70 1) (5 75 1)
   (0 60 1) (1 61 1) (2 63 1)
   (8 64 1/2) (17/2 62 1/2) (9 64 1)
   (10 67 1) (11 71 1) (12 72 2)
   (18 67 1) (19 71 1) (20 76 1)
   (15 61 1) (16 62 1) (17 64 1)))
(setq *walk-method* "ontime-pitch ascending")
(setq *analytic-function* "semitone intervals")
(setq *analytic-relation* "prime form")
(setq *step* 5) (setq *r* 3)
(reflexive-analyse
 *piece-identifier* *cope-events*
 *walk-method* *analytic-function*
 *analytic-relation* *step* *r*)
gives
"ALREADY ANALYSED!" 
"ALREADY ANALYSED!" 
"It's done!" 
"It's done!"

The function reflexive-analyse calls the function
walk-in-digraph, and then makes a call to the
recursive function update-transference&repository, in
much the same way that markov-analyse calls the
function update-stm.

The resulting updates to the variable
*transference&repository* can be written to files
using
(write-to-file (first *transference&repository*)
    "//Users/tomcollins/Desktop/transference.txt")
(write-to-file (second *transference&repository*)
    "//Users/tomcollins/Desktop/repository.txt")
for instance.

Most of the variables are self-explanatory:
*piece-identifier* is a string---it might be good if
this was a pathname to a file containing an adequate
citation;
*cope-events* is a list of the cope events associated
with the piece identifier, and the convention of
having at least ontimes, MIDI note numbers and
durations is observed, in that order;
*walk-method* can only be set to "ontime-pitch
ascending" so far, but other possibilities are
"melody", "Lewin" and "chord sequence";
*analytic-function* is a well-defined function on a
subset A of the set of all lists of lists-of-music-
lists;
*analytic-relation* is a binary relation on S, a set
of lists-of-music-lists of equal length, such that
for arbitrary elements x, y in S, x is related to y
if and only if f(x) = g(y), where f, g are given
music-analytic functions;
*step* is the maximum distance between two note
indices in any given pattern---for instance, in the
pattern (1 3 7) the note indices 1 and 3, 3 and 7
exceed a step of 1, but none exceed a step of 4;
*r* is the number of note indices which are chosen
at a time to begin looking for patterns. |#

(defun reflexive-analyse
       (piece-identifier cope-events
	walk-method analytic-function
	analytic-relation step r &optional
	(walked-events
	 (walk-in-digraph cope-events walk-method)))
  (if (update-transference&repository
       piece-identifier walked-events
       (length walked-events) walk-method
       analytic-function analytic-relation
       step r) t)
  "It's done!")

#| Example:
(semitone-intervals '((0 60 2 1 67)
		      (1 63 1 2 65)
		      (3 62 1/2 1 84)))
gives
'(3 -1).

This function takes a list of ordered cope events and
returns the interval in semitones between adjacent
events. Note the use of a function from `chords'. |#

(defun semitone-intervals (cope-events)
  (spacing 1 cope-events))

#| Example:
(test-analytic-relation '(1 2 3) '(5 6 8)
 '((0 60 1) (1 64 1) (2 59 2) (5 61 2)
   (8 70 2) (10 74 1) (11 72 1) (12 69 4))
 '((0 60 1) (1 64 1) (2 59 2) (5 61 2)
   (8 70 2) (10 74 1) (11 72 1) (12 69 4))
 '("semitone intervals" "prime form"))

gives
T.

The first two arguments of to this function are lists
of vertex numbers of equal length. The first refers to
elements of the third argument, a list of cope events:
the second to the fourth argument. The function
returns T if the elements referenced are related
musically in the way specified by the fifth
argument---a list consisting of a music-analytic
function name and a music-analytic relation name. |#

(defun test-analytic-relation
       (a-vertices b-vertices a-walked-events
	b-walked-events analytics)
  (let ((a-music-analysed
	 (music-analytic
	  (nth-list
	   (add-to-list -1 a-vertices)
	   a-walked-events)
	  analytics))
	(b-music-analysed
	 (music-analytic
	  (nth-list
	   (add-to-list -1 b-vertices)
	   b-walked-events)
	  analytics)))
    (equal a-music-analysed b-music-analysed)))

#| Example:
(setq *walked-events*
 '((0 60 1) (1 62 1) (2 66 1) (3 72 1) (4 80 1)
   (15 61 1) (16 63 1) (17 67 1) (18 73 1)
   (19 81 1)))
(setq *transference&repository*
 '((((6 7 8)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (2 4) (2009 3 4 9 16 4))))
    ((5 6 7)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (-19 2) (2009 3 4 9 16 4))))
    ((4 5 6)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (8 -19) (2009 3 4 9 16 4))))
    ((3 4 5)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (6 8) (2009 3 4 9 16 4))))
    ((2 3 4)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (4 6) (2009 3 4 9 16 4))))
    ((1 2 3)
     ((("semitone intervals" "prime form"
	"ontime-pitch ascending")
       (2 4) (2009 3 4 9 16 4)))))
   (((2 4)
     ((("Ex A" (6 7 8))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 12 7 32))))
      (("Ex A" (1 2 3))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 12 7 32))))))
    ((-19 2)
     ((("Ex A" (5 6 7))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 9 16 4))))))
    ((8 -19)
     ((("Ex A" (4 5 6))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 9 16 4))))))
    ((6 8)
     ((("Ex A" (3 4 5))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 9 16 4))))))
    ((4 6)
     ((("Ex A" (2 3 4))
       (("prime form" "ontime-pitch ascending"
	 (2009 3 4 9 16 4)))))))))
(test-pattern-extension 
 '((("Ex A" (6 7 8))
    (("prime form" "ontime-pitch ascending"
      (2009 3 4 12 7 32))))
   (("Ex A" (1 2 3))
    (("prime form" "ontime-pitch ascending"
      (2009 3 4 12 7 32))))) "Ex A" '(6 7 8)
      *walked-events* 10 "ontime-pitch ascending"
      "semitone intervals" "prime form" 1 3)
gives
nil
but typing
*transference&repository*
will show that the pattern has been discovered.

This function begins by determining possible
extensions to an identified pattern. It works through
a variable called second-rep-existence, taking the
first element of this each time (see possible
improvement below) until it is empty. The definition
of the function is quite long, so it is peppered with
comments as it goes.

A possible improvement would be to alter the
definition of candidate-extension to
(second (first (second second-rep-existence)))
because at the moment this function begins by
comparing the vertices with themselves, which
just takes a bit longer and is probably the reason
for all the "Already analysed" comments. But is it?!
I tested this and all that happened was the pattern
discovery was curtailed, and no warnings are put out
in the example anyway. I must be missing something. |#

(defun test-pattern-extension
       (second-rep-existence piece-identifier vertices
	walked-events length-walk walk-method
	analytic-function analytic-relation step r
	#|transference&repository|#
	&optional
	(a-previous-extension "none")
	(b-previous-extension "none"))
  (let ((candidate-extension
	 (second
	  (first (first second-rep-existence)))))
    (if (null candidate-extension)
;; There are no more patterns to try to extend.
      ()
      (if (null a-previous-extension)
;; Move on to the next vertices in
;; second-rep-existence.
	(test-pattern-extension
	 (rest second-rep-existence) piece-identifier
	 vertices walked-events length-walk
	 walk-method analytic-function
	 analytic-relation step r
	 #|transference&repository|# "none" "none")
	(if (null b-previous-extension)
;; Try extending the latter of the two sets of
;; vertices.
	  (test-pattern-extension
	   second-rep-existence piece-identifier
	   vertices walked-events length-walk
	   walk-method analytic-function
	   analytic-relation step r
	   #|transference&repository|#
	   (extension-step-limit a-previous-extension)
	   (extension-step-limit
            (list vertices step
                  (if (equal analytic-relation
                             "prime form")
                    (identity length-walk)
                    (identity 1))
                  analytic-relation)))
	  (if (equal a-previous-extension "none")
;; Create some vertices to test.
	    (test-pattern-extension
	     second-rep-existence piece-identifier
	     vertices walked-events length-walk
	     walk-method analytic-function
	     analytic-relation step r
	     #|transference&repository|#
	     (extension-step-limit
	      (list
	       candidate-extension step
	       length-walk))
             (extension-step-limit
	      (list vertices step
		    (if (equal analytic-relation
			       "prime form")
		      (identity length-walk)
		      (identity 1))
		    analytic-relation)))
;; Here, we're actually in a position to test
;; something.
	    (progn
	      (if (and
;; Test that the music is equivalent in some sense.
                   (test-analytic-relation
                    (first a-previous-extension)
                    (first b-previous-extension)
                    walked-events walked-events
                    (list analytic-function
                          analytic-relation))
;; Test that the two patterns under consideration do
;; not intersect in any way.
                   (null
                    (intersection
                     (first
                      a-previous-extension)
                     (first
                      b-previous-extension)))
;; Test that at least one of the vertices sets is not
;; properly subsumed by already-analysed vertices sets.
		   (or
		    (not 
		     (first-proper-subsumption
		      (first a-previous-extension)
		      (nth-list-of-lists
		       0
		       (first
			*transference&repository*))))
		    (not 
		     (first-proper-subsumption
		      (first b-previous-extension)
		      (nth-list-of-lists
		       0
		       (first
			*transference&repository*))))))
;; We are in a position to present something to the
;; variable *transference&repository*, but it may need
;; altering first...
		(progn
;; Test whether both vertices sets we are about to add
;; are extensions (by one vertex) of the previous
;; vertices sets, and whether the length of the vertex
;; set is greater than r+1 (we do not want to start
;; removing elements of length r).
                  (if
		    (and
		     (equal
		      (butlast
		       (first a-previous-extension))
		      (first
		       (second
			(first
			 *transference&repository*))))
		     (equal
		      (butlast
		       (first b-previous-extension))
		      (first
		       (first
			(first
			 *transference&repository*))))
		     (> (length
			 (first a-previous-extension))
			(+ r 1)))
;; Remove appropriate elements of the variable
;; *transference&repository*.
                    (setf
                     *transference&repository*
                     (list
                      (rest
                       (rest
                        (first
                         *transference&repository*)))
                      (rest
                       (second
                        *transference&repository*)))))
;; Present to *transference&repository*.
		  (present-to-transference&repository
		   piece-identifier
		   a-previous-extension walked-events
		   length-walk walk-method
		   analytic-function analytic-relation
		   step r
		   #|transference&repository|#)
		  (present-to-transference&repository
		   piece-identifier
		   b-previous-extension walked-events
		   length-walk walk-method
		   analytic-function analytic-relation
		   step r
		   #|transference&repository|#)))
;; Call function again, extending the latter set of
;; vertices.
	      (test-pattern-extension
	       second-rep-existence piece-identifier
	       vertices walked-events length-walk
	       walk-method analytic-function
	       analytic-relation step r
	       #|transference&repository|#
	       a-previous-extension
	       (extension-step-limit
		b-previous-extension)))))))))



#| Example:
(setq *transference&repository* '())
(update-transference&repository
 "Ex A" '((0 60 1) (1 61 1) (0 60 1)) 3
 "ontime-pitch ascending" "semitone intervals"
 "prime form" 1 2)
gives
"It's done"
and
*transference&repository*
gives
'((((2 3)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending") (-1)
      (2009 3 4 9 16 4))))
   ((1 2)
    ((("semitone intervals" "prime form"
       "ontime-pitch ascending") (1)
      (2009 3 4 9 16 4)))))
  (((-1) ((("Ex A" (2 3))
	   (("prime form" "ontime-pitch ascending"
	     (2009 3 4 9 16 4))))))
   ((1) ((("Ex A" (1 2))
	  (("prime form" "ontime-pitch ascending"
	    (2009 3 4 9 16 4)))))))).

This function uses the function choices-step-limit1by1
to generate vertices until there are none left. It
presents each set of vertices to the variable
*transference&repository* using the function
present-to-transference&repository. Loops can occur
where there are matches, but eventually it gets back
to a recursive call. |#

(defun update-transference&repository
       (piece-identifier walked-events length-walk
	walk-method analytic-function
	analytic-relation step r &optional
	(vertices-info
	 (choices-step-limit1by1
	  (list nil step length-walk r))))
  (if (null vertices-info)
    (print "It's done!")
    (progn
      (present-to-transference&repository
       piece-identifier vertices-info walked-events
       length-walk walk-method analytic-function
       analytic-relation step r
       #|transference&repository|#)
      (update-transference&repository
       piece-identifier walked-events length-walk
       walk-method analytic-function analytic-relation
       step r
       (choices-step-limit1by1 vertices-info)))))

#| Example:
(walk-in-digraph
 '((1 59 1 2 90) (1 63 1 1 65) (3 62 1/2 2 84)
   (3 62 1/2 1 84) (0 60 2 1 67))
 "ontime-pitch ascending")
gives
'((0 60 2 1 67) (1 59 1 2 90) (1 63 1 1 65)
  (3 62 1/2 2 84) (3 62 1/2 1 84)).

This function defines a walk through the digraph whose
vertices are cope events, according to the specified
method (default value "ontime-pitch ascending"). For
instance, "ontime-pitch ascending" means that the
cope events will be sorted by onset and, where there
are ties, by MIDI note numbers, both ascending.

Other methods which spring to mind are "melody",
"Lewin", "chord sequence", "approximate chord
sequence" and "approximate onset-pitch". The latter
two will require a tolerance to be derived or set. |#

(defun walk-in-digraph (cope-events &optional
			(method
			 "ontime-pitch ascending"))
  (if (equal method "ontime-pitch ascending")
    (sort-by '((0 "asc") (1 "asc")) cope-events)))















