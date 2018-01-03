#| Tom Collins
   Friday 16 January 2009
   Completed Saturday 24 January 2009 |#

#| Example:
(append-offtimes '((0 48 2) (1 60 1) (1 57 1/2)))
gives
'((0 48 2 2) (1 60 1 2) (1 57 1/2 3/2)).

This function takes a list, assumed to be in cope-
event form, that is ontime-midinumber-duration etc.
It appends the offset of each event as the final
item. |#

(defun append-offtimes
       (a-list &optional (duration-index 2))
  (if (null a-list) ()
    (cons (append (first a-list)
		  (list (+ (first (first a-list))
			   (nth duration-index
				(first a-list)))))
	  (append-offtimes (rest a-list)
			   duration-index))))

#| Example:
(bass-steps '(((56 0 0) (60 1 1) (72 1 2))
	      ((58 1 3) (60 2 1) (72 3 2))
	      ((58 2 3) (65 1 4) (72 3 2))
	      ((56 0 5) (65 2 4) (72 2 2))
	      ((55 0 6) (64 0 7) (73 1 8))
	      ((NIL NIL NIL))
	      ((54 2 9) (70 2 10) (74 0 11))
	      ((59 0 12) (63 1 13) (75 1 14))))
gives
'(2 0 -2 -1 NIL NIL 5).

This function takes a list of sorted tie types and
returns the intervals between the bass notes of
adjacent concurrences. It handles null entries, but
these will have been removed if it is being called
by the function spacing-ties-states. |#

(defun bass-steps (sorted-ties-list &optional
		   (note-number-1
		    (first
		     (first
		      (first sorted-ties-list)))))
  (let ((note-number-2
	 (first (first (second sorted-ties-list)))))
    (if (equal (length sorted-ties-list) 1) ()
      (cons (if (or (null note-number-1)
		    (null note-number-2))
	      (identity NIL)
	      (- note-number-2 note-number-1))
	    (bass-steps (rest sorted-ties-list)
			note-number-2)))))

#| Example:
(chord-candidates-offtimes
 '((1579 66 191 2 49 1770 5) (1974 64 191 3 49 2165 2)
   (1974 67 191 2 49 2165 3) (2368 66 191 2 49 2559 0)
   (2368 62 191 3 49 2559 4) (2763 64 191 2 49 2954 6)
   (2763 57 191 3 49 2954 7) (2800 72 191 1 49 2991 8)
   (3158 38 191 4 49 3349 9)
   (1579 62 1920 3 49 3499 1)
   (3158 54 385 3 49 3543 10)
   (3158 62 385 2 49 3543 11)
   (3553 42 191 4 49 3744 12)
   (3947 45 191 4 49 4138 13)
   (4342 50 191 4 49 4533 14))
   15 2368 0)
gives
'(5 2 3).

There are four arguments to this function: a list of
cope-events (ordered by offtimes descending and
appended with an enumeration), the length l of the
list, a point in time x, and an index s from which to
begin searching. When the nth offtime equals or
exceeds x, the search stops. As subsequent calls to
this function use larger values of x, the search can
begin at the sth offtime. |#

(defun chord-candidates-offtimes (a-list l x s)
  (let ((event (nth s a-list)))
    (if (or (null x)
            (equal s l)
            (>= (sixth event) x)) ()
      (cons (my-last event)
	    (chord-candidates-offtimes
	     a-list l x (+ s 1))))))

#| Example:
(chord-candidates-ontimes
 '((1579 62 1920 3 49 3499 1)
   (1579 66 191 2 49 1770 5) (1974 64 191 3 49 2165 2)
   (1974 67 191 2 49 2165 3) (2368 66 191 2 49 2559 0)
   (2368 62 191 3 49 2559 4) (2763 64 191 2 49 2954 6)
   (2763 57 191 3 49 2820 7) (2800 72 191 1 49 2991 8)
   (3158 38 191 4 49 3349 9)
   (3158 54 385 3 49 3543 10)
   (3158 62 385 2 49 3543 11)
   (3553 42 191 4 49 3744 12)
   (3947 45 191 4 49 4138 13)
   (4342 50 191 4 49 4533 14))
   15 2368 0)
gives
'(1 5 2 3 0 4).

There are four arguments to this function: a list of
cope-events (ordered by ontimes and appended with
offtimes and an enumeration), the length l of the
list, a point in time x, and an index s from which to
begin searching. When the nth ontime exceeds x, the
search stops. As subsequent calls to this function
use larger values of x, the search can begin at the
sth ontime. |#

(defun chord-candidates-ontimes (a-list l x s)
  (let ((event (nth s a-list)))
    (if (or (null x)
            (equal s l)
	    (> (first event) x)) ()
      (cons (my-last event)
	    (chord-candidates-ontimes
	     a-list l x (+ s 1))))))

#| Example:
(spacing
 0 '((59 0 12) (63 1 13) (75 1 14)))
gives
'(4 12).

An index n is provided as first argument; a list of
lists is the second argument. The nth item of each
sub-list is a MIDI note number, and these sub-lists
are in order of ascending MIDI note number. The
intervals between adjacent notes (chord spacing) are
returned. It is possible to produce nonsense output
if null values are interspersed with non-null
values. |#

(defun spacing (index list-of-lists)
  (if (equal (length list-of-lists) 1) ()
    (cons
     (- (nth index (second list-of-lists))
	(nth index (first list-of-lists)))
     (spacing index (rest list-of-lists)))))

#| Example:
(concurrence 1579
	 '((2368 66 191 2 49) (1579 62 1920 3 49)
	   (1974 64 191 3 49) (1974 67 191 2 49)
	   (2368 62 191 3 49) (1579 66 191 2 49)
	   (2763 64 191 2 49) (2763 57 191 3 49)
	   (2800 72 191 1 49) (3158 38 191 4 49)
	   (3158 54 385 3 49) (3158 62 385 2 49)
	   (3553 42 191 4 49) (3947 45 191 4 49)
	   (4342 50 191 4 49))
	 15
	 '(((1579 62 1920 3 49 3499 1)
	    (1579 66 191 2 49 1770 5)
	    (1974 64 191 3 49 2165 2)
	    (1974 67 191 2 49 2165 3)
	    (2368 66 191 2 49 2559 0)
	    (2368 62 191 3 49 2559 4)
	    (2763 64 191 2 49 2954 6)
	    (2763 57 191 3 49 2820 7)
	    (2800 72 191 1 49 2991 8)
	    (3158 38 191 4 49 3349 9)
	    (3158 54 385 3 49 3543 10)
	    (3158 62 385 2 49 3543 11)
	    (3553 42 191 4 49 3744 12)
	    (3947 45 191 4 49 4138 13)
	    (4342 50 191 4 49 4533 14))
	   ((1579 66 191 2 49 1770 5)
	    (1974 64 191 3 49 2165 2)
	    (1974 67 191 2 49 2165 3)
	    (2368 66 191 2 49 2559 0)
	    (2368 62 191 3 49 2559 4)
	    (2763 64 191 2 49 2954 6)
	    (2763 57 191 3 49 2954 7)
	    (2800 72 191 1 49 2991 8)
	    (3158 38 191 4 49 3349 9)
	    (1579 62 1920 3 49 3499 1)
	    (3158 54 385 3 49 3543 10)
	    (3158 62 385 2 49 3543 11)
	    (3553 42 191 4 49 3744 12)
	    (3947 45 191 4 49 4138 13)
	    (4342 50 191 4 49 4533 14))))
gives
'(((1579 66 191 2 49) (1579 62 1920 3 49))
  (1 5) (14 13 12 11 10 9 8 7 6 5 4 3 2 1 0)).

This function takes an ontime t, a list of cope-events
of length N, with offsets and enumeration appended,
but in original order, as well as the cope-events
having had the function prepared-for-chords applied.
It returns any events which exist at the point t, as
well as lists which help speed up any subsequent
searches. |#

(defun concurrence (ontime events-with-offs&enums N
		       prepared-for-concurrences
	      &optional (previous-ontimes ())
	                (previous-offtimes
			 (add-to-list
			  -1
			  (reverse
			   (first-n-naturals N)))))
  (let* ((candidate-ontimes
	  (chord-candidates-ontimes
	   (first prepared-for-concurrences)
	   N ontime (length previous-ontimes)))
	 (candidate-offtimes
	  (chord-candidates-offtimes
	   (second prepared-for-concurrences)
	   N ontime (- N (length previous-offtimes))))
	 (new-ontimes 
	  (append previous-ontimes candidate-ontimes))
	 (new-offtimes
	  (set-difference previous-offtimes
			  candidate-offtimes)))
    (append
     (list
      (nth-list
       (intersection new-ontimes new-offtimes)
       events-with-offs&enums))
     (list new-ontimes)
     (list new-offtimes))))

#| Example:
(concurrences '((2368 66 191 2 49) (1579 62 1920 3 49)
	   (1974 64 191 3 49) (1974 67 191 2 49)
	   (2368 62 191 3 49) (1579 66 191 2 49)
	   (2763 64 191 2 49) (2763 57 191 3 49)
	   (2800 72 191 1 49) (3158 38 191 4 49)
	   (3158 54 385 3 49) (3158 62 385 2 49)
	   (3553 42 191 4 49) (3947 45 191 4 49)
	   (4342 50 191 4 49)))
gives
'((1579 ((1579 66 191 2 49 1770 5)
	 (1579 62 1920 3 49 3499 1)))
  (1770 ((1579 66 191 2 49 1770 5)
	 (1579 62 1920 3 49 3499 1)))
  (1974 ((1974 67 191 2 49 2165 3)
	 (1974 64 191 3 49 2165 2)
	 (1579 62 1920 3 49 3499 1)))
  (2165 ((1974 67 191 2 49 2165 3)
	 (1974 64 191 3 49 2165 2)
	 (1579 62 1920 3 49 3499 1)))
  (2368 ((2368 62 191 3 49 2559 4)
	 (2368 66 191 2 49 2559 0)
	 (1579 62 1920 3 49 3499 1)))
  (2559 ((2368 62 191 3 49 2559 4)
	 (2368 66 191 2 49 2559 0)
	 (1579 62 1920 3 49 3499 1)))
  (2763 ((2763 57 191 3 49 2954 7)
	 (2763 64 191 2 49 2954 6)
	 (1579 62 1920 3 49 3499 1)))
  (2800 ((2800 72 191 1 49 2991 8)
	 (2763 57 191 3 49 2954 7)
	 (2763 64 191 2 49 2954 6)
	 (1579 62 1920 3 49 3499 1)))
  (2954 ((2800 72 191 1 49 2991 8)
	 (2763 57 191 3 49 2954 7)
	 (2763 64 191 2 49 2954 6)
	 (1579 62 1920 3 49 3499 1)))
  (2991 ((2800 72 191 1 49 2991 8)
	 (1579 62 1920 3 49 3499 1)))
  (3158 ((3158 62 385 2 49 3543 11)
	 (3158 54 385 3 49 3543 10)
	 (3158 38 191 4 49 3349 9)
	 (1579 62 1920 3 49 3499 1)))
  (3349 ((3158 62 385 2 49 3543 11)
	 (3158 54 385 3 49 3543 10)
	 (3158 38 191 4 49 3349 9)
	 (1579 62 1920 3 49 3499 1)))
  (3499 ((3158 62 385 2 49 3543 11)
	 (3158 54 385 3 49 3543 10)
	 (1579 62 1920 3 49 3499 1)))
  (3543 ((3158 62 385 2 49 3543 11)
	 (3158 54 385 3 49 3543 10)))
  (3553 ((3553 42 191 4 49 3744 12)))
  (3744 ((3553 42 191 4 49 3744 12)))
  (3947 ((3947 45 191 4 49 4138 13)))
  (4138 ((3947 45 191 4 49 4138 13)))
  (4342 ((4342 50 191 4 49 4533 14)))
  (4533 ((4342 50 191 4 49 4533 14)))).

This function takes a list of cope-events as its
argument. First it creates a variable
containing the distinct times (on and off) of the
cope-events. Then it returns the concurrence for each
of these times. |#

(defun concurrences (cope-events &optional
                 (events-with-offs&enums
		  (enumerate-append
		   (append-offtimes cope-events)))
		 (unique-times
		  (unique-equalp
                   (append
                    (nth-list-of-lists
                     0 events-with-offs&enums)
                    (nth-list-of-lists
                     5 events-with-offs&enums))))
		 (N (length cope-events))		 
		 (prepared-for-concurrences
		  (prepare-for-concurrences
		   events-with-offs&enums))
		 (previous-ontimes ())
		 (previous-offtimes
		  (add-to-list
		   -1
		   (reverse
		    (first-n-naturals N)))))
  (let ((current-concurrence
	 (concurrence (first unique-times)
		  events-with-offs&enums
		  N prepared-for-concurrences
		  previous-ontimes previous-offtimes)))
    (if (null unique-times) ()
      (cons (list (first unique-times)
                  (first current-concurrence))
	    (concurrences
	     cope-events events-with-offs&enums
             (rest unique-times) N
	     prepared-for-concurrences
	     (second current-concurrence)
	     (third current-concurrence))))))

#| Example:
(enumerate-append '((3 53) (6 0) (42 42)))
gives
'((3 53 1) (6 0 2) (42 42 3)).

This function enumerates a list by appending the next
natural number, counting from 0, to the end of each
list. |#
  
(defun enumerate-append (a-list &optional
				(i 0)
				(n (length a-list)))
  (if (>= i n) ()
    (cons (append (first a-list) (list i))
          (enumerate-append (rest a-list)
			    (+ i 1) n))))

#| Example:
(index-rests '(((59 0 12) (63 0 13) (75 0 14))
	       NIL ((60 1 15) (63 0 16))
	       ((60 2 15)) (NIL NIL NIL)))
gives
'(1).

A list of sorted ties is the only argument to this
function. The output is the indices of those
sub-lists which are empty (excluding the last sub-
list) and therefore harbour rests. |#

(defun index-rests (sorted-ties-list &optional
		    (n (- (length sorted-ties-list)
			  1))
		    (j 0))
  (if (equal j n) ()
    (append
     (if (null
	  (first (first (first sorted-ties-list))))
       (list (identity j)))
     (index-rests (rest sorted-ties-list)
		  n (+ j 1)))))

#| Example:
(intervals-above-bass
 0 '((59 0 12) (63 1 13) (75 1 14)))
gives
'(0 4 16).

An index n is provided as first argument; a list of
lists is the second argument. The nth item of each
sub-list is a MIDI note number, and these sub-lists
are in order of ascending MIDI note number. The
intervals above the bass are returned. It is possible
to produce nonsense output if null values are
interspersed with non-null values. I use the function
chord-spacing in preference to the function
intervals-above-bass. |#

(defun intervals-above-bass
       (index ascending-list-of-lists
	&optional
	(min-note-number
	 (nth
	  index (first ascending-list-of-lists))))
  (if (or (null min-note-number)
	  (null ascending-list-of-lists)) ()
    (cons (- (nth index
		  (first ascending-list-of-lists))
	     min-note-number)
	  (intervals-above-bass
	   index (rest ascending-list-of-lists)
	   min-note-number))))

#| Example:
(nth-list '(1 3 0) '(6 -3 -88 0 4 44))
gives
'(-3 0 6).

This function applies the function nth recursively to
the second list argument, according to the items of
the first list argument. |#

(defun nth-list (a-list b-list)
  (if (null a-list) ()
    (cons (nth (first a-list) b-list)
          (nth-list (rest a-list) b-list))))

#| Example:
(nth-list-of-lists 0 '((48 2) (-50 0) (-5 5)))
gives
'(48 -50 5).

This function takes two arguments; an item n and a
list of sub-lists. It returns the nth item of each
sub-list as a list. |#

(defun nth-list-of-lists (item a-list)
  (if (null a-list) ()
    (cons (nth item (first a-list))
          (nth-list-of-lists item (rest a-list)))))

#| Example:
(prepare-for-concurrences
 '((2368 66 191 2 49 2559 0)
   (1579 62 1920 3 49 3499 1)
   (1974 64 191 3 49 2165 2) (1974 67 191 2 49 2165 3)
   (2368 62 191 3 49 2559 4) (1579 66 191 2 49 1770 5)
   (2763 64 191 2 49 2954 6) (2763 57 191 3 49 2954 7)
   (2800 72 191 1 49 2991 8) (3158 38 191 4 49 3349 9)
   (3158 54 385 3 49 3543 10)
   (3158 62 385 2 49 3543 11)
   (3553 42 191 4 49 3744 12)
   (3947 45 191 4 49 4138 13)
   (4342 50 191 4 49 4533 14)))
gives
'(((1579 62 1920 3 49 3499 1)
   (1579 66 191 2 49 1770 5) (1974 64 191 3 49 2165 2)
   (1974 67 191 2 49 2165 3) (2368 66 191 2 49 2559 0)
   (2368 62 191 3 49 2559 4) (2763 64 191 2 49 2954 6)
   (2763 57 191 3 49 2820 7) (2800 72 191 1 49 2991 8)
   (3158 38 191 4 49 3349 9)
   (3158 54 385 3 49 3543 10)
   (3158 62 385 2 49 3543 11)
   (3553 42 191 4 49 3744 12)
   (3947 45 191 4 49 4138 13)
   (4342 50 191 4 49 4533 14))
  ((1579 66 191 2 49 1770 5) (1974 64 191 3 49 2165 2)
   (1974 67 191 2 49 2165 3) (2368 66 191 2 49 2559 0)
   (2368 62 191 3 49 2559 4) (2763 64 191 2 49 2954 6)
   (2763 57 191 3 49 2954 7) (2800 72 191 1 49 2991 8)
   (3158 38 191 4 49 3349 9)
   (1579 62 1920 3 49 3499 1)
   (3158 54 385 3 49 3543 10)
   (3158 62 385 2 49 3543 11)
   (3553 42 191 4 49 3744 12)
   (3947 45 191 4 49 4138 13)
   (4342 50 191 4 49 4533 14))).

The cope-events have offtimes appended, are
enumerated, and sent to two lists; one ordered by
ontime, the other by offtime. |#

(defun prepare-for-concurrences (a-list)
  (append
     (list (sort-by '((0 "asc")) a-list))
     (list (sort-by '((5 "asc")) a-list))))

#| Example:
(remove-nth-list '(0 3 0 5) '(1 2 3 4 5 6 7))
gives
'(2 3 5 7).

The function remove-nth-list applies the function
remove-nth recursively to the second argument,
according to the indices in the first argument, which
do not have to be ordered or distinct. |#

(defun remove-nth-list (a-list b-list &optional
		       (c-list
			(reverse
			 (unique-equalp a-list))))
  (if (null c-list) (identity b-list)
    (remove-nth-list
     a-list (remove-nth (first c-list) b-list)
     (rest c-list))))

#| Example:
(sort-tie-types '(((72 1 2) (60 1 1) (56 0 0))
		  ((NIL NIL NIL))
		  ((58 1 3) (72 3 2) (58 3 1))))
gives
'(((56 0 0) (60 1 1) (72 1 2))
  ((NIL NIL NIL))
  ((58 1 3) (58 3 1) (72 3 2))).

The sub-lists are returned, ordered by MIDI note
number and then tie-type (both ascending). The
function checks for empty chords to avoid errors
occurring in the sort function. |#

(defun sort-tie-types (ties-list)
  (let ((first-ties (first ties-list)))
    (if (null ties-list) ()
      (cons
       (if (equalp (first (first first-ties)) NIL)
	 (identity first-ties)
	 (sort-by '((0 "asc") (1 "asc")) first-ties))
       (sort-tie-types (rest ties-list))))))

#| Example:
(spacing-ties-states '((0 74 1/2 1 84) (0 52 1 2 84)
 (1/2 76 1/4 1 84) (3/4 78 1/4 1 84) (1 80 1/4 1 84)
 (5/4 81 1/4 1 84) (3/2 83 1/2 1 84) (4 67 1 2 84)
 (4 64 1 2 84) (4 79 1/2 1 84) (9/2 78 1/2 1 84)
 (5 67 1 2 84) (5 64 1 2 84) (5 76 2 1 84))
 "D Scarlatti L484")
gives
'((((22) (1 0)) (NIL 1/2 "D Scarlatti L484"
		 ((0 52 1 2 84 1 1)
		  (0 74 1/2 1 84 1/2 0))))
  (((24) (3 0)) (0 1/4 "D Scarlatti L484"
		 ((0 52 1 2 84 1 1)
		  (1/2 76 1/4 1 84 3/4 2))))
  (((26) (2 0)) (0 1/4 "D Scarlatti L484"
		 ((0 52 1 2 84 1 1)
		  (3/4 78 1/4 1 84 1 3))))
  ((NIL (0)) (28 1/4 "D Scarlatti L484"
	      ((1 80 1/4 1 84 5/4 4))))
  ((NIL (0)) (1 1/4 "D Scarlatti L484"
	      ((5/4 81 1/4 1 84 3/2 5))))
  ((NIL (0)) (2 5/2 "D Scarlatti L484"
	      ((3/2 83 1/2 1 84 2 6))))
  (((3 12) (1 1 0)) (-19 1/2 "D Scarlatti L484"
		     ((4 64 1 2 84 5 8)
		      (4 67 1 2 84 5 7)
		      (4 79 1/2 1 84 9/2 9))))
  (((3 11) (2 2 0)) (0 1/2 "D Scarlatti L484"
		     ((4 64 1 2 84 5 8)
		      (4 67 1 2 84 5 7)
		      (9/2 78 1/2 1 84 5 10))))
  (((3 9) (0 0 1)) (0 1 "D Scarlatti L484"
		    ((5 64 1 2 84 6 12)
		     (5 67 1 2 84 6 11)
		     (5 76 2 1 84 7 13))))
  ((NIL (2)) (12 1 "D Scarlatti L484"
		 ((5 76 2 1 84 7 13))))).

This function takes cope events as its argument, and
some optional catalogue information about those
events. It converts the input into a list of sub-
lists, with each sub-list consisting of a pair of
lists. The first of the pair contains a chord spacing,
followed by tie types relating to the notes of the
chord. The second of the pair retains the following
information: the step (in semitones) between the bass
note of the previous chord and the current state; the
duration of the state (which can exceed the minimum
duration of the constituent cope events if rests are
present); the catalogue information; the relevant
original cope-events, with offtimes and enumeration
appended. |#

(defun spacing-ties-states
       (cope-events &optional
	(catalogue-information "no information")
	(events-with-offs&enums
	 (enumerate-append
	  (append-offtimes cope-events)))
	(unique-times
	 (unique-equalp
	  (union
	   (nth-list-of-lists
	    0 events-with-offs&enums)
	   (nth-list-of-lists
	    5 events-with-offs&enums))))
	(sorted-ties-list
	 (sort-tie-types
	  (tie-types
	   (concurrences cope-events
			 events-with-offs&enums
			 unique-times))))
	(indexed-rests (index-rests
			sorted-ties-list))
	(unique-times (remove-nth-list
		       indexed-rests
		       unique-times))
	(sorted-ties-list (remove-nth-list
			   indexed-rests
			   sorted-ties-list))
	(bass-steps-list
	 (cons NIL (bass-steps sorted-ties-list))))
  (let ((sorted-ties (first sorted-ties-list)))
    (if (equal (length unique-times) 1) ()
      (cons
       (list
	(append
	 (list (spacing 0 sorted-ties))
	 (list (nth-list-of-lists 1 sorted-ties)))
	(list
	 (first bass-steps-list)
	 (- (second unique-times)
	    (first unique-times))
	 catalogue-information
	 (nth-list (nth-list-of-lists 2 sorted-ties)
		    events-with-offs&enums)))
       (spacing-ties-states
	cope-events catalogue-information
	events-with-offs&enums (rest unique-times)
	(rest sorted-ties-list) indexed-rests
	(rest unique-times)
	(rest sorted-ties-list)
	(rest bass-steps-list))))))

#| Example:
(tie-type '(1/2 ((1/2 65 1/2 1 58 1 4)
		 (1/3 58 1/3 1 69 2/3 3)
		 (0 72 1 1 71 1 2)
		 (0 60 1/2 1 66 1/2 1)))
	  '(2/3 ((2/3 56 1/3 1 60 1 5)
		 (1/2 65 1/2 1 58 1 4)
		 (1/3 58 1/3 1 69 2/3 3)
		 (0 72 1 1 71 1 2)))
	  '(1 ((1 73 3/2 1 69 5/2 8)
	       (1 64 1 1 69 2 7) (1 55 1 1 66 2 6)
	       (2/3 56 1/3 1 60 1 5)
	       (1/2 65 1/2 1 58 1 4)
	       (0 72 1 1 71 1 2))))
gives
'((56 0 5) (65 2 4) (72 2 2)).

The function tie-type calls to one of tie-type-start,
tie-type-normal or tie-type-finish, according to the
emptiness of its arguments. |#

(defun tie-type (previous-concurrence
		 current-concurrence
		 next-concurrence)
  (if (or (null previous-concurrence)
	  (null next-concurrence))
    (if (null previous-concurrence)
      (tie-type-start current-concurrence
		      next-concurrence)
      (tie-type-finish previous-concurrence
		       current-concurrence))
    (tie-type-normal previous-concurrence
		     current-concurrence
		     next-concurrence)))

#| Example:
(tie-type-finish '(11/2 ((4 67 2 1 55 6 20) (4 76 3/2 1 69 11/2 18)))
		 '(6 ((4 67 2 1 55 6 20))))
gives
'(NIL NIL NIL).

The function tie-type-finish is called by the function
tie-type in the event that the variable
next-concurrence is empty. This only happens at the
end of a list of concurrences. I am yet to think of an
example where something other than an empty list
should be returned. |#

(defun tie-type-finish (previous-concurrence
			current-concurrence
			&optional
			 (previous-list
			  (nth-list-of-lists
			   6
			   (second
			    previous-concurrence)))
			 (current-list
			  (nth-list-of-lists
			   6
			   (second
			    current-concurrence)))
			 (n (length current-list))
			 (j 0))
  (let* ((i (nth j current-list)))
    (if (equal j n) ()
      (if (equalp
           (nth 5 (nth
                   (index-item-1st-occurs
                    i current-list)
                   (second current-concurrence)))
           (first current-concurrence))
	(cons
         (list NIL NIL NIL)
         (tie-type-finish
          previous-concurrence
	  current-concurrence
          previous-list
          current-list
	  n (+ j 1)))
	(identity
	 "error - event beyond final offtime")))))

#| Example:
(tie-type-normal '(0 ((0 72 1 1 71 1 2)
		     (0 60 1/2 1 66 1/2 1)
		     (0 56 1/3 1 47 1/3 0)))
		'(1/3 ((1/3 58 1/3 1 69 2/3 3)
		       (0 72 1 1 71 1 2)
		       (0 60 1/2 1 66 1/2 1)
		       (0 56 1/3 1 47 1/3 0)))
		'(1/2 ((1/2 65 1/2 1 58 1 4)
		       (1/3 58 1/3 1 69 2/3 3)
		       (0 72 1 1 71 1 2)
		       (0 60 1/2 1 66 1/2 1))))
gives '((58 1 3) (72 3 2) (60 2 1)).

The function tie-type-normal is called by the function
tie-type, in 'non-boundary circumstances'. Tie types
are assigned appropriately, and returned as the second
item in a sublist of lists, along with MIDI note
numbers and identifiers. |#

(defun tie-type-normal (previous-concurrence
			current-concurrence
			next-concurrence
			&optional
			 (previous-list
                         (nth-list-of-lists
                          6
                          (second
                           previous-concurrence)))
			 (current-list
			  (nth-list-of-lists
			   6
			   (second
			    current-concurrence)))
			 (next-list
			  (nth-list-of-lists
			   6
			   (second
			    next-concurrence)))
			 (n (length
			     current-list))
			 (j 0))
  (let* ((i (nth j current-list)))
    (if (equal j n) ()
      (if (equalp
           (nth 5 (nth
                   (index-item-1st-occurs
                    i current-list)
                   (second current-concurrence)))
           (first current-concurrence))
	(append '()
		(tie-type-normal
		 previous-concurrence
		 current-concurrence
		 next-concurrence
		 previous-list
		 current-list
		 next-list
		 n (+ j 1)))
	(cons
	     (list (second
		    (nth
		     (index-item-1st-occurs
		      i current-list)
		     (second current-concurrence)))
		   (if (not (member i previous-list))
		     (if (equalp
			  (nth
			   5
			   (nth
			    (index-item-1st-occurs
			     i next-list)
			    (second next-concurrence)))
			  (first next-concurrence))
		       (identity 0)
		       (identity 1))
		     (if (equalp
			  (nth
			   5
			   (nth
			    (index-item-1st-occurs
			     i next-list)
			    (second next-concurrence)))
			  (first next-concurrence))
		       (identity 2)
		       (identity 3)))
		   (my-last
		    (nth
		     (index-item-1st-occurs
		      i current-list)
		     (second current-concurrence))))
	     (tie-type-normal
		 previous-concurrence
		 current-concurrence
		 next-concurrence
		 previous-list
		 current-list
		 next-list
		 n (+ j 1)))))))

#| Example:
(tie-type-start '(0 ((0 72 1 1 71 1 2)
		     (0 60 1/2 1 66 1/2 1)
		     (0 56 1/3 1 47 1/3 0)))
		'(1/3 ((1/3 58 1/3 1 69 2/3 3)
		       (0 72 1 1 71 1 2)
		       (0 60 1/2 1 66 1/2 1)
		       (0 56 1/3 1 47 1/3 0))))
gives '((72 1) (60 1) (56 0)).

The function tie-type-start is called by the function
tie-type in the event that the variable
previous-concurrence is empty. This only happens at
the beginning of a list of concurrences. Tie types
are assigned appropriately, and returned as the second
item in a sublist of lists, along with MIDI note
numbers and identifiers. It is possible to generate an
error using this function, if there are ontimes less
than the initial ontime present. |#

(defun tie-type-start (current-concurrence
                       next-concurrence
                       &optional
                        (current-list
                         (nth-list-of-lists
                          6
                          (second
                           current-concurrence)))
                        (next-list
                         (nth-list-of-lists
                          6
                          (second
                           next-concurrence))))
  (let* ((i (first current-list)))
    (if (null current-list) ()
      (if (equalp
           (nth 5 (nth
                   (index-item-1st-occurs
                    i next-list)
                   (second next-concurrence)))
           (first next-concurrence))
        (cons
         (list (second
		(nth
		 (index-item-1st-occurs
		  i next-list)
		 (second next-concurrence)))
	       0
	       (my-last
		(nth
		 (index-item-1st-occurs
		  i next-list)
		 (second next-concurrence))))
         (tie-type-start
          current-concurrence
          next-concurrence
          (rest current-list)
          next-list))
        (cons
         (list (second
		(nth
		 (index-item-1st-occurs
		  i next-list)
		 (second next-concurrence)))
	       1
	       (my-last
		(nth
		 (index-item-1st-occurs
		  i next-list)
		 (second next-concurrence))))
         (tie-type-start
          current-concurrence
          next-concurrence
          (rest current-list)
          next-list))))))

#| Example:
(tie-types '((0 ((0 72 1 1 71 1 2)
		 (0 60 1/2 1 66 1/2 1)
		 (0 56 1/3 1 47 1/3 0)))
	     (1/3 ((1/3 58 1/3 1 69 2/3 3)
		   (0 72 1 1 71 1 2)
		   (0 60 1/2 1 66 1/2 1)
		   (0 56 1/3 1 47 1/3 0)))
	     (1/2 ((1/2 65 1/2 1 58 1 4)
		   (1/3 58 1/3 1 69 2/3 3)
		   (0 72 1 1 71 1 2)
		   (0 60 1/2 1 66 1/2 1)))
	     (2/3 ((2/3 56 1/3 1 60 1 5)
		   (1/2 65 1/2 1 58 1 4)
		   (1/3 58 1/3 1 69 2/3 3)
		   (0 72 1 1 71 1 2)))
	     (1 ((2/3 56 1/3 1 60 1 5)
		 (1/2 65 1/2 1 58 1 4)
		 (0 72 1 1 71 1 2)))))
gives
'(((72 1 2) (60 1 1) (56 0 0))
  ((58 1 3) (72 3 2) (60 2 1))
  ((65 1 4) (58 2 3) (72 3 2))
  ((56 0 5) (65 2 4) (72 2 2))
  ((NIL NIL NIL) (NIL NIL NIL) (NIL NIL NIL))).

This function assigns tie-types to the events at each
concurrence: 0 for untied; 1 for tied-forward; 2 for
tied-backward; 3 for tied-both. This information is
returned, along with the MIDI note numbers and
identifiers. |#

(defun tie-types (concurrences-list &optional
                  (n (length concurrences-list))
                  (i 0)
                  (previous-concurrence '())
                  (next-concurrence
                   (second concurrences-list)))
  (let ((current-concurrence (first
                              concurrences-list)))
    (if (null concurrences-list) ()
      (cons (tie-type previous-concurrence
                      current-concurrence
                      next-concurrence)
            (tie-types (rest concurrences-list)
                       n (+ i 1)
                       current-concurrence)))))

#| Example:
(unique-equalp '(48 50 48 58 51 104/2 52))
gives
'(48 50 51 52 58).

The unique items of a list are returned, according to
the criterion equalp. |#

(defun unique-equalp
       (a-list &optional
               (sorted-list
                (if (null a-list) ()
                  (sort
                   (copy-list a-list) #'<))))
  (if (<= (length sorted-list) 1)
    (identity sorted-list)
    (if (equalp (first sorted-list)
		(second sorted-list))
      (unique-equalp a-list (rest sorted-list))
      (cons (first sorted-list)
            (unique-equalp a-list
			   (rest sorted-list))))))