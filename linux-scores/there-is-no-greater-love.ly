\version "2.18.2"

#(set-global-staff-size 26)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
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

title = #"There Is No Greater Love"
composer = #"Jymes/Jones"
% meter = \markup{meter?}
meter = #""
copyright = #"some copyright"

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
  % copyright = \copyright
}

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=130
  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)
  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)
  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

}

chords_tingl_partial = \chordmode {
  \partial 4*3 s2. |
}

chords_tingl = \chordmode {
  bes1:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c:7 | f:7 | f:7 |
  \break
  bes:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c2:m7 f:7 | bes1 | bes |
  \break
  a2:m7.5- d:7 | g1:m | a2:m7.5- d:7 | g1:m |
  \break
  a2:m7.5- d:7 | g1:m |  c:7 | f:7 |
  \break
  bes:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c2:m7 f:7 | bes1 | f:7 |

}

head_tingl_partial = \relative c'' {
  \global
  \key bes \major
  \partial 4*3 a4 bes c |
}

head_tingl = \relative c'' {
  % measure 1
  \bar ".|"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

  % measure 5
  g1 ~ |
  g4 g d' des |
  c1 |
  r4 a bes c |
  \bar "||"
  \break

  % measure 9
  \bar "||"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

  % measure 13
  g4 g d' c |
  bes2 c |
  bes1 ~ |
  bes2. r4 |
  \bar "||"
  \break

  % measure 17
  \bar "||"
  d,4 fis a c |
  bes1 |
  fis4 a c ees |
  d1 |
  \break

  % measure 21
  d,4 fis a c |
  bes4 a g d |
  c1 |
  r4 a' bes c
  \bar "||"
  \break

  % measure 25
  \bar "||"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

  % measure 29
  g4 g d' c |
  bes2 c |
  bes1 |
  r1
  \bar "|."
}


% C instruments

rb = \score {
  <<
    \new ChordNames {
      \chords_tingl_partial
      \chords_tingl
    }

    \new Staff \with {
      instrumentName = "piano"
      midiInstrument = "piano"
    } {
      \head_tingl_partial
      \head_tingl
    }
  >>
  \layout {}
  \midi {}
}

rb_chords = \score {
  <<
    \new ChordNames {
      \chords_tingl_partial
      \chords_tingl
    }
    \new Staff \with {
      instrumentName = "piano"
    } {
      \chords_tingl_partial
      \chords_tingl
    }
  >>
}

% E flat instruments

eflat_rb = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_tingl_partial
      \chords_tingl
    }
    \new Staff \with {
      instrumentName = "Alto"
      midiInstrument = "alto sax"
    } \transpose ees, c {
      \head_tingl_partial
      \head_tingl
    }
  >>
  \layout {}
  % \midi {}
}

eflat_chords = \score {
  <<
    \new ChordNames \transpose ees, c \chords_tingl
    \new Staff \with {
      instrumentName = "Alto"
    } \transpose ees c \chords_tingl
  >>
}

% Just choose 1 style to print

% % piano
% \rb
% \pageBreak
% \rb_chords

% alto
% \eflat_rb
% \pageBreak
% \eflat_chords



