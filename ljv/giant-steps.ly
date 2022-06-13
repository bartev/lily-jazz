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
          e8 b gis \xNote dis a' f e d
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
          cis8 a fis cis e \xNote cis! dis c'
          b8 a gis fis e fis? gis? b
          c8 bes aes g~ g ees f g
          \break

          \timestop "0:37"
          aes8 bes c ees g fis f e
          d4 r f8 e d b
          c8 d \xNote e g c4-- g-.
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
          c,8 d e g des \xNote ees f g
          ees4. c8 bes a aes ees
          a8 b c a e' d b a
          \break

          \timestop "0:47"
          g4 r8 f' e c r4
          r8 fis, \xNote { \tuplet 3/2 { a8 cis e } } gis8 fis dis cis!
          \markBlue "1-2-3-5 of B7"
          b8 cis dis fis e fis! gis g~
          g4 aes 2.
          \break

          \timestop "0:50"
          g8 ees f g ees! c bes aes
          a8 b c \xNote a e' d b a
          g4. e'8~ e r r4
          r8 bes \tuplet 3/2 { des8 f aes } ees8 f g bes
          \bar "||"
          \break

          \markManualBox "D"
          \timestop "0:53"
          aes8 bes, c ees b cis dis fis
          e8 b gis \xNote \markBlue "1-3-5-1 of D-7" e a f e d
          c8 d e f g a b d
          cis8 a \xNote { e' cis } gis' \xNote b, cis! dis
          \break

          \timestop "0:57"
          e8 fis gis b f a g f
          e8 c d e des \xNote ees f g
          bes4 g8 f ees c r4
          r2 b'4. a16 aes
          \break

          \timestop "1:00"
          g8 f e d c d e g
          b2.~ b8 ais16 a
          gis8 dis fis dis! e b gis \xNote e
          c'8 aes g ees f ees! f g
          \break

          \timestop "1:03"
          aes8 bes c \xNote ees g ees! c aes!
          f'4. e16 ees d8 c b a!
          g8 f e d c \xNote d \xNote ees g
          c4 r r2
          \bar "||"
          \break

          \timestop "1:06"
          \markManualBox "E"
          r8 ees,8 aes c b cis dis fis
          e8 b gis e a f e d
          c8 d e f g a b d
          cis8 eis \xNote e \xNote c gis' b, cis fis
          \break

          \timestop "1:10"
          e8 fis gis a b, d f a
          c,8 d e \xNote e r2
          ees4 c8 bes aes bes! c ees!
          g8 fis f e d c b a
          \break

          \timestop "1:13"
          g8 f' e b d c b d
          cis8 a fis \xNote cis e4. \xNote dis8
          b'4 r gis'4 r
          r8 bes, \tuplet 3/2 { des8 f aes } g4 bes
          \break

          \timestop "1:16"
          bes4. g8 ees c r4
          b'2 g8 f e d
          c8 d e g c4 r4
          r8 c8 bes aes g4. ees8
          \bar "||"
          \break

          \markManualBox "F"
          \timestop "1:20"
          b'2.~ b8 ais16 a
          gis8 b, e gis g fis f a
          g8 e d c e g4 c8~
          c8 b,4 gis'8 fis4 r4
          \break

          \timestop "1:23"
          r8 b, e gis b, d f a
          c,8 \xNote { d e } g c4 bes8 aes
          g8 f ees des c bes aes \xNote g
          a8 b c d e d b a
          \break

          \timestop "1:26"
          g8 f' e b d c b a
          fis'8 e4 \xNote { b16 e } gis4 e8 gis!~
          gis4. e8 gis b r4
          r8 bes, \tuplet 3/2 { des8 f aes } g8 bes4.~
          \break

          \timestop "1:30"
          bes4 g8 f ees c aes4
          b'4. a16 aes g8 f e d
          c d e g c4 r
          r4 bes~ bes4. g8
          \bar "||"
          \break

          \markManualBox "G"
          \timestop "1:33"
          f8 ees c aes b cis dis fis
          e8 b gis e a c b a
          g8 a b d c d \xNote e g
          gis8 fis e dis~ dis4 r
          \break

          \timestop "1:36"
          r8 b e gis b, d f a
          c,8 d e g des f g bes
          g8 f g \xNote ees g fis f e
          d8 c b a g f e d
          \break

          \timestop "1:40"
          c16 d e f g a b c d e f g~ g8 r
          r4 fis,16 gis a b cis dis e fis gis4~
          gis4. dis8 fis e r4
          r8 bes8 \tuplet 3/2 {des8 f aes} g4 c4
          \break

          \timestop "1:43"
          bes4. g8 ees c r4
          r4 b'4 g8 f e d
          c8 b d b c d e g
          c,8 aes f \xNote des g ees \xNote {f g}
          \bar "||"
          \break

          \markManualBox "H"
          \timestop "1:47"
          aes8 \xNote { bes c } ees b cis dis fis
          e8 b gis \xNote e a c b a
          g8 e' r4 r r8 e8~
          e4. cis8 dis e fis gis
          \break

          \timestop "1:50"
          e8 e r gis16 b f8 a g f
          e8 c d e des ees f g
          bes4 g8 f ees c aes \xNote e!
          a8 b c d e d b a
          \break

          \timestop "1:53"
          g8 f' e b d c b d
          cis8 a fis \xNote e b'4. a8
          gis8 b cis dis~ dis4 r
          r8 bes \tuplet 3/2 { des f aes } g4 ees
          \break

          \timestop "1:56"
          ees4. c8 bes4 aes
          a8 b c a e' d b a
          g8 c d e~ e e g4
          r2 r8 g4.~
          \bar "||"
          \break

          \markManualBox "I"
          \timestop "1:59"
          g4. ees8 b' a4 fis8~
          fis8 a gis \xNote b, e gis~ gis fis
          f!8 a g e d c e g
          cis,4 r gis'8 fis dis c
          \break

          \timestop "2:02"
          b8 cis dis fis b, d f a
          c,8 d e g des ees f g
          bes4 g8 f ees c aes \xNote e
          e'8 f e d16 c b8 a g f
          \break

          \timestop "2:06"
          e8 g a b d c e e
          r2 e8 \xNote cis dis fis
          e8 b gis e b'4 r
          c4 aes8 \xNote ees g4. ees8
          \break

          \timestop "2:10"
          aes8 bes c ees g fis f e
          d e f d g dis b \xNote g
          e'8 c b d c4 r
          r4 r8 ees~ ees2
          \bar "||"
          \break

          \markManualBox "J"
          \timestop "2:13"
          aes,8 bes c ees b cis dis fis
          b,4. e16 gis f4 \grace g16 a8 g~
          g4. e8 d c r4
          r4 bis8 \xNote { cis16 e } gis4 b,
          \break

          \timestop "2:16"
          e8 fis gis a16 gis g8 fis f a
          g8 e d c des ees f g
          bes8 g f ees c bes aes \xNote e
          a8 b c e d4 r4
          \break

          \timestop "2:20"
          r8 f e b d c b \xNote a
          cis8 e r \xNote cis gis' fis dis cis
          b8 cis dis fis e b gis \xNote e
          c'8 r r4 c4. g8~
          \break

          \timestop "2:23"
          g4. ees8 aes bes c ees
          g8 fis f e d c b a
          g8 f' e c d c b a
          c aes f \xNote des g4. ees8
          \break
          \bar "||"

          \markManualBox "K"
          \timestop "2:26"
          aes8 bes c ees b cis dis fis
          e8 r r4 b'2
          g8 f e d c d e g
          c4 r b4. ais16 a
          \break

          \timestop "2:30"
          gis8 b, e gis f a g f
          c4 r des8 ees f g
          bes8 g f ees c c aes \xNote ees
          c'8 d e \xNote c g' dis b a
          \break

          \timestop "2:33"
          g8 e' f d c d e g
          gis8 fis e dis~ dis cis b a
          gis8 b e fis gis \xNote b, e gis!
          g!4 r bes2
          \break

          \timestop "2:36"
          g4. bes8 g ees c \xNote aes
          a8 b c d e d b a
          g8 c \xNote e g c4 g8 a~
          a8 g4.~ g4 r
          \bar "||"
          \break

          \markManualBox "L"
          \timestop "2:40"
          r4 bes4 b4. gis8~
          gis8 a gis e fis a g4
          r2 b2
          g8 e c4 b'2
          \break

          \timestop "2:43"
          gis8 b, e gis b, d f a
          c,8 d \xNote e g c2~
          c4 bes8 aes g ees c \xNote aes
          b'4~ \tuplet 3/2 { b8 a aes } g8 fis f e
          \break

          \timestop "2:46"
          d8 c b a g a b d
          cis8 e \xNote {e c } b'4. ais8
          gis4 dis8 fis~ fis fis e4
          r4 r8 g8~ g4. ees8
          \break

          \timestop "2:50"
          f8 g ees c~ c c aes \xNote e!
          a8 b c a e' d b a
          g8 a b d c d e g
          c,8 aes f \xNote des g4. ees8
          \break
          \bar "||"

          \markManualBox "M"
          \timestop "2:53"
          aes8 bes c ees b a gis b
          gis2 \xNote { g4. e8~ }
          \xNote e4 r r2
          \break

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
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }8
          \markup \with-color #darkred \scaleDegree { 3 }8
          \markup \with-color #darkred \scaleDegree { 5 }8

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

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }8
          \markup \with-color #darkred \scaleDegree { 3 }8
          \markup \with-color #darkred \scaleDegree { 5 }8
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
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }8
          \markup \with-color #darkred \scaleDegree { 3 }8
          \markup \with-color #darkred \scaleDegree { 5 }8

          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8

          %% m45
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }8
          \markup \with-color #darkred \scaleDegree { 3 }8
          \markup \with-color #darkred \scaleDegree { 5 }8
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

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }8
          ""8
          \markup \with-color #darkred \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 5 }4

          ""4
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8

          %% C
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

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
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
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          %% D
          %% m65
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

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

          %% m69
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
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

          %% m73
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 4 }2
          \markup \scaleDegree { 1 }4.
          \markup \scaleDegree { 7 }16
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          %% m77
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { f3 }4.
          \markup \scaleDegree { 2 }16
          \markup \scaleDegree { f2 }
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { f3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 9 }4
          ""2.

          %% E
          %% m81
          ""8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { f5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 5 }

          %% m85
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 3 }
          ""2

          \markup \scaleDegree { 5 }4
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m89
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 4 }4.
          \markup \scaleDegree { 3 }8

          \markup \scaleDegree { 5 }4
          ""
          \markup \scaleDegree { 3 }
          ""

          ""8
          \markup \scaleDegree { 1 }8
          \tuplet 3/2 {
            \markup \scaleDegree { 3 }
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { 7 }
          }
          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { 1 }

          %% m93
          \markup \scaleDegree { 9 }4.
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          ""4

          \markup \scaleDegree { 6 }2
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 1 }4
          ""4

          ""8
          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8

          %% F
          %% m97
          \markup \scaleDegree { s9 }2.
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 7 }16
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }4
          \markup \scaleDegree { 1 }8

          \markup \scaleDegree { f5 }8
          \markup \scaleDegree { 4 }4
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 5 }4
          ""4

          %% m101
          ""8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }

          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m105
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 6 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }4
          \markup \scaleDegree { 4 }16
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 6 }

          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          ""4

          ""8
          \markup \scaleDegree { 1 }8
          \tuplet 3/2 {
            \markup \scaleDegree { f3 }8
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { f7 }
          }
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 1 }4.

          %% m109
          \markup \scaleDegree { 9 }4
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }4

          \markup \scaleDegree { 6 }4.
          \markup \scaleDegree { 5 }16
          \markup \scaleDegree { f5 }
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }


          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 1 }4
          ""4

          ""4
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 3 }8

          %% G
          %% m113
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }
          \markup \with-color #darkred \scaleDegree { 1 }
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 3 }4
          ""4

          %% m117
          ""8
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { s6 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { s5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }

          %% m121
          \markup \scaleDegree { 1 }16
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 5 }8
          ""8

          ""4
          \markup \scaleDegree { 1 }16
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }4


          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          ""4

          ""8
          \markup \scaleDegree { 1 }
          \tuplet 3/2 {
            \markup \scaleDegree { 3 }
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { 7 }
          }
          \markup \scaleDegree { 3 }4
          \markup \scaleDegree { 6 }

          %% m125
          \markup \scaleDegree { 9 }4.
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          ""4

          ""4
          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          %% H
          %% m 129
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          ""4
          ""4
          ""8
          \markup \scaleDegree { 3 }8

          \markup \scaleDegree { f7 }4.
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }

          %% m133
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 1 }
          ""8
          \markup \scaleDegree { 3 }16
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 9 }4
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m137
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }4.
          \markup \scaleDegree { f7 }8

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }4.
          ""4

          ""8
          \markup \scaleDegree { 1 }
          \tuplet 3/2 {
            \markup \scaleDegree { f3 }
            \markup \scaleDegree { 5 }
            \markup \scaleDegree { f7 }
          }
          \markup \scaleDegree { 3 }4
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }4
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }4
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }4

          ""2
          ""8
          \markup \scaleDegree { 3 }4.

          %% I
          %% m145
          \markup \scaleDegree { 7 }4.
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }4
          \markup \scaleDegree { 5 }8

          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 7 }8

          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 5 }4
          ""4
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f2 }

          %% m149
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }

          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 9 }4
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }16
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }

          %% m153
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }4

          ""2
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }4
          ""4

          \markup \scaleDegree { 2 }4
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8

          %% m157
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { s6 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { s5 }

          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { s5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }4
          ""4

          ""2
          \markup \scaleDegree { 1 }2

          %% J
          %% m161
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 1 }16
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f7 }4
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }4.
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          ""4
          ""4
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 5 }16
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }4
          \markup \scaleDegree { 1 }

          %% m165
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }16
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { 5 }4
          ""4

          %% m169
          ""8
          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 6 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { f7 }
          ""8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 9 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 2 }
          ""8
          ""4
          \markup \scaleDegree { 6 }4.
          \markup \scaleDegree { 3 }8

          %% m175
          \markup \scaleDegree { 7 }4.
          \markup \scaleDegree { 5 }8
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 4 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 6 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { f3 }
          \markup \scaleDegree { 3 }4.
          \markup \scaleDegree { 1 }8


          %% K
          %% m177
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 1 }8
          ""8
          ""4
          \markup \scaleDegree { 3 }2

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 5 }4
          ""4
          \markup \scaleDegree { 1 }4.
          \markup \scaleDegree { 7 }16
          \markup \scaleDegree { f7 }8

          %%m181
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 1 }4
          ""4
          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }

          \markup \scaleDegree { f7 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m185
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 4 }
          \markup \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 1 }8
          \markup \with-color #darkred \scaleDegree { 2 }
          \markup \with-color #darkred \scaleDegree { 3 }
          \markup \with-color #darkred \scaleDegree { 5 }

          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { f7 }

          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 2 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }

          \markup \scaleDegree { 6 }4
          ""4
          \markup \scaleDegree { 5 }2

          %% m 189
          \markup \scaleDegree { 7 }4.
          \markup \scaleDegree { 9 }8
          \markup \scaleDegree { 7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 1 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 1 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 1 }4
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }

          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { 6 }4.
          \markup \scaleDegree { 3 }4
          ""4
        }

        %% blue:  E
        %% red:   C
        %% green: Ab
        giant_steps_chordNames = \chordmode {
          %% A
          \greenChord aes2:maj7
          \blueChord { b:7 e2:maj7 }
          \redChord { g:7 c1:maj7 }
          \blueChord { fis2:m7 b:7 e2:maj7 }
          \redChord { g:7 c2:maj7 }
          \greenChord { ees:7 aes1:maj7 }
          \redChord { d2:m7 g:7 c1:maj7 }
          \blueChord { fis2:m7 b:7 e1:maj7 }
          \greenChord { bes2:m7 ees:7 aes1:maj7 }
          \redChord { d2:m7 g:7 c1:maj7 }
          \greenChord { bes2:m7 ees:7 }
        }

        %% giant_steps_chordAnalysis= \new Lyrics \lyricmode { }

        \score {
          <<
            %% \giant_steps_chordAnalysis
            \new ChordNames {
              \repeat unfold 13 {\giant_steps_chordNames}
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
