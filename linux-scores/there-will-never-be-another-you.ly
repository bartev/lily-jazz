\version "2.24.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

title = #"There Will Never Be Another You"
composer = #"Warren/Gordon"
meter = \markup{ (Up) }
copyright = #"Lee Konitz version"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
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
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 15\mm
  between-system-space = 2.\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

quest = \mark \markup {\small \with-color #red "questionable"}
q_three = \mark \markup{\small \with-color #red "???"}

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=210
  % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)
  % make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)
  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1
}

chords_twnbay_partial = \chordmode {
  \partial 4 s4 |
}

chords_twnbay = \chordmode {
  ees1:maj7 | ees1:maj7 | d:m7.5- | g:7.9- |
  \break
  c:m7 | c:m7 | bes:m7 | ees:7 |
  \break
  aes:maj7 | f2:m7.5- bes:7 | ees1:maj7 | c:m7 |
  \break
  f:7 | c2:m7 f:7 | f1:m7 | bes:7 |
  \break
  ees:maj7 | ees:maj7 | d:m7.5- | g:7.9- |
  \break
  c:m7 | c:m7 | bes:m7 | ees:7 |
  \break
  aes:maj7 | f2:m7.5- bes:7 | ees1:maj7 | g2:m7 c:7 |
  \break
  ees2:maj7 d:7 | g:7 c:7 | f:m7 bes:7 | ees : bes:7 |
}

head_twnbay = \relative c' {
  \global
  \key ees \major
  \partial 4 bes4 |

  \bar ".|-|"
  c d ees f |
  g bes f ees |
  f1 ~ |
  f2 r8 g4. |
  \break

  ees4 f g bes |
  c ees c4. bes8 |
  c1 ~ |
  c2. bes4 |
  \break

  ees4 c bes aes |
  g f g aes |
  bes g f ees |
  f ees8 f ~ f4 ees |
  \break

  d' c bes a |
  g f g f |
  aes?1 ~ |
  aes2. bes,4 \bar "||"
  \break

  c4 d ees f |
  g bes f ees |
  f1 ~ |
  f2 r8 g4. |
  \break

  ees4 f g bes |
  c ees c4. bes8 |
  c1 ~ |
  c2. bes4 |
  \break

  ees4 c bes aes |
  g f g aes |
  bes g f ees8 d'~ |
  d2 r8 c4. |
  \break

  bes4 ees d c |
  bes ees, bes' aes |
  f2 g |
  ees1
  \bar "|."
}

eflat_head_twnbay_konitz = \relative c'' {
  \global
  \key c \major

  \partial 4 r4 |
  \bar ".|-|"
  g8-- a-. r8 b c d r4 |
  e4-. g-- d8 r r c
  d1 ~
  d4 r8 dis e dis d4
  \break

  \mark \markup{\small \with-color #red "4sec"}
  r4 r c8 d e g
  a4 c a4. g8
  a1 ~
  a4. e8 f e ees e
  \break


  \mark \markup{\small \with-color #red "9sec"}
  c'2 a8 g f e~
  e8 d e2 r8 f8
  \mark \markup{\small \with-color #red "11sec"}
  g8 r8 g4 e8 d c b~
  b8 a b4 c8 b a gis
  \break

  \mark \markup{\small \with-color #red "13sec"}
  a8 r8 r4 r4 r8 gis8
  a8 b c b c cis d d
  g8 g8~ g4 r2
  r8 c, d e g d b g
  \break

  a2 r4 b8 c~
  c4 d8 e~ e4 g8 d8~
  d8 c8 e8 c dis d~ d4
  r2 r8 e8 dis d
  \break

  c4 r4 r2
  \tuplet 6/2 {r8 c8 d e8 g a} c8 a r8 c8 a8 r8
  \mark \markup{\small \with-color #red "24sec"}
  c2. r8 g,8
  \tuplet 3/2 {bes8 d f} bes8 g a fis g e
  \break

  \tuplet 3/2 {d16 e d} c8~ c4 r2
  \mark \markup{\small \with-color #red "27sec"}
  r4 r8 d8 ees d c a
  d8 c~ c8 r8 r8 fis8 g8 fis
  b8 a fis2 r4
  \break

  \mark \markup{\small \with-color #red "31sec"}
  b8 a g c~ c4 b8 a
  g e c a gis'4~ gis8 g
  gis8 g~ g4 r2
  r2 r8 e8 d c~
  \break

  % top
  \pageBreak

  \mark \markup{\small \with-color #red "35sec"}
  c4 r4 r4 r8 c8
  e8 c d c a c e g
  d8 dis e c b a g a
  ais8 e~ e2 r4

  \mark \markup{\small \with-color #red "~39sec"}
  r1
  r4 r8 e'8 dis e g r8
  bes4 r4 r8 e,8 d e
  d8 ees e c a c e g

  \mark \markup{\small \with-color #red "~44sec"}
  a8 bes c4 d8 e d8 c8~
  \mark \markup{\small \with-color #red "~45sec"}
  c4 aes8 g f fis g f
  \tuplet 3/2 {e8 f e} d8 c8 b\quest c e g
  b8 c16 b a8 b~ b4 g8 e~

  \mark \markup{\small \with-color #red "~49sec"}
  e4. r8 r4 r4
  r4 r4 r8 b8 c cis |
  d8 cis d e   f e f fis |
  g8 fis f e   f fis g r8 |


  \mark \markup{\small \with-color #red "~53sec"}
  bes2 a8 bes? a8 gis8
  g8 e c a gis' e c a
  e'2 r4 r4
  r4 r8 c8 d c d c


  \mark \markup{\small \with-color #red "~57sec"}
  e8 c d c d c r4
  r2 r8 b8 c b
  c8 r8 c4 r2
  r4 g8 bes \tuplet 3/2 {c8 e g} c4

  \mark \markup{\small \with-color #red "~62sec"}
  a8 g f e g f e d~
  d4 c8 \quest d e g a4~
  a4 r4 r8 g e d
  b'4 c8 b a b a g~

  \mark \markup{\small \with-color #red "~66sec"}
  g4 a8 g f g f e~
  e4 f8 e d cis d e
  f8 a, c b~ b4 e8 d
  c8 a c d16 c b8 c e8 f16 e


  % \mark "Top"
  \mark \markup{\small \with-color #red "~1:11"}
  d8 e8 s4 s2
  s1
  s1
  s1
  \break

  \mark \markup{\small \with-color #red "~1:15"}
  r4 r r r8 a8
  \mark \markup{\small \with-color #red "this may be off a measure"}
  c8 a d a c g e c
  \mark \markup{\small \with-color #red "~1:17"}
  d8 e f fis g e d c
  d8 e d c \q_three r4  d4~
  \break

  \mark \markup{\small \with-color #red "~1:19"}
  d2 r2
  s1 s1 s1 \break

  \mark \markup{\small \with-color #red "~1:24"}
  s1 s1 s1 s1 \break

  \mark \markup{\small \with-color #red "~1:29"}
  s1 s1
  \mark \markup{\small \with-color #red "get this"}
  r4 r8 g8 a16 b32 a g8~ g4
  r2 r4 r8 a8
  \break

  \mark \markup{\small \with-color #red "~1:32"}
  gis8 e g e fis e f e
  d8 dis e d c4 d8 c
  b8 c b g a r8 d8 b
  g8 r8 r4 r2

  \break

  \mark \markup{\small \with-color #red "~1:37"}
  c8 b c a8~ a r8 d8 c
  d8 b~ b r8 r2
  s1 s1 \break

  \mark \markup{\small \with-color #red "~1:41"}
  s1 s1 s1 s1

}


% E flat instruments

eflat_konitz = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_twnbay_partial
      \chords_twnbay
      \chords_twnbay
      \chords_twnbay
    }
    \new Staff \with {
      instrumentName = "Alto-Konitz"
      midiInstrument = "alto sax"
    } \eflat_head_twnbay_konitz
  >>
  \layout {}
  % \midi {}
}

% \pageBreak

eflat_konitz_plus_rb = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_twnbay_partial
      \chords_twnbay
      \pageBreak
      \chords_twnbay
      \pageBreak
      \chords_twnbay
    }
    \new Staff \with {
      instrumentName = \markup {
        \column {
          "Alto"
          \line {"Konitz"}
        }
      }
    } \eflat_head_twnbay_konitz
    \new Staff \with {
      instrumentName = \markup {
        \column {
          "Alto"
          \line {"Real Book"}
        }
      }
    } \transpose ees, c \head_twnbay
    % \new Staff \transpose ees c \chords_twnbay
  >>
}

% \pageBreak

eflat_rb = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_twnbay_partial
      \chords_twnbay
    }
    \new Staff \with {
      instrumentName = \markup {"RB-E" \smaller \flat}
    } \transpose ees, c \head_twnbay
  >>
}

% \pageBreak

% C instruments

rb = \score {
  <<
    \new ChordNames {\chords_twnbay_partial \chords_twnbay}
    \new Staff \with {
      instrumentName = "Real Book-C"
    } \head_twnbay
  >>
}

% \pageBreak

% chords only

rb_chords = \score {
  <<
    \new ChordNames {\chords_twnbay_partial \chords_twnbay}
    \new Staff \with {
      instrumentName = "C instr"
    } {\chords_twnbay_partial \chords_twnbay}
  >>
}

% \pageBreak

% E flat instruments

eflat_chords = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_twnbay_partial
      \chords_twnbay
    }
    \new Staff \with {
      instrumentName = \markup {"E" \smaller \flat "instr"}
    } \transpose ees c {\chords_twnbay_partial \chords_twnbay}
  >>
}

% Just choose 1 style to print

\rb
% \pageBreak
% \rb_chords
% \eflat_chords

% \pageBreak
% \eflat_rb
% \eflat_konitz_plus_rb
% \eflat_konitz