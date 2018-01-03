(setq
 *music-data-root*
 (make-pathname
  :directory
  '(:absolute
    "Users" "tomthecollins" "Shizz" "repos"
    "collCodeInit" "private" "core" "lisp"
    "2014" "myExtraExamples")))

(setq
 path&name
 (merge-pathnames
  (make-pathname
   :directory '(:relative "Kern")
   :name "C-24-2-ed" :type "txt")
  *MCStylistic-MonthYear-data-path*))
(setq
 point-set
 (kern-file2dataset-by-col path&name))
"Yes!"

(setq
 *music-data-root*
 (make-pathname
  :directory
  '(:absolute
    "Users" "tomthecollins" "Shizz" "DeMontfort"
    "Projects" "MediaEval" "training_v1")))
(setq
 path&name
 (merge-pathnames
  (make-pathname
   :name "f1" :type "krn")
  *music-data-root*))
(setq
 path&name
 (merge-pathnames
  (make-pathname
   :name "f6_v2" :type "krn")
  *music-data-root*))
(setq
 point-set
 (kern-file2dataset-by-col path&name))
(setq anacrusis -1)
(setq
 point-set
 (mapcar
  #'(lambda (x)
      (cons (+ (first x) anacrusis) (rest x)))
  point-set))
"Yes!"


(texture-from-kern path&name)



#| NOT REQUIRED BECAUSE MELODIC INTERVAL CAN STILL BE
MULTIPLE VOICES WITHIN STAVE.
\noindent Example:
\begin{verbatim}
(monophonise-folded
 '((13 55 3 1) (13 60 2 0) (13 64 1 0) (14 55 2 0)
   (15 55 1/2 1) (15 59 1/2 1) (15 65 1/2 0)
   (15 55 1/2 0))
   0 1 2 3 "top-line-verbose")
--> (((13 64 1 0) (14 55 2 0) (15 65 1/2 0))
     ((13 55 3 1) (15 59 1/2 1)))
(monophonise-folded
 '((13 55 3 1) (13 60 2 0) (13 64 1 0) (14 55 2 0)
   (15 55 1/2 1) (15 59 1/2 1) (15 65 1/2 0)
   (15 55 1/2 0))
   0 1 2 3 "sky-line-clipped")
--> (((13 64 1 0) (14 55 2 0) (15 65 1/2 0))
     ((13 55 3 1) (15 59 1/2 1)))
\end{verbatim}

\noindent This function segments the input point set
into different point sets depending on the value in
the staff index. For each distinct ontime in each
point set, it returns the point (all provided
dimensions returned) with maximum pitch as a member
of a list.

\emph{Unlike} the function \nameref{fun:monophonise},
this function does not translate (or 'unfold')
point sets belonging to successive staves.

The mapping to maximum pitch is done in one of two
ways, depending on the variable monophonise-fn. If set
to sky-line-clipped, it applies this function,
clipping any within-voice overlapping notes so that
each line is strictly monophonic. If set to
top-line-verbose, it applies this function, where
within-voice overlapping notes are still permitted. |#

(defun monophonise-folded
       (point-set &optional
        (ontime-index 0) (sort-index 1)
        (duration-index 3) (staff-index 4)
        (monophonise-fn "sky-line-clipped")
        (unique-staves
         (remove-duplicates
          (sort
           (nth-list-of-lists
            staff-index point-set) #'<)
          :test #'equalp)))
  (if (string= monophonise-fn "sky-line-clipped")
    (mapcar
     #'(lambda (x)
         (sky-line-clipped
          (dataset-restricted-to-m-in-nth
           point-set x staff-index) ontime-index
           sort-index duration-index)) unique-staves)
    (mapcar
     #'(lambda (x)
         (top-line-verbose
          (dataset-restricted-to-m-in-nth
            point-set x staff-index) sort-index))
     unique-staves)))
        

  



























#| NO LONGER NEEDED?
\noindent Example:
\begin{verbatim}
(setq
 rows
 '("*staff2	*staff1	*staff1/2"
   "*Ipiano	*Ipiano	*Ipiano"
   "*>A	*>A	*>A"
   "*clefF4	*clefG2	*clefG2"
   "*k[f#c#g#]	*k[f#c#g#]	*k[f#c#g#]"
   "*f#:	*f#:	*f#:"
   "*M3/4	*M3/4	*M3/4"
   "*MM132	*MM132	*MM132"
   "4r	([4f#^/	p"
   "=1	=1	=1"
   "4CC#/	12f#/L]	."
   ".	12g#/	."
   ".	12f#/J	."
   "4C#\\ 4G#\\ 4B\\	8e#/L	<"
   ".	8f#/	."
   "4C#\\ 4E#\\ 4B\\	8.g#/	."
   ".	16d/Jk	."
   "=2	=2	=2"
   "*	*^	*"
   "4FF#/	8c#/L)	4r	."
   ".	16r	.	."
   ".	(16f#/Jk	.	."
   "4F#\\ 4c#\\	4a/)	4r	."
   "4F#\\ 4c#\\	([4a^/	[4f#\\	."
   "=3	=3	=3	=3"
   "4EE/	12a/L]	4f#\\]	<"
   ".	12b/	.	."
   ".	12a/J	.	."
   "4E\\ 4B\\	8g#/L	4e\\	."
   ".	8a/	.	."
   "[4E\\	8.b/	[4d^\\	."
   ".	16f#/Jk	.	."))
(setq staves-variable '((1 1) (0 1) (-1/2 1)))
(kern-rows2col-no-parse rows 2 staves-variable)
--> (NIL NIL NIL NIL NIL NIL NIL NIL (("p")) NIL
     ((".")) ((".")) ((".")) (("<")) ((".")) (("."))
     ((".")) NIL (("*")) ((".")) ((".")) (("."))
     ((".")) ((".")) NIL (("<")) ((".")) (("."))
     ((".")) ((".")) ((".")) ((".")))

\end{verbatim}

\noindent This function focuses on events in kern
rows that occur in the ith spine, and returns only
those events as unparsed strings. It is useful for
including articulation, dynamics, or lyrics in a
point set representing notes. |#

(defun kern-rows2col-no-parse
       (rows i staves-variable &optional
        (indices
         (cons
          0
          (fibonacci-list
           (nth-list-of-lists 1 staves-variable))))
        (start-index (nth i indices))
        (end-index (nth (+ i 1) indices))
        (row (first rows))
        (parsed-row
         (if (and
              row
              (not (string= (subseq row 0 1) "!"))
              (not (string= (subseq row 0 1) "="))
              (if (string= (subseq row 0 1) "*")
               (recognised-spine-commandp row) T))
           (mapcar
            #'(lambda (x)
                (space-bar-separated-string2list x))
            (tab-separated-string2list row))))
        (result
         (if (<= end-index (length parsed-row)) 
           (subseq
             parsed-row start-index end-index))))
  (if (null row) ()
    (cons
     result
     (kern-rows2col-no-parse
      (rest rows) i
      (update-staves-variable staves-variable row)))))











#| Old version. |#
(defun texture-whole-point-set
       (point-set &optional
        #| Thresholds for declaring textures. |#
        (mono-thresh .95) (homo-thresh .9)
        (macc-thresh .9)
        #| Typical point set columns. |#
        (ontime-idx 0) (MNN-idx 1) ;(MPN-idx 2)
        (dur-idx 3) (staff-idx 4)
        (proj-vec
         (add-to-nth
           1 (+ ontime-idx 1) (constant-vector 0 5)))
        (proj-vec2
         (add-to-nth
          1 (+ ontime-idx 1)
          (add-to-nth
           1 (+ MNN-idx 1) (constant-vector 0 5))))
        #| Required to test homophony. |#
        (unq-on
         (orthogonal-projection-unique-equalp
          point-set proj-vec))
        (sky-on
         (orthogonal-projection-unique-equalp
          (sky-line-clipped
           point-set ontime-idx MNN-idx dur-idx)
          proj-vec))
        (homo-obs
         (if (not (null unq-on)) 
           (/
            (length
             (intersection-multidimensional
              unq-on sky-on)) (length unq-on))))
        #| Required to test monophony. |#
        (unq-on-MNN
         (orthogonal-projection-unique-equalp
          point-set proj-vec2))
        (sky-on-MNN
         (orthogonal-projection-unique-equalp
          (sky-line-clipped
           point-set ontime-idx MNN-idx dur-idx)
          proj-vec2))
        (mono-obs
         (if (not (null unq-on-MNN))
           (/
            (length
             (intersection-multidimensional
              unq-on-MNN sky-on-MNN))
            (length unq-on-MNN))))
        #| Required to test melody + accompaniment. |#
        (nos-voice
         (length
          (remove-duplicates
           (orthogonal-projection-unique-equalp
            point-set
            (add-to-nth
             1 (+ staff-idx 1) (constant-vector 0 5)))
           :test #'equalp)))
        (accomp-on-MNN
         (set-difference-multidimensional-sorted-asc
          unq-on-MNN sky-on-MNN))
        (sky2-on-MNN
         (top-line-verbose accomp-on-MNN))
        (accomp-on
         (orthogonal-projection-unique-equalp
          accomp-on-MNN proj-vec))
        (sky2-on
         (orthogonal-projection-unique-equalp
          sky2-on-MNN proj-vec))
        (macc-obs
         (if (not (null accomp-on))
           (/
            (length
             (intersection-multidimensional
              accomp-on sky2-on))
            (length accomp-on))))
        
        )
  (if (>= mono-obs mono-thresh)
    (list "monophonic" mono-obs)
    (if (>= homo-obs homo-thresh)
      (list "homophonic" homo-obs)
      (if (and
           (> nos-voice 2)
           (>= macc-obs macc-thresh))
        "melody with accompaniment"))))
        
         
(on
         (remove-duplicates on-all :test #'equalp))









; THIS BIT NEEDS WRITING INTO A FUNCTION.
        #| If the question mentions a particular
        staff, restrict attention to this staff |#
        (unique-staves
         (if melodic-idx
           (remove-duplicates
            (sort
             (nth-list-of-lists staff-idx point-set)
             #'<) :test #'equalp)))
        ; Get string to make removal effective.
        (staff-restriction-string
         (if melodic-idx
           (cond
            ((search "bass clef" question-string)
             "bass clef")
            ((search "bass" question-string)
             "bass")
            ((search "treble clef" question-string)
             "treble clef")
            ((search "treble" question-string)
             "treble")
            
            )))
        ; Define staff number (needs generalising).
        (staff-restriction
         (if staff-restriction-string
           (cond
            ((search "bass" staff-restriction-string)
             (my-last unique-staves))
            ((search
              "treble" staff-restriction-string)
             (first unique-staves))
            
            )))
        









(((0 0 0) NIL)
 ((0 0 1) NIL)
 ((0 0 2) NIL)
 ((0 1 0) ((1 0 1)))
 ((0 2 0) ((1 0 1)))
 ((0 2 1) ((1 2 2) (1 3 2)))
 ((1 0 0) NIL)
 ((1 0 1) ((2 3 0)))
 ((1 0 2) ((2 3 1)))
 ((1 2 0) ((2 3 1)))
 ((1 2 1) NIL)
 ((1 2 2) NIL)
 ((1 3 0) NIL)
 ((1 3 1) NIL)
 ((1 3 2) NIL))

(((0 0 0))
 ((0 0 1))
 ((0 0 2))
 ((0 1 0) (1 0 1) (2 3 0))
 ((0 2 0) (1 0 1) (2 3 0))
 ((0 2 1) (1 2 2))
 ((1 0 0))
 ((1 0 1) (2 3 0))
 ((1 0 2) (2 3 1))
 ((1 2 0) (2 3 1))
 ((1 2 1))
 ((1 2 2))
 ((1 3 0))
 ((1 3 1))
 ((1 3 2)))

(setq
 ans-list
 (list
  ans-harmonic-interval
  ans-melodic-interval
  ans-dur-pitch
  ans-pitch
  ans-dur))


((NIL ((17/4 35/8)))
 (NIL NIL)
 (NIL NIL)
 (((1/2 1) (15/4 17/4)) NIL)
 (NIL NIL))


(setq
 question-string
 (concatenate
  'string
  "F followed 2 bars later by a crotchet"))
(setq
 question-string
 (concatenate
  'string
  "F followed 2 bars later by a crotchet"))
(setq
 question-string
 (concatenate
  'string
  "F followed by a crotchet followed six eighth "
  "notes later by a perfect fifth"))
(setq
 question-string
 (concatenate
  'string
  "F followed two bars later by a crotchet followed "
  "six eighth notes later by a perfect fifth"))
(setq
 question-string
 "F# followed by a major sixth")
(setq
 questions
 (followed-by-splitter question-string))

(defun duration-time-intervals
       (question-string point-set &optional
        (ontime-index 0) (duration-index 3)
        ; Convert the duration into numeric format.
        (val
         (duration-string2numeric question-string))
        ; Append the offtimes.
        (point-set-off-app
         (if val
           (mapcar
            #'(lambda (x)
                (list
                 (nth ontime-index x)
                 (nth duration-index x)
                 (+
                  (nth ontime-index x)
                  (nth duration-index x))))
            point-set)))
        ; Get the points with the relevant duration.
        (relevant-points
         (if val
           (restrict-dataset-in-nth-to-xs
             ; Testing duration.
             point-set-off-app 1 (list val)))))
  (remove-duplicates
   (mapcar
    #'(lambda (x)
        (list (first x) (third x))) relevant-points)
   :test #'equalp))

(defun duration&pitch-class-time-intervals
       (question-string point-set staff&clef-names
        &optional
        (ontime-index 0) (MNN-index 1) (MPN-index 2)
        (duration-index 3) (staff-idx 4)
        (val
         (duration-string2numeric question-string))
        ; Edit out the duration of question string.
        (question-string
         (replace-all
          question-string "dotted " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "triplet " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "quintuplet " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "septuplet " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "hemidemisemiquaver " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "sixty-fourth note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "demisemiquaver " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "thirty-second note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "semiquaver " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "sixteenth note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "quaver " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "eighth note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "crotchet " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "quarter note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "minim " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "half note " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "semibreve " ""
          :test #'string=))
        (question-string
         (replace-all
          question-string "whole note " ""
          :test #'string=))
        ; Edit the pitch class of question string.
        (question-string
         (replace-all
          question-string " double flat" "bb"
          :test #'string=))
        (question-string
         (replace-all
          question-string " double sharp" "##"
          :test #'string=))
        (question-string
         (replace-all
          question-string " flat" "b"
          :test #'string=))
        (question-string
         (replace-all
          question-string " sharp" "#"
          :test #'string=))
        (question-string
         (replace-all
          question-string " natural" ""
          :test #'string=))
        ; modify question by any staff restriction.
        (question-string&staff-idx
         (modify-question-by-staff-restriction
          question-string staff&clef-names))
        (staff-restriction
         (second question-string&staff-idx))
        (question-string
         (if staff-restriction
           (first question-string&staff-idx)
           question-string))
        ; Restrict the point set too.
        (point-set
         (if staff-restriction
           (dataset-restricted-to-m-in-nth
            point-set staff-restriction
            staff-idx)
           point-set))
        (pair
	 (second
	  (assoc
	   question-string
	   '(("B#" (12 6)) ("C" (0 0)) ("Dbb" (0 1))
	     ("B##" (13 6)) ("C#" (1 0)) ("Db" (1 1))
	     ("C##" (2 0)) ("D" (2 1)) ("Ebb" (2 2))
	     ("D#" (3 1)) ("Eb" (3 2)) ("Fbb" (3 3))
             ("D##" (4 1)) ("E" (4 2)) ("Fb" (4 3))
	     ("E#" (5 2)) ("F" (5 3)) ("Gbb" (5 4))
             ("E##" (6 2)) ("F#" (6 3)) ("Gb" (6 4))
             ("F##" (7 3)) ("G" (7 4)) ("Abb" (7 5))
             ("G#" (8 4)) ("Ab" (8 5))
             ("G##" (9 4)) ("A" (9 5)) ("Bbb" (9 6))
             ("Cbb" (-2 0)) ("A#" (10 5))
             ("Bb" (10 6))
	     ("A##" (11 5)) ("B" (11 6))
	     ("Cb" (-1 0))) :test #'string=)))
        ; Set of ontime, mod MNN & MPN, dur, offtime.
        (point-set-mod-n
         (if pair
           (mapcar
            #'(lambda (x)
                (list
                 (nth ontime-index x)
                 (mod (nth MNN-index x) 12)
                 (mod (+ (nth MPN-index x) 3) 7)
                 (nth duration-index x)
                 (+
                  (nth ontime-index x)
                  (nth duration-index x))))
            point-set)))
        #| Get the points with the relevant duration
        and pitch. |#
        (relevant-points
         (if (and val pair)
           (restrict-dataset-in-nth-to-xs
            ; Testing MPN.
            (restrict-dataset-in-nth-to-xs
             ; Testing MNN.
             (restrict-dataset-in-nth-to-xs
              ; Testing duration.
              point-set-mod-n duration-index
              (list val))
             MNN-index (list (first pair)))
            MPN-index (list (second pair))))))
  (mapcar
   #'(lambda (x)
       (list (first x) (fifth x))) relevant-points))

(defun pitch-class-time-intervals
       (question-string point-set staff&clef-names
        &optional
        (ontime-index 0) (MNN-index 1) (MPN-index 2)
        (duration-index 3) (staff-idx 4)
        ; Edit the question string.
        (question-string
         (replace-all
          question-string " double flat" "bb"
          :test #'string=))
        (question-string
         (replace-all
          question-string " double sharp" "##"
          :test #'string=))
        (question-string
         (replace-all
          question-string " flat" "b"
          :test #'string=))
        (question-string
         (replace-all
          question-string " sharp" "#"
          :test #'string=))
        (question-string
         (replace-all
          question-string " natural" ""
          :test #'string=))
        ; modify question by any staff restriction.
        (question-string&staff-idx
         (modify-question-by-staff-restriction
          question-string staff&clef-names))
        (staff-restriction
         (second question-string&staff-idx))
        (question-string
         (if staff-restriction
           (first question-string&staff-idx)
           question-string))
        ; Restrict the point set too.
        (point-set
         (if staff-restriction
           (dataset-restricted-to-m-in-nth
            point-set staff-restriction
            staff-idx)
           point-set))
        (pair
	 (second
	  (assoc
	   question-string
	   '(("B#" (12 6)) ("C" (0 0)) ("Dbb" (0 1))
	     ("B##" (13 6)) ("C#" (1 0)) ("Db" (1 1))
	     ("C##" (2 0)) ("D" (2 1)) ("Ebb" (2 2))
	     ("D#" (3 1)) ("Eb" (3 2)) ("Fbb" (3 3))
             ("D##" (4 1)) ("E" (4 2)) ("Fb" (4 3))
	     ("E#" (5 2)) ("F" (5 3)) ("Gbb" (5 4))
             ("E##" (6 2)) ("F#" (6 3)) ("Gb" (6 4))
             ("F##" (7 3)) ("G" (7 4)) ("Abb" (7 5))
             ("G#" (8 4)) ("Ab" (8 5))
             ("G##" (9 4)) ("A" (9 5)) ("Bbb" (9 6))
             ("Cbb" (-2 0)) ("A#" (10 5))
             ("Bb" (10 6))
	     ("A##" (11 5)) ("B" (11 6))
	     ("Cb" (-1 0))) :test #'string=)))
        ; Set of ontime, mod MNN & MPN, offtime.
        (point-set-mod-n
         (if pair
           (mapcar
            #'(lambda (x)
                (list
                 (nth ontime-index x)
                 (mod (nth MNN-index x) 12)
                 (mod (+ (nth MPN-index x) 3) 7)
                 (+
                  (nth ontime-index x)
                  (nth duration-index x))))
            point-set)))
        ; Get the points with the relevant pitch.
        (relevant-points
         (if pair
           (restrict-dataset-in-nth-to-xs
            ; Testing MPN.
            (restrict-dataset-in-nth-to-xs
             ; Testing MNN.
             point-set-mod-n MNN-index
             (list (first pair)))
            MPN-index (list (second pair))))))
  (mapcar
   #'(lambda (x)
       (list (first x) (fourth x))) relevant-points))
           
(defun pitch-class-time-intervals
       (question-string point-set &optional
        (ontime-index 0) (MNN-index 1) (MPN-index 2)
        (duration-index 3)
        ; Edit the question string.
        (question-string
         (replace-all
          question-string " double flat" "bb"
          :test #'string=))
        (question-string
         (replace-all
          question-string " double sharp" "##"
          :test #'string=))
        (question-string
         (replace-all
          question-string " flat" "b"
          :test #'string=))
        (question-string
         (replace-all
          question-string " sharp" "#"
          :test #'string=))
        (question-string
         (replace-all
          question-string " natural" ""
          :test #'string=))
        (pair
	 (second
	  (assoc
	   question-string
	   '(("B#" (12 6)) ("C" (0 0)) ("Dbb" (0 1))
	     ("B##" (13 6)) ("C#" (1 0)) ("Db" (1 1))
	     ("C##" (2 0)) ("D" (2 1)) ("Ebb" (2 2))
	     ("D#" (3 1)) ("Eb" (3 2)) ("Fbb" (3 3))
             ("D##" (4 1)) ("E" (4 2)) ("Fb" (4 3))
	     ("E#" (5 2)) ("F" (5 3)) ("Gbb" (5 4))
             ("E##" (6 2)) ("F#" (6 3)) ("Gb" (6 4))
             ("F##" (7 3)) ("G" (7 4)) ("Abb" (7 5))
             ("G#" (8 4)) ("Ab" (8 5))
             ("G##" (9 4)) ("A" (9 5)) ("Bbb" (9 6))
             ("Cbb" (-2 0)) ("A#" (10 5))
             ("Bb" (10 6))
	     ("A##" (11 5)) ("B" (11 6))
	     ("Cb" (-1 0))) :test #'string=)))
        ; Set of ontime, mod MNN & MPN, offtime.
        (point-set-mod-n
         (if pair
           (mapcar
            #'(lambda (x)
                (list
                 (nth ontime-index x)
                 (mod (nth MNN-index x) 12)
                 (mod (+ (nth MPN-index x) 3) 7)
                 (+
                  (nth ontime-index x)
                  (nth duration-index x))))
            point-set)))
        ; Get the points with the relevant pitch.
        (relevant-points
         (if pair
           (restrict-dataset-in-nth-to-xs
            ; Testing MPN.
            (restrict-dataset-in-nth-to-xs
             ; Testing MNN.
             point-set-mod-n MNN-index
             (list (first pair)))
            MPN-index (list (second pair))))))
  (mapcar
   #'(lambda (x)
       (list (first x) (fourth x))) relevant-points))


(defun melodic-interval-of-a
       (question-string point-set &optional
        (staff&clef-names
         '(("piano" "bass clef")
           ("piano" "treble clef")))
        (melodic-idx
         (search "melodic" question-string))
        ; Strip out "melodic".
        (question-string
         (if melodic-idx
           (replace-all
            (replace-all
             question-string
             "melodic interval of a " ""
             :test #'string=)
            "melodic " "" :test #'string=)))
        #| Identify restrictions to any particular
        staves or voices, identify the numerical
        index of the relevant staff and edit the
        question string appropriately. |#
        (question-string&staff-idx
         (modify-question-by-staff-restriction
          question-string staff&clef-names))
        (staff-restriction
         (second question-string&staff-idx))
        (question-string
         (if staff-restriction
           (first question-string&staff-idx)
           question-string))
        #| Convert string interval to numeric. |#
        (vector
         (interval-string2MNN-MPN-mod
          question-string))
        #| Standard variables. |#
        (ontime-idx 0) (MNN-idx 1) (MPN-idx 2)
        (staff-idx 4) ;(duration-idx 3)
        (point-sets
         (if (not (null vector))
           (if staff-restriction
             (list
              (dataset-restricted-to-m-in-nth
               point-set staff-restriction
               staff-idx))
             (split-point-set-by-staff
              point-set staff-idx))))
        (unique-ontimes
         (if (not (null vector))
           (mapcar
            #'(lambda (x)
                (remove-duplicates
                 (sort
                  (nth-list-of-lists
                   ontime-idx x) #'<) :test #'equalp))
            point-sets)))
        (list-of-pairs
         (if point-sets
           (append-list
            (mapcar
             #'(lambda (x y)
                 (pairs-forming-melodic-interval-of
                  x vector ontime-idx MNN-idx MPN-idx
                  y))
             point-sets unique-ontimes)))))
  (mapcar
   #'(lambda (x)
       (list
        (nth ontime-idx (first x))
        (nth ontime-idx (second x))))
   list-of-pairs))


(defun pairs-forming-melodic-interval-of
       (point-set MNN-MPN-mod &optional
        (ontime-idx 0) (MNN-idx 1) (MPN-idx 2)
        (unique-ontimes
         (remove-duplicates
          (sort
           (nth-list-of-lists
            ontime-idx point-set) #'<)
          :test #'equalp))
        (pairs nil)
        (point (first point-set))
        (unique-ontime-idx
         (if point
           (index-1st-sublist-item>
            (nth ontime-idx point) unique-ontimes)))
        (unique-ontime
         (if unique-ontime-idx
           (nth unique-ontime-idx unique-ontimes)))
        (candidate-points
         (if unique-ontime
           (restrict-dataset-in-nth-to-xs
            point-set ontime-idx
            (list unique-ontime))))
        (relevant-points
         (if unique-ontime
           (loop for i from 0 to
             (- (length candidate-points) 1) append
             (if (equalp
                  (mapcar
                   #'(lambda (x) (abs x))
                   (subtract-two-lists
                    (nth-list
                     (list MNN-idx MPN-idx)
                     (nth i candidate-points))
                    (nth-list
                     (list MNN-idx MPN-idx) point)))
                  MNN-MPN-mod)
               (list (nth i candidate-points)))))))
  (if (null point-set) (identity pairs)
    (pairs-forming-melodic-interval-of
     (rest point-set) MNN-MPN-mod ontime-idx MNN-idx
     MPN-idx unique-ontimes
     (if relevant-points
       (append
        pairs
        (mapcar
         #'(lambda (x)
             (list point x)) relevant-points))
       (identity pairs)))))



(defun c@merata2014-write-answer
       (question-string division time-intervals
        ontimes-signatures question-number
        notation-path notation-name
        &optional
        (start-bar&beats ; x.
         (mapcar
          #'(lambda (x)
              (bar&beat-number-of-ontime
               (first x) ontimes-signatures))
          time-intervals))
        (start-time-sigs ; y.
         (mapcar
          #'(lambda (x)
              (row-of-max-ontime<=ontime-arg
               (first x) ontimes-signatures))
          time-intervals))
        (end-bar&beats ; z.
         (mapcar
          #'(lambda (x)
              (bar&beat-number-of-ontime
               (- (second x) (/ 1 division))
               ontimes-signatures))
          time-intervals))
        (end-time-sigs ; w.
         (mapcar
          #'(lambda (x)
              (row-of-max-ontime<=ontime-arg
               (first x) ontimes-signatures))
          time-intervals))
        (answer-lists
         (mapcar
          #'(lambda (x y z w)
              (list
               ; start_beats.
               (second y)
               ; start_beat_type.
               (third y)
               ; end_beats.
               (second w)
               ; end_beat_type.
               (third w)
               ; start_divisions.
               division
               ; end_divisions.
               division
               ; start_bar.
               (first x)
               ; start_offset.
               (+ (* (- (second x) 1) division) 1)
               ; end_bar.
               (first z)
               ; end_offset.
               (+ (* (- (second z) 1) division) 1)))
          start-bar&beats start-time-sigs
          end-bar&beats end-time-sigs))
        (answer-path&name
         (merge-pathnames
          (make-pathname
           :name "dmun01" :type "txt")
          notation-path))
        (file
         (open
          answer-path&name
          :direction :output :if-does-not-exist
          :create :if-exists :append)))
  (progn
    (format
     file "  <question number=~s" question-number)
    (format
     file
     " music_file=~s"
     (concatenate 'string notation-name ".xml"))
    (format file " divisions=\"~s\">~%" division)
    (format
     file "    <text>~a</text>~%" question-string)
    (loop for i from 0 to
      (- (length time-intervals) 1) do
      (format file "    <answer>~%")
      (format file "      <passage ")
      (format
       file "start_beats=\"~s\""
       (nth 0 (nth i answer-lists)))
      (format
       file " start_beat_type=\"~s\"~%"
       (nth 1 (nth i answer-lists)))
      (format
       file "               end_beats=\"~s\""
       (nth 2 (nth i answer-lists)))
      (format
       file " end_beat_type=\"~s\"~%"
       (nth 3 (nth i answer-lists)))
      (format
       file "               start_divisions=\"~s\""
       (nth 4 (nth i answer-lists)))
      (format
       file " end_divisions=\"~s\"~%"
       (nth 5 (nth i answer-lists)))
      (format
       file "               start_bar=\"~s\""
       (nth 6 (nth i answer-lists)))
      (format
       file " start_offset=\"~s\"~%"
       (nth 7 (nth i answer-lists)))
      (format
       file "               end_bar=\"~s\""
       (nth 8 (nth i answer-lists)))
      (format
       file " end_offset=\"~s\" />~%"
       (nth 9 (nth i answer-lists)))
      (format file "    </answer>~%"))
    (format file "  </question>~%~%")
    (close file)))








