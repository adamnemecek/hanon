#| Tom Collins
   Wednesday 14 January 2009
   Completed Tuesday 6 January 2009 |#

#| Example:
(abs-list '(48 -50 -51 58))
gives
'(48 50 51 58).

This function returns the absolute values of items in
a list. |#

(defun abs-list (a-list)
  (if (null a-list) ()
    (cons (abs (first a-list))
          (abs-list (rest a-list)))))

#| Example:
(closest-item-in-list 52 '(48 50 51 58))
gives
2.

This function compares the item argument with the list
argument, returning the index of the item of the list
which is closest to the item argument. Assumes
utilities and choose have been loaded as buffer. |#

(defun closest-item-in-list (item a-list)
  (second
   (min-argmin
    (abs-list (add-to-list (- item) a-list)))))

#| Example:
(closest-list-v-list '(48 52 57 58) '(48 50 51 58 60))
gives
'(0 2 3 3).

This function compares each item of the first list
with the second list argument, returning the index of
the item (counting from zero) of the list which is
closest to the item argument. The lists may be of
different lengths. Assumes utilities and choose have
been loaded as buffer. |#

(defun closest-list-v-list (a-list b-list)
  (if (null a-list) ()
    (cons (closest-item-in-list (first a-list) b-list)
          (closest-list-v-list (rest a-list)
                               b-list))))

#| Example:
(index-items-equalp-to "tied-forward" 1
                       '((48 "tied-both")
                         (50 "untied")
                         (60 "tied-forward")
                         (64 "tied-forward")))
gives
'(2 3).

This function takes three arguments: a probe; a lookup
index n; and a list. It looks for the probe in the nth
item of list (of a list of lists), returning the index
when it is found. |#

(defun index-items-equalp-to (probe n a-list
                              &optional (i 0))
  (if (null a-list) ()
    (if (equalp probe (nth n (first a-list)))
      (cons i (index-items-equalp-to
               probe n (rest a-list) (+ i 1)))
      (index-items-equalp-to
               probe n (rest a-list) (+ i 1)))))

#| Example:
(index-ties-between '((48 "tied-both")
                      (50 "untied")
                      (59 "untied")
                      (60 "tied-forward")
                      (64 "tied-forward"))
                    '((48 "untied")
                      (48 "tied-back")
                      (60 "tied-both")
                      (64 "tied-back")
                      (72 "untied")))
gives
'((0 3 4) (1 2 3)).

This function picks out the relevant ties between two
adjacent chords. The definitions of tie types and
increasing order of the list arguments mean that a
list consisting of two lists is returned, which can be
paired-off, to show what is tied to what. Assumes
utilities is loaded as buffer. |#

(defun index-ties-between (a-list b-list)
  (append
   (list
    (sort
     (union
      (index-items-equalp-to "tied-forward" 1 a-list)
      (index-items-equalp-to "tied-both" 1 a-list))
     #'<))
    (list
     (sort
      (union
       (index-items-equalp-to "tied-back" 1 b-list)
       (index-items-equalp-to "tied-both" 1 b-list))
      #'<))))