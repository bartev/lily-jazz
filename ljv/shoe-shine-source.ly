\version "2.20.0"

% Rhythm changes

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\include "rhythm-changes-source.ly"

title = #"Shoe Shine Boy"
composer = #"Lester Young"
meter = ""
copyright = #""

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
      ragged-bottom = ##t
      last-ragged-bottom = ##t
    }
  }
}


\header {
    title = \realBookTitle
    tagline = ##f
    copyright = \copyright
    }
 
soloShoeShine = \relative c'' {
    % A
    \mark \markup{\small \with-color #red "0:44"}
    a8 d r8 a8 d4 b
    d4 bes d bes
    \mark \markup{\small \with-color #red "0:46"}
    a8 d r8 a8 d4 fis8 e
    d8 b g e  fis e fis4
    % \break

    \mark \markup{\small \with-color #red "0:48"}
    d8 e fis a cis4 r8 b
    a8 fis e d fis d fis d

    \mark \markup{\small \with-color #red "0:50"}
    d4 d8 e fis4. r8
    d2 r2

    % A
    \mark \markup{\small \with-color #red "0:52"}
    \override Glissando.style = #'zigzag
    a'4 \glissando a'8 fis8~ fis2
    r4 b,4 \glissando b'4 r8 fis 8
    \mark \markup{\small \with-color #red "0:54"}
    e8 d b cis d e fis e
    d8 b g e   fis a fis e

    \mark \markup{\small \with-color #red "0:56"}
    d8 e fis a cis b a fis
    d8 b cis dis fis4 r4
    \mark \markup{\small \with-color #red "0:58"}
    s1 * 2

    % B
    \mark \markup{\small \with-color #red "1:00"}
    s1 * 2
    \mark \markup{\small \with-color #red "1:02"}
    s1 * 2

    \mark \markup{\small \with-color #red "1:04"}
    s1 * 2
    \mark \markup{\small \with-color #red "1:06"}
    s1 * 2

    % A
    \mark \markup{\small \with-color #red "1:08"}
    s1 * 2
    \mark \markup{\small \with-color #red "1:10"}
    s1 * 2

    \mark \markup{\small \with-color #red "1:12"}
    s1 * 2
    \mark \markup{\small \with-color #red "1:14"}
    s1 * 2
}

scoreShoeShine = \score {
  <<
  \new ChordNames { \transpose bes d \chordsRhythm }
  {
    % \tempo 4=150
    \global
    % \numericTimeSignature
    % \override Score.MultiMeasureRest.expand-limit = 1
    % \compressFullBarRests
    % \inlineMMR R1*4
    
    % \bar ".|"
    \soloShoeShine
  }
  >>
}

\scoreShoeShine