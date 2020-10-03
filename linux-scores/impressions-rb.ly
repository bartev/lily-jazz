\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

title = "Impressions"
composer = "Cotrane"
meter = \markup{UP}
copyright = ""

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
  copyright = \copyright
  % Remove default LilyPond tagline
  tagline = ##f
}

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

rbGlobal = {
  \numericTimeSignature
  \time 4/4
  \key c \major
  \tempo 4=100

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
}

rbChordNames = \chordmode {
  d1:min7 d1:min7 d1:min7 d1:min7
  d1:min7 d1:min7 d1:min7 d1:min7
  ees1:min7 ees1:min7 ees1:min7 ees1:min7
  ees1:min7 ees1:min7 ees1:min7 ees1:min7
  d1:min7 d1:min7 d1:min7 d1:min7
  d1:min7 d1:min7 d1:min7 d1:min7
}

rbMelody = \relative c'' {

  {
   \mark \markup{\small \with-color #red "1:09"} 
   \bar "[|:"
   d1~
   d2 e8 g e d~
   d1~
   d4. e8 f4 g
   \break

   a4 c4~ c8 e,4 d8~
   d2 b4 d8 a~
   a1~
   a1
   \break
   \bar ":|]"

   % \bar ".|"
   es'1~
   es4. des8 ges4 f8 es~
   es1~
   es4. f8 ges4 aes
   \break

   bes4 des4~ des8 f,4 es8~
   es2 c4 es8 bes~
   bes1~
   bes1
   \bar "|." 
   \break

   \bar ".|"
   d1~
   d2 e8 g e d~
   d1~
   d4. e8 f4 g
   \break

   a4 c4~ c8 e,4 d8~
   d2 b4 d8 a~
   a1~
   a1
   \bar "|." 
  }
 
}

% \score {
%   <<
%     \new ChordNames { \rbChordNames }
%     \new Staff {
%          \rbGlobal
%          \rbMelody
%          }
%   >>
% }
