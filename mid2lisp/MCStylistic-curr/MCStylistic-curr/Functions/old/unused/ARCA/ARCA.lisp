;;(in-package :common-lisp-user)
;;(choose-database "Chorale harmonizations by Johann Sebastian Bach")
;;(choose-database "Mazurkas by Frederic Chopin")
;;(saveit "all-choices.mid" *all2events*)

(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-compose.lisp")
(load "//Applications/CCL/Lisp code/midi-save.lisp")

(defvar *index-choice* '())
(defvar *number-of-possible-choices* '())
(defvar *unchosen* '())

(defvar *database-name* '())
(defvar *initial-states* '())
(defvar *stm* '())
(defvar *relevant-row* '())

(defvar *current-choice* '())
(defvar *last-five-choices* '())
(defvar *last-five-sources* '())
(defvar *no-save-state* NIL)
(defvar *all-choices* '())

(defvar *first-bass-note* '())
(defvar *scale-factor* '())
(defvar *warnings* '())

(defvar *all-half-states* '())
(defvar *all2events* '())
(defvar *last-five2events* '())
(defvar *current2events* '())

(defun accept
       (&optional
	(biased-sources
	 (test-last-five-sources *last-five-sources*))
	(out-of-range
	 (if (not (null *all-half-states*))
	   (test-range (my-last *all-half-states*)))))
  (if (or biased-sources out-of-range)
    (progn
      (setq *no-save-state* T)
      (if biased-sources
	(if out-of-range
	  (setq *warnings*
		"Three or more consecutive choices
		 come from the same source. Also, the
		 choice made is out of the piano
		 range. Please use the double reject
		 button to revise choices.")
	  (setq *warnings*
		"Three or more consecutive choices
		 come from the same source. Please
		 use the double reject button to
		 revise choices."))
	(setq *warnings*
	      "The choice made is out of the piano
	       range. Please use the double reject
	       button to revise choices.")))
    (progn
      (setq *relevant-row*
	    (second
	     (assoc
	      (first *current-choice*)
	      *stm*
	      :test #'equalp)))
      (setq *number-of-possible-choices*
	    (length *relevant-row*))
      (setq *unchosen*
	    (first-n-naturals
	     *number-of-possible-choices*))
      (setq *index-choice* (choose-one *unchosen*))
      (setq *unchosen*
	    (remove *index-choice* *unchosen*))
      (setq *current-choice*
	    (nth (1- *index-choice*)
		 *relevant-row*))
      (setq *last-five-choices*
	    (append
	     (if (<
		  (length *last-five-choices*) 5)
	       (identity *last-five-choices*)
	       (lastn 4 *last-five-choices*))
	     (list *current-choice*)))
      (setq *last-five-sources*
	    (append
	     (if
		 (<
		  (length *last-five-sources*) 5)
	       (identity *last-five-sources*)
	       (lastn 4 *last-five-sources*))
	     (list
	      (third (second *current-choice*)))))
      (setq *all-choices*
	    (append *all-choices*
		    (list *current-choice*)))
      (setq *all-half-states*
	    (create-MIDI-note-numbers
	     *all-choices*
	     *first-bass-note*))
      (setq *all2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      *all-choices*
	      *first-bass-note*
	      *all-half-states*)))
      (setq *last-five2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      (lastn 5 *all-choices*)
	      (first
	       (first
		(first
		 (first
		  (lastn 5 *all-half-states*)))))
	      (lastn 5 *all-half-states*))))
      (setq *current2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      (last *all-choices*)
	      (first
	       (first
		(first
		 (my-last *all-half-states*))))
	      (last *all-half-states*))))
      (saveit "current-choice.mid"
	      *current2events*)
      (saveit "last-five-choices.mid"
	      *last-five2events*)
      (saveit "all-choices.mid"
	      *all2events*))))

(defun choose-one-without-replacement (unchosen n)
  (if (null unchosen)
    (choose-one (first-n-naturals n))
    (choose-one unchosen)))

(defun choose-database (&optional
       (database-name "Chorale harmonizations by Johann Sebastian Bach")
       (first-bass-note
        (if (equal
             database-name
             "Chorale harmonizations by Johann Sebastian Bach")
          (identity 48) (identity 55)))
       (scale-factor
        (if (equal
             database-name
             "Chorale harmonizations by Johann Sebastian Bach")
          (identity 1) (identity 1000))))
  (if (equal
             database-name
             "Chorale harmonizations by Johann Sebastian Bach")
    (progn
      (load "//Applications/CCL/Lisp code/Markov models/Bach chorale model (score MIDI)/bach-transition-matrix.lisp")
      (load "//Applications/CCL/Lisp code/Markov models/Bach chorale model (score MIDI)/bach-initial-states.lisp"))
    (progn
      (load "//Applications/CCL/Lisp code/Markov models/Chopin mazurka model (score MIDI)/chopin-transition-matrix.lisp")
      (load "//Applications/CCL/Lisp code/Markov models/Chopin mazurka model (score MIDI)/chopin-initial-states.lisp")))
  (setq *database-name* database-name)
  (setq *number-of-possible-choices*
        (length *initial-states*))
  (setq *unchosen*
        (first-n-naturals
         *number-of-possible-choices*))
  (setq *index-choice* (choose-one *unchosen*))
  (setq *unchosen*
        (remove *index-choice* *unchosen*))
  (setq *first-bass-note* first-bass-note)
  (setq *scale-factor* scale-factor)
  (setq *current-choice*
        (nth (1- *index-choice*)
             *initial-states*))
  (setq *current2events*
        (scale-cope-events-by-factor
         *scale-factor*
         (states2cope-events
          (list *current-choice*)
          *first-bass-note*)))
  (saveit "current-choice.mid" *current2events*)
  (setq *last-five-choices*
        (list *current-choice*))
  (saveit "last-five-choices.mid" *current2events*)
  (setq *last-five-sources*
        (list (third (second *current-choice*))))
  (setq *all-choices*
        (list *current-choice*))
  (saveit "all-choices.mid" *current2events*))

(defun reject ()
  (setq *last-five-choices*
	(butlast *last-five-choices*))
  (setq *last-five-sources*
	(butlast *last-five-sources*))
  (setq *all-choices*
	(butlast *all-choices*))
  (setq *index-choice*
	(choose-one-without-replacement
	 *unchosen* *number-of-possible-choices*))
  (setq *unchosen*
        (remove
	 *index-choice*
	 (if (null *unchosen*)
	   (first-n-naturals
	    *number-of-possible-choices*)
	   *unchosen*)))
  (setq *current-choice*
	(nth (1- *index-choice*)
	     (if (null *all-choices*)
	       (identity *initial-states*)
	       (identity *relevant-row*))))
  (setq *last-five-choices*
	(append *last-five-choices*
		(list *current-choice*)))
  (setq *last-five-sources*
	(append
	 *last-five-sources*
	 (list (third (second *current-choice*)))))
  (setq *all-choices*
	(append *all-choices*
		(list *current-choice*)))
  (setq *all-half-states*
	(create-MIDI-note-numbers
	 *all-choices*
	 *first-bass-note*))
  (setq *all2events*
	(scale-cope-events-by-factor
	 *scale-factor*
	 (states2cope-events
	  *all-choices*
	  *first-bass-note*
	  *all-half-states*)))
  (setq *last-five2events*
	(scale-cope-events-by-factor
	 *scale-factor*
	 (states2cope-events
	  (lastn 5 *all-choices*)
	  (first
	   (first
	    (first
	     (first
	      (lastn 5 *all-half-states*)))))
	  (lastn 5 *all-half-states*))))
  (setq *current2events*
	(scale-cope-events-by-factor
	 *scale-factor*
	 (states2cope-events
	  (last *all-choices*)
	  (first
	   (first
	    (first
	     (my-last *all-half-states*))))
	  (last *all-half-states*))))
  (saveit "current-choice.mid" *current2events*)
  (saveit "last-five-choices.mid" *last-five2events*)
  (saveit "all-choices.mid" *all2events*))

(defun reject-reject ()
  (setq *no-save-state* NIL)
  (setq *warnings* '())
  (setq *last-five-choices*
	(lastn 4
	       (butlast
		(butlast *last-five-choices*))))
  (setq *last-five-sources*
	(butlast (butlast *last-five-sources*)))
  (setq *all-choices*
	(butlast (butlast *all-choices*)))
  (setq *current-choice* (my-last *all-choices*))
  (if (null *current-choice*)
    (progn
      (setq *number-of-possible-choices*
	    (length *initial-states*))
      (setq *unchosen*
	    (first-n-naturals
	     *number-of-possible-choices*))
      (setq *index-choice* (choose-one *unchosen*))
      (setq *unchosen*
	    (remove *index-choice* *unchosen*))
      (setq *current-choice*
	    (nth (1- *index-choice*)
		 *initial-states*))
      (setq *current2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      (list *current-choice*)
	      *first-bass-note*)))
      (saveit "current-choice.mid" *current2events*)
      (setq *last-five-choices*
	    (list *current-choice*))
      (saveit "last-five-choices.mid" *current2events*)
      (setq *last-five-sources*
	    (list (third (second *current-choice*))))
      (setq *all-choices*
	    (list *current-choice*))
      (saveit "all-choices.mid" *current2events*))
    (progn
      (setq *relevant-row*
	    (second
	     (assoc
	      (first *current-choice*)
	      *stm*
	      :test #'equalp)))
      (setq *number-of-possible-choices*
	    (length *relevant-row*))
      (setq *unchosen*
	    (first-n-naturals
	     *number-of-possible-choices*))
      (setq *index-choice* (choose-one *unchosen*))
      (setq *unchosen*
	    (remove *index-choice* *unchosen*))
      (setq *current-choice*
	    (nth (1- *index-choice*)
		 *relevant-row*))
      (setq *last-five-choices*
	    (append
	     *last-five-choices*
	     (list *current-choice*)))
      (setq *last-five-sources*
	    (append
	     *last-five-sources*
	     (list
	      (third (second *current-choice*)))))
      (setq *all-choices*
	    (append *all-choices*
		    (list *current-choice*)))
      (setq *all-half-states*
	    (create-MIDI-note-numbers
	     *all-choices*
	     *first-bass-note*))
      (setq *all2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      *all-choices*
	      *first-bass-note*
	      *all-half-states*)))
      (setq *last-five2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      (lastn 5 *all-choices*)
	      (first
	       (first
		(first
		 (first
		  (lastn 5 *all-half-states*)))))
	      (lastn 5 *all-half-states*))))
      (setq *current2events*
	    (scale-cope-events-by-factor
	     *scale-factor*
	     (states2cope-events
	      (last *all-choices*)
	      (first
	       (first
		(first
		 (my-last *all-half-states*))))
	      (last *all-half-states*))))
      (saveit "current-choice.mid"
	      *current2events*)
      (saveit "last-five-choices.mid"
	      *last-five2events*)
      (saveit "all-choices.mid"
	      *all2events*))))

(defun test-last-five-sources
       (last-5-sources &optional
	(L (length last-5-sources)))
  (if (< L 3)
    (identity NIL)
    (if (equal L 3)
      (if (and
	   (equal
	    (first last-5-sources)
	    (second last-5-sources))
	   (equal
	    (second last-5-sources)
	    (third last-5-sources)))
	(identity T))
      (if (equal L 4)
	(if (or
	     (and
	      (equal
	       (first last-5-sources)
	       (second last-5-sources))
	      (equal
	       (second last-5-sources)
	       (third last-5-sources)))
	     (and
	      (equal
	       (second last-5-sources)
	       (third last-5-sources))
	      (equal
	       (third last-5-sources)
	       (fourth last-5-sources))))
	  (identity T))
	(if (or
	     (and
	      (equal
	       (first last-5-sources)
	       (second last-5-sources))
	      (equal
	       (second last-5-sources)
	       (third last-5-sources)))
	     (and
	      (equal
	       (second last-5-sources)
	       (third last-5-sources))
	      (equal
	       (third last-5-sources)
	       (fourth last-5-sources)))
	     (and
	      (equal
	       (third last-5-sources)
	       (fourth last-5-sources))
	      (equal
	       (fourth last-5-sources)
	       (fifth last-5-sources))))
	  (identity T))))))

(defun test-range (half-state)
  (if (or
       (< (first
	   (first
	    (first half-state)))
	  21)
       (> (my-last
	   (first
	    (first half-state)))
	  108))
    (identity T)))