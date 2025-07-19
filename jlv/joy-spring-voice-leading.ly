\version "2.24.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = "Joy Spring"
composer = "Clifford Brown"
arranger = ""
tagline = "2022-04-27 Lesson"
meter = ""
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {4} #1 " = " #meter }
          \fontsize #5
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##f
      ragged-last-bottom = ##t
    }
  }
}


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##t

  %% markup-system-spacing = #'((basic-distance . 23)
%%                            (minimum-distance . 8)
%%                            (padding . 1))
  oddHeaderMarkup = \markup
  \fill-line {
    \title
    %% \fromproperty #'header:title " "
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
    \fromproperty #'page:page-number-string " "
    %% \fromproperty #'header:title
    \title
  }
}

\layout {
  \context {
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  %% http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
  \key c \major
                                % %% beam across 4 eighth notes
                                % \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}


%%%%%%%%%%%%%%%%%%%% Functions

timestop = #(define-music-function
             (parser location string)
             (string?)
             "colored markup (for timestamps)"
             #{ <>^\markup \large \with-color #red #string #})

markManualBox = #(define-music-function
                  (parser location string)
                  (string?)
                  "manually set a box mark that matches current color/size"
                  #{ <>\mark \markup \with-color #darkred \box \sans \normalsize  #string #})

markBlue = #(define-music-function
             (parser location string)
             (string?)
             "blue markup string"
             #{ <>\mark \markup \override
             #'(font-name . "lilyjazz-chord")
                \fontsize #-6
                \with-color #blue #string #})

crossNote = 
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override NoteHead.style = #'cross
  #my-music
  \revert NoteHead.style
  #}
)

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

        %% \blankStaves
        %% \pageBreak


        %% Head
        joy_spring =  \relative c'' {
          %% Head
          \markManualBox "A"
          s2. a8 fis
          g8 s4. cis8 s4.
          s1 s1 \break
          \repeat unfold 1 { \repeat unfold 4 s1 \break }

          \markManualBox "B"
          \repeat unfold 2 { \repeat unfold 4 s1 \break }

          \markManualBox "C"
          \repeat unfold 2 { \repeat unfold 4 s1 \break }

          \markManualBox "A"
          \repeat unfold 2 { \repeat unfold 4 s1 \break }
          
        }

        

        %% blue:  D
        %% red:   Eb
        %% green: F
        joy_spring_chordNames = \chordmode {
          %% A
          \blueChord {
            d1:maj7
            e2:m7 a:7
            d1:maj7 }
          \greenChord {
            g2:m7 c:7

            fis2:m7 f:7 }
          \blueChord {
            e2:m7 a:7
            d1:maj7 }
          \redChord {
            f2:m7 bes:7

            %% B
            ees1:maj7
            f2:m7 bes:7
            ees1:maj7 }
          gis2:m7 gis:7

          g2:m7 fis:7
          \redChord {
            f2:m7 bes:7
            ees1:maj7 }
          fis2:m7 b:7

          %% C
          e1:maj7
          \blueChord {
            e2:m7 a:7
            d1:maj7 }
          d2:m7 g:7
          c1:maj7
          \redChord {
            f2:m7 bes:7
            ees1:maj7 }
          \blueChord {
            e2:m7 a:7

            %% A
            d1:maj7
            e2:m7 a:7
            d1:maj7 }
          \greenChord {
            g2:m7 c:7

            fis2:m7 f:7 }
          \blueChord {
            e2:m7 a:7
            d1:maj7 }
          \redChord {
            f2:m7 bes:7 }
        }

        \score {
          <<
            \new ChordNames {
              \repeat unfold 1 {\joy_spring_chordNames}
            }
            \new Staff {
              \global
              \joy_spring
              %% \pageBreak
            }
          >>
        }

