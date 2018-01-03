#| Copyright Tom Collins Sunday 24 January 2016

This script:
1. Selects a Bach chorale harmonisation to be used as a
pattern template. It discovers and outputs repeated
patterns in the harmonisation, so that abstract
information about the repetitions can be incorporated
in the generated passage;
2. Forms a Markov model over the remaining Bach chorale
harmonisations, saving the results;
3. Loads the initial and final distributions,
transition matrices, and a template piece of music. It
generates an excerpt based on this information and
writes it to file. |#

#| Set paths. |#
(progn
  (setq *on-linux* nil)
  (setq date-ver "20160125")
  (setq stim-name "stim-2")
  (setq template-name "bachChoraleBWV350R360")
  #| 3-4 or changing time-sig chorales that should not
  be included in the model. |#
  (setq
   rogues
   '("bachChoraleBWV17p7R7" "bachChoraleBWV304R280"))
  (setq
   orig-data-dir
   (if *on-linux*
     (make-pathname
      :directory
      '(:absolute
        "home" "tcolli07" "Dropbox" "collDataInit"
        "private" "core" "data" "music" "bachChorales"))
     (make-pathname
      :directory
      '(:absolute
        "Users" "tomthecollins" "Dropbox" "collDataInit"
        "private" "core" "data" "music"
        "bachChorales"))))
  (setq
   rel-rep-dir
   (if *on-linux*
     (make-pathname
      :directory
      (list
       :absolute "home" "tcolli07" "JournalPapers"
       "ComputerMusicJournal" "2014b" date-ver
       stim-name "relRep"))
     (make-pathname
      :directory
      (list
       :absolute
       "Users" "tomthecollins" "Shizz" "JKU"
       "JournalPapers" "ComputerMusicJournal" "2014b"
       date-ver stim-name "relRep"))))
  (setq
   model-dir
   (if *on-linux*
     (make-pathname
      :directory
      (list
       :absolute "home" "tcolli07" "JournalPapers"
       "ComputerMusicJournal" "2014b" date-ver
       stim-name "model"))
     (make-pathname
      :directory
      (list
       :absolute "Users" "tomthecollins" "Shizz" "JKU"
       "JournalPapers" "ComputerMusicJournal" "2014b"
       date-ver stim-name "model"))))
  (setq
   output-dir
   (if *on-linux*
     (make-pathname
      :directory
      (list
       :absolute
       "home" "tcolli07" "JournalPapers"
       "ComputerMusicJournal" "2014b" date-ver
       stim-name "output"))
     (make-pathname
      :directory
      (list
       :absolute
       "Users" "tomthecollins" "Shizz" "JKU"
       "JournalPapers" "ComputerMusicJournal" "2014b"
       date-ver stim-name "output"))))
  "Paths set.")

#| 1. Discover and output repeated patterns in the
template piece. |#
(progn
  (setq beats-in-bar 4)
  (setq compact-thresh 99/100)
  (setq cardina-thresh 3)
  (setq region-type "lexicographic")
  (setq duration-thresh beats-in-bar)
  "Parameters defined.")
(progn
  (setq
   point-set-template
   (read-from-file
    (merge-pathnames
     (make-pathname
      :directory
      (list :relative template-name "polyphonic" "lisp")
      :name template-name :type "txt")
     orig-data-dir)))
  (setq
   point-set-projected
   (orthogonal-projection-unique-equalp
    point-set-template '(1 1 1 0 0)))
  (setq time-a (get-internal-real-time))
  (SIA-reflected-merge-sort
   point-set-projected
   (merge-pathnames
    (make-pathname
     :name
     (concatenate
      'string
      template-name " (1 1 1 0 0) SIA") :type "txt")
    model-dir))
  (setq
   SIA-out
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name
      (concatenate
       'string
       template-name " (1 1 1 0 0) SIA") :type "txt")
     model-dir)))
  (compactness-trawler
   SIA-out point-set-projected
   (merge-pathnames
    (make-pathname
     :name
     (concatenate
      'string
      template-name " (1 1 1 0 0) CT") :type "txt")
    model-dir)
   compact-thresh cardina-thresh region-type)
  (setq
   SIACT-out
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name
      (concatenate
       'string
       template-name " (1 1 1 0 0) CT") :type "txt")
     model-dir)))
  (setq
   patterns-hash
   (prepare-for-pattern-inheritance
    SIACT-out point-set-projected duration-thresh))
  (write-to-file-balanced-hash-table
   patterns-hash
   (merge-pathnames
    (make-pathname
     :name
     (concatenate
      'string
      template-name " (1 1 1 0 0) PH") :type "txt")
    model-dir))
  (setq time-b (get-internal-real-time))
  (float
   (/
    (- time-b time-a) internal-time-units-per-second)))

#| 2. Form a Markov model over the remaining Bach
chorale harmonisations, and save the results. Begin by
turning each piece into beat-rel-MNN states and saving
these representations. This loop is also a chance to
capture the piece names and the point sets in two
variables: *catalogue* and *variable-names*. |#
(progn
  (setq *catalogue* nil)
  (setq *variable-names* nil)
  (setq
   piece-names (list-directory orig-data-dir))
  (loop for i from 1 to (- (length piece-names) 1) do
    (setq
     curr-label
     (my-last
      (pathname-directory (nth i piece-names))))
    (if (and
         (search "bachChorale" curr-label)
         (not (search "bachChorales" curr-label))
         (not (equalp template-name curr-label))
         (not
          (index-item-1st-occurs curr-label rogues)))
      (progn
        (setq
         curr-song
         (sort-dataset-asc
          ; This call removes chord symbols.
          (restrict-dataset-in-nth-to-tests
           (read-from-file
            (merge-pathnames
             (make-pathname
              :name curr-label :type "txt"
              :directory
              '(:relative "polyphonic" "lisp"))
             (nth i piece-names)))
           4 (list #'<=) (list 3))))
        (setq
         *catalogue*
         (append *catalogue* (list curr-label)))
        ; (set (intern curr-label) curr-song)
        (setq
         *variable-names*
         (append
          *variable-names*
          (list
           (intern curr-label))))
        (setq
         curr-beat-rel-MNN-states
         (beat-rel-MNN-states
          curr-song curr-label beats-in-bar))
        (set
         (intern curr-label)
         curr-beat-rel-MNN-states)
        (write-to-file
         curr-beat-rel-MNN-states
         (merge-pathnames
          (make-pathname :name curr-label :type "txt")
          rel-rep-dir)))))
  "Converted to beat-rel-MNN representation.")

; Get the kern files also for internal state formation.
(progn
  (setq
   kern-path&names
   (loop for i from 0 to (- (length *catalogue*) 1)
     collect
     (merge-pathnames
      (make-pathname
       :directory
       (list
        :relative (nth i *catalogue*) "polyphonic"
        "kern")
       :name (nth i *catalogue*) :type "krn")
      orig-data-dir)))
  "Kern paths fetched.")
; Form the external distributions.
(progn
  (setq state-fn "beat-rel-MNN-states")
  (setq depth-check 20)
  (setq too-close 1)
  (setq duration-index 3)
  (setq MNN-index 1)
  (setq
   initial-states
   (construct-initial-states
    *variable-names* *catalogue* state-fn depth-check
    duration-index beats-in-bar MNN-index))
  (write-to-file
   initial-states
   (merge-pathnames
    (make-pathname
     :name "initial-states" :type "txt") model-dir))
  (setq
   final-states
   (construct-final-states
    *variable-names* *catalogue* state-fn depth-check
    duration-index beats-in-bar MNN-index))
  (write-to-file
   final-states
   (merge-pathnames
    (make-pathname
     :name "final-states" :type "txt") model-dir))
  "External state-context pairs exported.")
; Form the internal distributions.
(progn
  (setq
   internal-initial-states
   (construct-internal-states
    kern-path&names *catalogue* "notation"
    "fermata beginning"
    too-close state-fn beats-in-bar))
  (write-to-file
   internal-initial-states
   (merge-pathnames
    (make-pathname
     :name "internal-initial-states" :type "txt")
    model-dir))
  (setq
   internal-final-states
   (construct-internal-states
    kern-path&names *catalogue* "notation"
    "fermata ending"
    too-close state-fn beats-in-bar))
  (write-to-file
   internal-final-states
   (merge-pathnames
    (make-pathname
     :name "internal-final-states" :type "txt")
    model-dir))
  "Internal state-context pairs exported.")
; Form the transition matrices.
(progn
  (setq *transition-matrix* nil)
  (construct-stm
   *variable-names* *catalogue* state-fn
   duration-index beats-in-bar MNN-index)
  (write-to-file
   *transition-matrix*
   (merge-pathnames
    (make-pathname
     :name "transition-matrix" :type "txt") model-dir))
  (setq *transition-matrix* nil)
  (construct-stm<-
   *variable-names* *catalogue* state-fn
   duration-index beats-in-bar MNN-index)
  (write-to-file
   *transition-matrix*
   (merge-pathnames
    (make-pathname
     :name "transition-matrix<-" :type "txt")
    model-dir))
  "Transition lists exported.")

#| Step 3. Load the initial and final distributions,
transition matrices, and the template piece. Generate
an excerpt based on this information and write it to
file. Begin by defining parameter values for
Racchmaninof-Jun2015. Apart from the paths above, we
define everything we need here. |#
(progn
  (setq beats-in-bar 4)
  (setq checklist '("originalp"))
  (setq c-failures 10)
  (setq c-sources 4)
  (setq c-forwards 3)
  (setq c-backwards 3)
  "Racchmaninof-Jun2015 parameters defined.")

#| Import lists of initial/final state-context pairs,
and transition lists. |#
(progn
  (setq
   external-initial-states
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "initial-states" :type "txt")
     model-dir)))
  (setq
   internal-initial-states
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "internal-initial-states" :type "txt")
     model-dir)))
  (setq
   stm->
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "transition-matrix" :type "txt")
     model-dir)))
  (setq
   external-final-states
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "final-states" :type "txt")
     model-dir)))
  (setq
   internal-final-states
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "internal-final-states" :type "txt")
     model-dir)))
  (setq
   stm<-
   (read-from-file
    (merge-pathnames
     (make-pathname
      :name "transition-matrix<-" :type "txt")
     model-dir)))
  (concatenate
   'string
   "Initial state/context pairs and transition lists"
   " imported."))
#| Re-import the template piece. |#
(progn
  (setq
   point-set-template
   (read-from-file
    (merge-pathnames
     (make-pathname
      :directory
      (list
       :relative template-name "polyphonic" "lisp")
      :name template-name :type "txt")
    orig-data-dir)))
  (setq
   whole-piece-interval
   (list
    (first (first point-set-template))
    (first (my-last point-set-template))))
  (setq
   template-fsm
   (fifth-steps-mode point-set-template))
  (setq
   trans-pair&c-dataset
   (centre-dataset template-fsm point-set-template))
  (setq template-tpc (first trans-pair&c-dataset))
  (setq
   patterns-hash
   (read-from-file-balanced-hash-table
    (merge-pathnames
     (make-pathname
      :name
      (concatenate
       'string
       template-name " (1 1 1 0 0) PH") :type "txt")
    model-dir)))
  (setq scale 1500)
  "Template imported.")

#| Step 6 - Generate! |#
(setq
 *rs-all*
 (list
  #.(CCL::INITIALIZE-MRG31K3P-STATE 1332519877 1573787520 1344322644 474816276 713180371 556878283)
  ; #.(CCL::INITIALIZE-MRG31K3P-STATE 964068515 1226305670 1511339394 1906187749 693196299 1828148288)
  ; #.(CCL::INITIALIZE-MRG31K3P-STATE 2043124459 1961346678 605157413 811303198 1389548967 562963599)
  ; #.(CCL::INITIALIZE-MRG31K3P-STATE 1579190445 2128790004 2105786110 1852250945 628991276 558360749)
  
  ))
(setq
 *rs-tr*
 (list
  #.(CCL::INITIALIZE-MRG31K3P-STATE 259005423 369718092 1991191559 859743315 1257328585 1957545994)
  ))

(loop for i from 0 to (- (length *rs-all*) 1) do
  (progn
    (format
     t "Running i = ~d of ~d.~%" (+ i 1)
     (- (length *rs-all*) 1))
    (setq *rs* (nth i *rs-all*))
    #| Patterns hash needs resetting each time,
    otherwise inheritance always addressed for i > 1.|#
    (setq
     patterns-hash
     (read-from-file-balanced-hash-table
      (merge-pathnames
       (make-pathname
        :name
        (concatenate
         'string
         template-name " (1 1 1 0 0) PH") :type "txt")
       model-dir)))
    (setq time-a (get-internal-real-time))
    (setq
     interval-output-pairs
     (generate-beat-rel-MNN<->pattern-inheritance
      external-initial-states internal-initial-states
      stm-> external-final-states internal-final-states
      stm<- point-set-template template-tpc
      patterns-hash whole-piece-interval checklist
      beats-in-bar c-failures c-sources c-forwards
      c-backwards))
    (setq time-b (get-internal-real-time))
    (setq
     point-set
     (interval-output-pairs2dataset
      interval-output-pairs 1))
    ; Transpose to sensible range if possible.
    (setq *rs* (nth i *rs-tr*))
    (setq
     point-set-2
     (transpose-to-sensible-range
      point-set 37 79))
    ; Write output to file.
    (saveit
     (merge-pathnames
      (make-pathname
       :name
       (concatenate
        'string
        "Racchman-Jun2015-sample-output-"
        (write-to-string (+ i 1))) :type "mid")
      output-dir)
     (modify-to-check-dataset
      point-set-2 scale))
    (write-to-file
     ;#|
     (cons
      (float
       (/
        (- time-b time-a)
        internal-time-units-per-second)) point-set)
     ;|#
     ;point-set
     (merge-pathnames
      (make-pathname
       :name
       (concatenate
        'string
        "Racchman-Jun2015-sample-output-"
        (write-to-string (+ i 1))) :type "txt")
      output-dir))))

