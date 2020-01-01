\version "2.18.2"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

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
          \fontsize #7
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

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=210
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

  \bar ".|"
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
  \bar ".|"
  g8-- a-. r8 b c d r4 |
  e4-. g-- d8 r r c
  d1 ~
  d4 r8 ees e ees d4
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
  ais8 e~ e2 s4

  \mark \markup{\small \with-color #red "~39sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~43sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~47sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~51sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~55sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~59sec"}
  s1
  s1
  s1
  s1

  \mark \markup{\small \with-color #red "~63sec"}
  s1
  s1
  s1
  s1

}
                  

% E flat instruments

eflat_konitz = \score {
 << 
 \new ChordNames \transpose ees, c \chords_twnbay
  \new Staff \with {
    instrumentName = "Alto"
    midiInstrument = "alto sax"
  } \eflat_head_twnbay_konitz
   >>
   \layout {}
   \midi {}
}

% \pageBreak

eflat_konitz_plus_rb = \score {
  <<
  \new ChordNames \transpose ees, c {\chords_twnbay_partial \chords_twnbay \chords_twnbay}
  \new Voice = soloist \eflat_head_twnbay_konitz
  \new Voice = soloist \transpose ees, c \head_twnbay
  % \new Staff \transpose ees c \chords_twnbay
   >>
}

% \pageBreak

eflat_rb = \score {
  <<
  \new ChordNames \transpose ees, c \chords_twnbay
  \new Staff \transpose ees, c \head_twnbay
   >>
}

% \pageBreak

% C instruments

rb = \score {
  <<
  \new ChordNames \chords_twnbay
  \new Staff \head_twnbay
  >>
}

% \pageBreak

% chords only

rb_chords = \score {
  <<
  \new ChordNames \chords_twnbay
  \new Staff \chords_twnbay
  >>
}

% \pageBreak

% E flat instruments

eflat_chords = \score {
  <<
  \new ChordNames \transpose ees, c \chords_twnbay
  \new Staff \transpose ees c \chords_twnbay
   >>
}

% Just choose 1 style to print

% \rb
% \pageBreak

% \rb_chords

% \eflat_chords
% \pageBreak

% \eflat_rb

% \eflat_konitz_plus_rb

% \eflat_konitz