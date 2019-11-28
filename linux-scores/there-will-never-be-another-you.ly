\version "2.18.2"

#(set-global-staff-size 22)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
%  paper-height = 11\in
%  paper-width = 8.5\in
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
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

chords_twnbay = \chordmode {
  \partial 4 r4 | 
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
  g8 a b4 c d
  d4 g d8 r r c
  d1 ~
  d4 r8 ees e ees d4
  \break

  r4 r c8 d e g
  a4 c a4. g8
  a1 ~
  a4. e8 f e ees e
  \break

  c'2 a8 g f e~
  e8 d e2 f8 g
  g2 e8 d c b~
  b8 a b4 c8 b a gis 
  a8
}
                  

% E flat instruments

eflat_konitz = \score {
  <<
  \new ChordNames \transpose ees, c \chords_twnbay
  \new Staff \eflat_head_twnbay_konitz
   >>
}

% \pageBreak

eflat_konitz_plus_rb = \score {
  <<
  \new ChordNames \transpose ees, c \chords_twnbay
  \new Voice = soloist \eflat_head_twnbay_konitz
  \new Voice = soloist \transpose ees, c \head_twnbay
  \new Staff \transpose ees c \chords_twnbay
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

\rb
\pageBreak

% \rb_chords

% \eflat_chords

% \eflat_rb

% \eflat_konitz_plus_rb

\eflat_konitz