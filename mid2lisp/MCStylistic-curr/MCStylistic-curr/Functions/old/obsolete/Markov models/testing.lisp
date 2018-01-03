
(progn
  (setq
   C-67-1
   (read-from-file
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Datasets"
     "/C-67-1-ed.txt")))
  (setq
   C-68-3
   (read-from-file
    (concatenate
     'string
     "/Users/tomcollins/Open/Music/Datasets"
     "/C-68-3-ed.txt")))
  "Yes!")

(progn
  (setq C-67-1-mini (subseq C-67-1 0 50))
  (setq C-68-3-mini (subseq C-68-3 0 50))
  "Yes!")

(progn
  (setq
   C-67-1-mini-offs&enums
   (enumerate-append
    (append-offtimes C-67-1-mini 3)))
  (setq
   C-68-3-mini-offs&enums
   (enumerate-append
    (append-offtimes C-68-3-mini 3)))
  "Yes!")

; testing spacing-holding-states
(setq datapoints C-68-3-mini)
(setq catalogue-information "C-68-3-mini")
(setq duration-index 3)
(setq
 datapoints-with-offs&enums
 (enumerate-append
  (append-offtimes datapoints duration-index)))
(setq
 unique-times
 (remove-duplicates
  (sort
   (append
    (nth-list-of-lists
     0 datapoints-with-offs&enums)
    (nth-list-of-lists
     5 datapoints-with-offs&enums)) #'<)
  :test #'equalp))
(setq
 segmented
 (segments
  datapoints duration-index datapoints-with-offs&enums
  unique-times))
(setq sorted-holdings-list
	 (sort-holding-types
	  (holding-types
	   (segments
	    datapoints duration-index
	    datapoints-with-offs&enums
	    unique-times))))
(setq indexed-rests
      (index-rests sorted-holdings-list))
(setq unique-times
      (remove-nth-list indexed-rests unique-times))
(setq sorted-holdings-list
      (remove-nth-list
       indexed-rests sorted-holdings-list))
(setq bass-steps-list
 (cons
  NIL (bass-steps sorted-holdings-list)))
(setq sorted-holdings
	 (first sorted-holdings-list))
(spacing-holding-states datapoints "C-68-3-mini" 3)

; testing holding-type-normal
(holding-type-normal
 (nth 0 segmented) (nth 1 segmented)
 (nth 2 segmented))

(setq previous-segment (nth 0 segmented))
(setq current-segment (nth 1 segmented))
(setq next-segment (nth 2 segmented))
(setq previous-list
	 (nth-list-of-lists
	  6 (second previous-segment)))
(setq current-list
	 (nth-list-of-lists
	  6 (second current-segment)))
(setq next-list
	 (nth-list-of-lists 6 (second next-segment)))
(setq n (length current-list))
(setq j 0)
(setq i (nth j current-list))
(setq j (+ j 1))


; creating chord-candidates-offtimes-strict
(prepare-for-segments datapoints-with-offs&enums)
; testing
(setq
 a-list
 '((3 48 53 3 1 6 0) (3 55 57 3/4 1 15/4 1)
   (3 60 60 3/4 1 15/4 2) (3 67 64 3/4 0 15/4 3)
   (3 76 69 3/4 0 15/4 4) (15/4 59 59 1/4 1 4 5)
   (15/4 65 63 1/4 0 4 6) (15/4 74 68 1/4 0 4 7) 
   (4 60 60 2 1 6 8) (4 64 62 2 0 6 9)
   (4 72 67 2 0 6 10)))
(setq l (length a-list))
(setq x 15/4)
(setq s 0)

(setq datapoint (nth s a-list))

; testing in context of segment
(setq ontime 15/4)
(setq
 datapoints-with-offs&enums
 a-list)
(setq N 11)
(setq
 prepared-for-segments
 (prepare-for-segments datapoints-with-offs&enums))
(setq previous-ontimes ())
(setq previous-offtimes
	 (add-to-list
	  -1 (reverse (first-n-naturals N))))
(setq candidate-ontimes
	  (chord-candidates-ontimes
	   (first prepared-for-segments)
	   N ontime (length previous-ontimes)))
(setq candidate-offtimes
	  (chord-candidates-offtimes-strict
	   (second prepared-for-segments)
	   N ontime (- N (length previous-offtimes))))
(setq new-ontimes 
      (append previous-ontimes candidate-ontimes))
(setq new-offtimes
	  (set-difference
	   previous-offtimes candidate-offtimes))

(intersection new-ontimes new-offtimes)
(segment
 0 datapoints-with-offs&enums 11
 prepared-for-segments)


; testing segments
(setq
 datapoints
 '((3 48 53 3 1) (3 55 57 3/4 1) (3 60 60 3/4 1)
   (3 67 64 3/4 0) (3 76 69 3/4 0) (15/4 59 59 1/4 1)
   (15/4 65 63 1/4 0) (15/4 74 68 1/4 0) (4 60 60 2 1)
   (4 64 62 2 0) (4 72 67 2 0)))
(segments datapoints 3)

((3 48 53 3 1 6 0) (3 67 64 3/4 0 15/4 1)
 (3 76 69 3/4 0 15/4 2) (15/4 65 63 1/4 0 4 3)
 (15/4 74 68 1/4 0 4 4) (4 64 62 2 0 6 5)
 (4 72 67 2 0 6 6) (13/2 61 60 1/2 0 7 7)
 (7 62 61 1/2 0 15/2 8) (15/2 64 62 1/2 0 8 9)
 (8 50 54 1 1 9 10) (8 65 63 1 0 9 11))

; testing beat-spacing-states
(setq
 datapoints
 '((3 48 53 3 1) (3 67 64 3/4 0) (3 76 69 3/4 0)
   (15/4 65 63 1/4 0) (15/4 74 68 1/4 0) (4 64 62 2 0)
   (4 72 67 2 0) (13/2 61 60 1/2 0) (7 62 61 1/2 0)
   (15/2 64 62 1/2 0) (8 50 54 1 1) (8 65 63 1 0)))
(setq beats-in-bar 3)
(setq catalogue-information "C-68-3-mini")
(setq sort-index 1)
(setq duration-index 3)
(setq datapoints-with-offs&enums
	 (enumerate-append
	  (append-offtimes
	   datapoints duration-index)))
(setq unique-times
	 (remove-duplicates
	  (sort
	   (append
	    (nth-list-of-lists
	     0 datapoints-with-offs&enums)
	    (nth-list-of-lists
	     5 datapoints-with-offs&enums)) #'<)
	  :test #'equalp))
(setq segmented
	 (segments-strict
	  datapoints sort-index duration-index
	  datapoints-with-offs&enums unique-times))
(setq bass-steps-list
	 (cons
	  NIL (bass-steps-with-rests segmented)))
(setq first-segmented (first segmented))

(((1 (19 9))
  (NIL "C-68-3-mini"
   ((3 48 53 3 1 6 0) (3 67 64 3/4 0 15/4 1)
    (3 76 69 3/4 0 15/4 2))))
 ((7/4 (17 9))
  (0 "C-68-3-mini"
   ((3 48 53 3 1 6 0) (15/4 65 63 1/4 0 4 3)
    (15/4 74 68 1/4 0 4 4))))
 ((2 (16 8))
  (0 "C-68-3-mini"
     ((3 48 53 3 1 6 0) (4 64 62 2 0 6 5)
      (4 72 67 2 0 6 6))))
 ((1 "rest")
  (NIL "C-68-3-mini" NIL))
 ((3/2 NIL)
  (13 "C-68-3-mini" ((13/2 61 60 1/2 0 7 7))))
 ((2 NIL)
  (1 "C-68-3-mini" ((7 62 61 1/2 0 15/2 8))))
 ((5/2 NIL)
  (2 "C-68-3-mini" ((15/2 64 62 1/2 0 8 9))))
 ((3 (15))
  (-14 "C-68-3-mini"
       ((8 50 54 1 1 9 10) (8 65 63 1 0 9 11)))))







