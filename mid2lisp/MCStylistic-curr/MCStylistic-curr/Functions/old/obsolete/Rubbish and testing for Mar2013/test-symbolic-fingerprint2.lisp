

(setq a-list '(2 4 -1 6 9 12 0 -7 5 3 1 2 3 4 3 1 -5))
(setq edges '(-7.5 -3.5 0.5 4.5 8.5 12.5))
(histogram a-list edges)
--> (1 2 9 3 2)



(defun histogram
       (a-list edges &optional
        (bins
         (constant-vector 0 (- (length edges) 1)))
        (curr-bin
         (if a-list
           (index-1st-sublist-item>=
            (first a-list) edges))))
  (if (null a-list) bins
    (histogram
     (rest a-list) edges
     (if (and curr-bin (> curr-bin 0))
       (add-to-nth 1 curr-bin bins) bins))))










(setq
 A (symbolic-fingerprint (subseq dataset 0) ID))
(length A)

(write-to-file
A "/Users/tomthecollins/Desktop/test.txt")

(setq n1 5)
(setq n2 5)
(setq d .05)
(setq trans-invar nil)
(setq ontime-idx 0)
(setq MNN-idx 1)
(setq nD (length dataset))
(setq i 0) ; Iterate over D.
(setq i1 1) ; Iterate over the pair.
(setq j1 0) ; Used if next MIDI event is too close.
(setq i2 1) ; Iterate over the triple.
(setq j2 0) ; Used if next MIDI event is too close.
(setq idx
 (list
  i (+ i i1 j1) (+ i i1 j1 i2 j2)))
(setq token
 (if (and
      (< i nD) (< (+ i i1 j1) nD) (<= i1 n1)
      (>=
       (-
        (nth
         ontime-idx (nth (+ i i1 j1) dataset))
        (nth ontime-idx (nth i dataset))) d)
      (< (+ i i1 j1 i2 j2) nD) (<= i2 n2)
      (>=
       (-
        (nth
         ontime-idx
         (nth (+ i i1 j1 i2 j2) dataset))
        (nth
         ontime-idx
         (nth (+ i i1 j1) dataset))) d))
   (list
    (append
     (if trans-invar
       (list
        (-
         (nth
          MNN-idx (nth (second idx) dataset))
         (nth
          MNN-idx (nth (first idx) dataset)))
        (-
         (nth
          MNN-idx (nth (third idx) dataset))
         (nth
          MNN-idx
          (nth (second idx) dataset))))
       (nth-list
        idx
        (nth-list-of-lists MNN-idx dataset)))
     (list
      (/
       (-
        (nth
         ontime-idx (nth (third idx) dataset))
        (nth
         ontime-idx
         (nth (second idx) dataset)))
       (-
        (nth
         ontime-idx
         (nth (second idx) dataset))
        (nth
         ontime-idx
         (nth (first idx) dataset))))))
    (list
     ID
     (nth
      ontime-idx (nth (first idx) dataset))
     (-
      (nth
       ontime-idx (nth (second idx) dataset))
      (nth
       ontime-idx
       (nth (first idx) dataset)))))))

(setq i2 (+ i2 1))

(setq i1 (+ i1 1))

