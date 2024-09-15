\version "2.24.0"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bartev's custom functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% Functions

%% Set fontsize in markupt https://lilypond.org/doc/v2.23/Documentation/notation/formatting-text
timestop = #(define-music-function
             (parser location string)
             (string?)
             "colored markup (for timestamps)"
             #{ <>^\markup \halign #3 \fontsize #-3 \with-color #red #string #})

markManualBox = #(define-music-function
                  (parser location string)
                  (string?)
                  "manually set a box mark that matches current color/size"
                  #{ <>\mark \markup \with-color #darkred \box \sans \small #string #})

%% maybe use \textMark instead of \mark \markup
%% https://lilypond.org/doc/v2.23/Documentation/notation/writing-text#text-marks
markBlue = #(define-music-function
             (parser location string)
             (string?)
             "blue markup string"
             #{ <>\mark \markup \override
             #'(font-name . "lilyjazz-chord")
                \fontsize #-6
                \with-color #blue #string #})

blueChord =
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override ChordName.color = #darkblue
  #my-music
  \revert ChordName.color
  #}
)

redChord =
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override ChordName.color = #darkred
  #my-music
  \revert ChordName.color
  #}
)

greenChord =
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override ChordName.color = #darkgreen
  #my-music
  \revert ChordName.color
  #}
)

#(define (naturalize-pitch p)
  (let ((o (ly:pitch-octave p))
        (a (* 4 (ly:pitch-alteration p)))
        ;; alteration, a, in quarter tone steps,
        ;; for historical reasons
        (n (ly:pitch-notename p)))
   (cond
    ((and (> a 1) (or (eqv? n 6) (eqv? n 2)))
     (set! a (- a 2))
     (set! n (+ n 1)))
    ((and (< a -1) (or (eqv? n 0) (eqv? n 3)))
     (set! a (+ a 2))
     (set! n (- n 1))))
   (cond
    ((> a 2) (set! a (- a 4)) (set! n (+ n 1)))
    ((< a -2) (set! a (+ a 4)) (set! n (- n 1))))
   (if (< n 0) (begin (set! o (- o 1)) (set! n (+ n 7))))
   (if (> n 6) (begin (set! o (+ o 1)) (set! n (- n 7))))
   (ly:make-pitch o n (/ a 4))))

        #(define (naturalize music)
          (let ((es (ly:music-property music 'elements))
                (e (ly:music-property music 'element))
                (p (ly:music-property music 'pitch)))
           (if (pair? es)
            (ly:music-set-property!
             music 'elements
             (map naturalize es)))
           (if (ly:music? e)
            (ly:music-set-property!
             music 'element
             (naturalize e)))
           (if (ly:pitch? p)
            (begin
             (set! p (naturalize-pitch p))
             (ly:music-set-property! music 'pitch p)))
           music))

        naturalizeMusic =
        #(define-music-function (m)
          (ly:music?)
          (naturalize m))

        %% Start with blank staves
        blankStaves= \score {
          {
            \repeat unfold 11 { s1 \break }
          }
          \layout {
            #(layout-set-staff-size 28)
            indent = 0\in
            \context {
              \Staff
              \remove "Time_signature_engraver"
              \remove "Clef_engraver"
              \remove "Bar_engraver"
            }
            \context {
              \Score
              \remove "Bar_number_engraver"
            }
          }
        }
