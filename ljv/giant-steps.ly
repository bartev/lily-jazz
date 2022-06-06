\version "2.20.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = "Giant Steps"
composer = "John Coltrane"
arranger = ""
tagline = ""
meter = "290"
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note #"4" #1 " = " #meter }
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
      last-ragged-bottom = ##t
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
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
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
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet

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
        giant_steps =  \relative c'' {
          %% Head
          \markManualBox "Head"
          \timestop "0:00"
          ees2 b
          gis2 e4. g8~
          g2. r4
          gis4. fis8~ fis2
          \break

          b2 g
          e2 c4. ees8~
          ees2 r2
          e?2 d4. g8~
          \break
          
          g1
          gis2 fis4. b8~
          b2 r
          c2 c4. ees8~
          \break
          
          ees1
          e?2 e4. g8~
          g1
          ees4. ees8~ ees r r4
          \bar "||"
          \break

          \markManualBox "A (Head again)"
          \timestop "0:13"    
          ees2 b
          gis2 e4. g8~
          g2. r4
          gis4. fis8~ fis2
          \break

          b2 g
          e2 c4. ees8~
          ees2 r2
          e?2 d4. g8~
          \break
          
          g2. r4
          gis2 fis4. b8~
          b2 r
          c2 c4. ees8~
          \break
          
          ees1
          e?2 e4. g8~
          g2. r4
          bes,8 des f aes g4. f8
          \bar "||"
          \pageBreak
          
          \markManualBox "B (Start solo)"
          \timestop "0:27"
          ees8 c aes4 b8 cis dis fis
          e8 b gis \crossNote dis a' f e d
          c8 d e f g a b d
          cis8 a fis e dis c' b a
          \break

          \timestop "0:30"
          gis8 b e gis b, d f? a
          c,8 d e g des f g bes
          g4 f8 ees~ ees4 r
          g8 fis f e d c b a
          \break

          \timestop "0:33"
          g8 f' e b d c b d
          cis8 a fis cis e \crossNote cis! dis c'
          b8 a gis fis e fis? gis? b
          c8 bes aes g~ g ees f g
          \break

          \timestop "0:37"
          aes8 bes c ees g fis f e
          d4 r f8 e d b
          c8 d \crossNote e g c4-- g-.
          r4 g8 aes g4. ees8
          \bar "||"
          \break

          \markManualBox "C"
          \timestop "0:40"
          b'2.~ b8 bes16 a
          gis8 b, e gis? g fis f a
          g8 e d c e c r4
          b'4. g?8~ g dis b4
          \break

          \timestop "0:43"
          r8 b e gis b, d f a
          c,8 d e g des \crossNote ees f g
          ees4. c8 bes a aes ees
          a8 b c a e' d b a
          \break

          \timestop "0:47"
          g4 r8 f' e c r4
          r8 fis, \crossNote { \tuplet 3/2 { a8 cis e } } gis8 fis dis cis!
          \markBlue "1-2-3-5 of B7"
          b8 cis dis fis e fis? gis g~
          g4 aes 2.
          \break

          \timestop "0:50"
          g8 ees f g ees! c bes aes
          a8 b c \crossNote a e' d b a
          g4. e'8~ e r r4
          r8 bes \tuplet 3/2 { des8 f aes } ees8 f g bes
          \bar "||"
          \break
          
          \markManualBox "D"
          \timestop "0:53?"
          aes8 bes, c ees b cis dis fis
          e8 b gis \crossNote \markBlue "1-3-5-1 of D-7" e a f e d
          c8 d e f g a b d
          cis8 a \crossNote { e' cis } gis' \crossNote b, cis? dis
          \break

          \timestop "0:xx"
          e8 fis gis b f a g f
          e8 c d e des \crossNote ees f g
          bes4 g8 f ees c r4
          r2 b'4. a16 aes
          \break

          \timestop "0:xx"
          ges8 f e d c d e g
          b2.~ b8 ais16 a
          gis8 dis fis dis! e b gis \crossNote e
          c'8 aes g ees f ees! f g
          \break

          \timestop "0:xx"
          aes8 bes c \crossNote ees g ees! c aes!
          fis'4. e8 d c b a!
          g8 f e d c \crossNote d \crossNote ees g
          c4 r r2
          \bar "||"
          \break

          \timestop "0:xx"
          \markManualBox "E"
          r8 ees,8 aes c b cis dis fis
          e8 b gis e a f e d
          c8 d e f g a b d
          cis8 eis \crossNote e \crossNote c gis' b, cis fis
          \break

          \timestop "0:xx"
          e8 fis gis a b, d f a
          c,8 d e \crossNote e r2
          ees4 c8 bes aes bes! c ees!
          g8 fis f e d c b a
          \break

          \timestop "0:xx"
          g8 f' e b d c b d
          cis8 a fis \crossNote cis e4. \crossNote dis8
          b'4 r gis'4 r
          r8 bes, \tuplet 3/2 { des8 f aes } g4 bes
          \break
          
          \timestop "0:xx"
          b!4. g8 ees c r4
          b'2 g8 f e d
          c8 d e g c4 r4
          r8 c8 bes aes g4. ees8
          \bar "||"
          \break

          \markManualBox "F"
          \timestop "0:xx"
          b'2.~ b8 ais16 a
          gis8 b, e gis g fis f a
          g8 e d c e g4 c8~
          c8 b,4 gis'8 fis4 r4
          \break

          \timestop "0:xx"
          r8 b, e gis b, d f a
          c,8 \crossNote { d e } g c4 bes8 aes
          g8 f ees des c bes aes \crossNote e
          a8 b c d e d b a
          \break

          \timestop "0:xx"
          g8 f' e b d c b a
          fis'8 e4 \crossNote { b16 e } gis4 e8 g~
          g4. e8 gis b r4
          r8 bes, \tuplet 3/2 { des8 f aes } g8 bes4.~
          \break

          \timestop "0:xx"
          bes4 g8 f ees c aes4
          b'4. a16 aes g8 f e d
          c d e g c4 r
          r4 bes~ bes4. g8
          \bar "||"
          \break
          
          \markManualBox "G"
          \timestop "0:xx"

          % \markManualBox "H"
          % \markManualBox "I"
          % \markManualBox "J"
          % \markManualBox "K"
          % \markManualBox "L"
          
          \repeat unfold 7 {
            \repeat unfold 4 { s1 } \break
            }
          
        }

        giant_steps_head_scale_degrees = \lyrics {
          \markup \scaleDegree { 3 }2
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 2 }2
          \markup \scaleDegree { 5 }2
          
          \markup \scaleDegree { 3 }2
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          ""2
          \markup \scaleDegree { 2 }2
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 2 }2
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 4 }2
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 2 }2
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 4 }2
          \markup \scaleDegree { 1 } 

          %% head, repeated
                    \markup \scaleDegree { 3 }2
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }1
          \markup \scaleDegree { 2 }2
          \markup \scaleDegree { 5 }2

          \repeat unfold 11 { ""1 }
        }
        giant_steps_solo_scale_degrees = \lyrics {

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f3 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 2 }8

          %% B start solo
          %% m33
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 7 }8 
          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }8 

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 4 }8 
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 9 }8 

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f3 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }8 
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { f9 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }8 

          %% m37
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 3 }8 
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 9 }8 
          
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 
          
          \markup \scaleDegree { 7 }4
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }4.
          ""4
          
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { f3 }8
          \markup \scaleDegree { 2 }8 
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }8 

          %% m41
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 7 }8 
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 2 }8 

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f3 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }8 
          \markup \scaleDegree { 4 }8
          ""8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { f9 }8

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }8 
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 

          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 6 }8 
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8 

          %% m45
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { s6 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { s5 }8 

          \markup \scaleDegree { 1 }4
          ""4
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }8

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          ""8
          \markup \scaleDegree { 5 }8 
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 5 }4

          ""4
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8 

          %% m49
          \markup \scaleDegree { s9 }2.
          ""8
          \markup \scaleDegree { 2 }16
          \markup \scaleDegree { s1 }16

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 9 }8
          

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }8
          ""4

          \markup \scaleDegree { 4 }4.
          ""8
          \markup \scaleDegree { s5 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }4

          %% m53
          ""8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 8 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { s1 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m57
          \markup \scaleDegree { 5 }4
          ""8
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          ""4

          ""8
          \markup \scaleDegree { 1 }8
          \tuplet 3/2 {
            \markup \scaleDegree { f3 }8
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { f7 }
          }
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f3 }

          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { f7 }2.

          %% m61
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 3 }8
          ""2

          ""8
          \markup \scaleDegree { 1 }8
          \tuplet 3/2 {
            \markup \scaleDegree { f3 }8
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { f7 }
          }
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          %% m65
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          %% m68
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 4 }

          \markup \scaleDegree { 2 }4
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          ""4

          ""2
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 2 }16
          \markup \scaleDegree { f2 }
          
          
        }
        

        %% blue:  E
        %% red:   C
        %% green: Ab
        giant_steps_chordNames = \chordmode {
          %% A
          \greenChord aes2:maj7 \blueChord { b:7
          e2:maj7 } \redChord { g:7
          c1:maj7 }
          \blueChord { fis2:m7 b:7
          
          e2:maj7 } \redChord { g:7
          c2:maj7 } \greenChord { ees:7
          aes1:maj7 }
          \redChord { d2:m7 g:7
          
          c1:maj7 }
          \blueChord { fis2:m7 b:7
          e1:maj7 }
          \greenChord { bes2:m7 ees:7
          
          aes1:maj7 }
          \redChord { d2:m7 g:7
          c1:maj7 }
          \greenChord { bes2:m7 ees:7 }
        }

        %% giant_steps_chordAnalysis= \new Lyrics \lyricmode { }

        \score {
          <<
            %% \giant_steps_chordAnalysis
            \new ChordNames {
              \repeat unfold 7 {\giant_steps_chordNames}
            }
            \new Staff {
              \global
              \giant_steps
              %% \pageBreak
            }
            {
              \giant_steps_head_scale_degrees
              \giant_steps_solo_scale_degrees
            }
          >>
        }

        %%	\pageBreak
        %%	\blankStaves
