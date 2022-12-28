\version "2.24.0"

% Copy transcription by Kaz Takasugi at
% https://www.youtube.com/watch?v=sMg161bfeHg

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  % #(set-paper-size "letter")
  % between-system-space = 2.5\cm
  % between-system-padding = #0
  % indent = 0\mm
  % markup-system-spacing = #'((basic-distance . 23)
  %                            (minimum-distance . 8)
  %                            (padding . 1))
  % page-breaking = #ly:minimal-breaking
  % print-all-headers = ##t
  % print-page-number = ##t
  % print-first-page-number = ##f
  % %%set to ##t if your score is less than one page:
  % ragged-last-bottom = ##f
  % ragged-bottom = ##f
  % % system-system-spacing.basic-distance = #12
  % oddFooterMarkup = \markup {#not-part-first-page "Spain"}
  evenFooterMarkup = "Spain"
  oddHeaderMarkup = "Spain"
  evenHeaderMarkup = "Spain"
}

title = #"Spain"
piece = #"Spain"
composer = #"Chick Corea"
subtitle = "(Joe Ferrell Flute Solo)"

meter = #"96-116"
copyright = #""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {2} #1 " = " #meter }
          \fontsize #8
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger \larger #title
          \column {
            \fontsize #1 \lower #1 \concat { #composer " " }
            \smaller \lower #0.5 #"transcribed by Kaz Takasugi"
          }
        }
      }
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      % \override TextScript.font-name = #"Pea Missy with a Marker"
    }
  }
}

% \markup { \fontsize #1 (For \concat { E { \raise #0.5 \teeny \flat } } instruments.) }

\header {
  title = \realBookTitle
  subtitle = \subtitle
  % tagline = \markup{ Flute }
  tagline = ##f
  copyright = \copyright
}

% other functions
cross-note =
#(define-music-function (my-music)
   (ly:music?)
   #{
     \override NoteHead.style = #'cross
     #my-music
     \revert NoteHead.style
   #}
   )

fall = \bendAfter #-4
scoop = \bendAfter #+4

fluteSolo = \relative c''' {
  \set Staff.midiInstrument = "flute"
  \key c \major
  \time 2/2
  \set Score.rehearsalMarkFormatter = #format-mark-box-numbers
  % \partial 8 g8 |
  % \showStartRepeatBar \bar "[|:-|"
  \mark \default
  r8 c \noBeam b a g es4-- c8 |
  b a g d e4-- fis8 a |
  fis g a bes c a b e |
  r e cis4-. r2 | \break

  r8 e \noBeam cis bes e4-- cis8 bes |
  e4-- \noBeam  cis8 bes e cis r4 |
  r8 e \noBeam cis bes e4-- cis8 b |
  e cis bes cis r cis a4( | \break

  a4)\fall r a8 bes a aes |
  g a b d fis a b, g |
  e'4-. r r8 bes16[( a)] \noBeam bes8 c |
  des ees f g aes bes,4-- gis8 | \break

  a8 aes g f fis a cis e |
  d4-. r r2 |
  c8 bes b a' g4-. r |
  c,8 bes b a' g4-. r | \break

  cis,4-. aes8 bes r bes? \noBeam aes? bes |
  r bes \noBeam aes bes r bes \noBeam aes c |
  r c \noBeam g c( c2) |
  r2 r8 b8 \noBeam e fis | \break

  b,4-. r r8 a8 \noBeam \tuplet 3/2 {b e fis} |
  b,4-. r r2 |
  c8 b e b r2 |
  r1 | \break

  \pageBreak
  \mark \default
  b8 c b a g a b d |
  a8 c e g b, d fis a |
  c,8 e g b d, fis a a |
  r8 a \noBeam aes g( g4.) e8 | \break
  \repeat unfold 4 {r1} | \break

  r1 |
  r4 a8 aes g fis e d |
  cis e, g a bes c des ees |
  e fis g a bes c a g | \break

  fis a cis e d b g e |
  fis a e d( d4) r |
  \repeat unfold 2 {r1} \break

  r8 d' \noBeam cis b bes d c b |
  bes4-. r r16 bes8[ a16]( \noBeam a) g8.( |
  g2.) e16( d c b |
  bes cis e g) fis4-. r2 | \break

  \set Staff.autoBeaming = ##f
  \ottava #1
  r4 \tuplet 3/2 4 {r8[ fis cis'] b[ f c'] b[( c c]} |
  \tuplet 3/2 4 {b[ fis cis'] b[ fis cis'] b[ c c]} c16[ b fis' gis] |
  \tuplet 3/2 4 {fis8[ fis gis] gis[ fis gis] cis,[ cis b] fis[ b e,~)]} |
  e4 r r2 | \break
  \ottava #0

  \set Staff.autoBeaming = ##t
  \pageBreak
  \mark \default
  \ottava #1
  fis'4-. a-. \tuplet 3/2 {r4 g-. fis} |
  r8 e r d b4-. e ~ |
  e4. cis8 d b g e |
  a aes g fis r fis e4 | \break
  \ottava #0

  r2 r4 r8 bes16( aes |
  ges8) aes bes des ges aes bes des |
  ges-> des r4 r2 |
  r1 | \break

  \ottava #1
  a'4-. aes-. g-. r |
  fis4-. f8 e r2 |
  \ottava #0
  d4-. b-. bes-. r |
  bes8 ges des bes r2 | \break

  bes8[ gis] \noBeam a g'~ \tuplet 3/2 {g8 fis4-.} r4 |
  fis8 a cis e cis d b g |
  fis8 e a g fis e d bes |
  a g d e fis4-- r4 | \break

  r4 r8 g cis, d aes' g |
  ees8 ges aes b f aes? b d |
  aes8 b d g b, cis \cross-note d e |
  b4-- r r2 | \break

  r8 a( \noBeam b e fis) a->( b a) |
  fis'4.^\markup { \with-color #red {F \sharp} } a8^\markup { \with-color #red {A} } r e8 b4-- |
  \repeat unfold 2 {r1} | \break

  \pageBreak
  \mark \default
  r1 |
  r1 |
  bes,8 b c b c d e fis |
  a8 fis g a b a r4 | \break

  r2 bes8 aes bes aes |
  ges8 f e ees des b bes d |
  e8 gis ees e g b ees des |
  r1 | \break

  e8 cis b cis d b g c |
  cis8 a \cross-note e bes' b g e gis |
  a8 fis d b g'2~ |
  g4. fis16( e d8 e bes'16 a8.) | \break

  r2 a8 b cis a |
  d8 b r e r cis \noBeam a fis |
  g8 b d fis^\markup { \with-color #red {F \sharp } } a4-^^\markup{\with-color #red {A}} r |
  r1 | \break

  r2 r8 aes,,8 \noBeam bes des |
  f aes bes des f^\markup{\with-color #red {F}} des r4 |
  r4 r8 d, d, g a c |
  d g a c g'^\markup{\with-color #red {G}} c, g' c, | \break

  r2 fis8 b, cis b~ |
  b4 fis'8 b, b2 |
  fis'8 b, fis' b, fis' b,4-- b8 |
  fis'8 b, r4 r2 | \break

  \pageBreak
  \mark \default
  r4 \tuplet 3/2 {bes8( b c)} b4-- \tuplet 3/2 {bes8( b c)} |
  b4-- \tuplet 3/2 {bes8( b c)} b4-- \tuplet 3/2 {fis8( g a)} |
  g1 |
  d8 b r4 r2 | \break

  r2 r4 r8 bes |
  a8 bes cis4-- e8 g a bes |
  \tuplet 3/2 {cis4-- e-- f-.} a4. aes8 |
  \tuplet 3/2 {g8( fis f} c4-.) r2 | \break

  r2 cis8 d e cis |
  d4-. r b8 g fis e |
  a g b, g bes g' e f |
  fis4-. r r2 | \break

  cis16[( d8.)] \noBeam e8 cis d b g e |
  fis8 a r a~ a4 d-. |
  \tuplet 3/2 {d4-- g-. g--~} g4 b-. |
  b4-- d-. d-. r | \break

  cis4-. b-. bes-. a-. |
  aes4-. g8 fis r f r \cross-note e |
  r1 |
  r2 r4 b8 d | \break

  e4-. r8 d e e-. r d |
  e4-- \breathe d8 e~ e2 |
  r1 |
  fis4-. r8 c r4 fis-. \bar "||" \break

}

theChords = \chordmode {
  \set chordChanges = ##t
  \repeat unfold 5 {
    \repeat unfold 4 {g1:maj7.11+}  \break
    \repeat unfold 4 {fis:7.13-} \break
    \repeat unfold 2 {e:m7} \repeat unfold 2 {a:7} \break
    \repeat unfold 2 {d:maj7} \repeat unfold 2 {g:maj7.11+} \break
    \repeat unfold 2 {cis:7} \repeat unfold 2 {fis:7.13-} \break
    \repeat unfold 2 {b:min7} \repeat unfold 2 {b:7} \break
  }
}

\score {
  <<
    \new ChordNames \theChords
    \new Voice = soloist \fluteSolo
  >>
  \layout {
    \override Score.Clef.break-visibility = #'#(#f #f #f)  % make only the first clef visible
    \override Score.KeySignature.break-visibility = #'#(#f #f #f)  % make only the first time signature visible
    \override Score.SystemStartBar.collapse-height = #1  % allow single-staff system bars
    % #(layout-set-staff-size 25)
  }
  \midi {
    \tempo 2 = 106
  }
  \header {
    piece = "Spain"
  }
}