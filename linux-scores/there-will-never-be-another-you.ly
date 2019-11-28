\version "2.18.2"

#(set-global-staff-size 20)
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
          \fontsize #8
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

eflat_chords_twnbay = \transpose ees c \chords_twnbay

% E flat instruments

\score {
  <<
  \new ChordNames \eflat_chords_twnbay
  \new Staff \transpose ees, c \head_twnbay
   >>
}

\pageBreak

% C instruments

\score {
  <<
  \new ChordNames \chords_twnbay
  \new Staff \head_twnbay
  >>
}

\pageBreak

% chords only

\score {
  <<
  \new ChordNames \chords_twnbay
  \new Staff \chords_twnbay
  >>
}


\pageBreak

% E flat instruments

\score {
  <<
  \new ChordNames \eflat_chords_twnbay
  \new Staff \eflat_chords_twnbay
   >>
}