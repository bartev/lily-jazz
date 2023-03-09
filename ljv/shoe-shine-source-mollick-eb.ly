\version "2.24.0"

% Rhythm changes

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\include "rhythm-changes-source-alt.ly"

title = #"Shoe Shine Boy"
composer = #"Lester Young"
arranger = "Trans by Bartev (corr. Mollick)"
meter = "250"
copyright = #"Bartev 2020-11"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {4} #1 " = " #meter }
          \fontsize #1 \lower #1 \concat { #arranger " " }
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
      ragged-last-bottom = ##t
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
    % 1
    \mark \markup{\small \with-color #red "0:44"}
    a8 d r8 a8 d4 b
    d4 bes d bes
    \mark \markup{\small \with-color #red "0:46"}
    a8 d r8 a8 d4 fis8 e
    d8 b g e  fis4. d8
    % \break

    % 5
    \mark \markup{\small \with-color #red "0:48"}
    b8 d fis a cis4 r8 b
    a8 fis dis b g' dis? g d

    \mark \markup{\small \with-color #red "0:50"}
    b8 cis d e fis4 b,8 d8~
    d2 r2

    % A
    % 9
    \mark \markup{\small \with-color #red "0:52"}
    \override Glissando.style = #'zigzag
    a'4 \glissando a'8 fis8~ fis2
    r4 b,4 \glissando b'4 r8 fis 8
    \mark \markup{\small \with-color #red "0:54"}
    e8 d b cis d e fis e
    d8 b g e   fis a fis e

    % 13
    \mark \markup{\small \with-color #red "0:56"}
    b8 d fis a cis b a fis
    d8 b cis dis fis4 r4
    \mark \markup{\small \with-color #red "0:58"}
    a8 d r8 a8 d4 bes
    a8 r \mark \markup{\with-color #red "add scoop"} fis'4~ fis r4

    % B
    % 17
    \mark \markup{\small \with-color #red "1:00"}
    fis,2 r4 fis8 ais
    cis8 e16 ees \tuplet 3/2 {d8 e d} cis4 fis,~

    \mark \markup{\small \with-color #red "1:02"}
    fis4 r4 b8 cis d e16 d
    cis8 b fis d b4 gis'~

    % 21
    \mark \markup{\small \with-color #red "1:04"}
    gis4 r b8 cis \tuplet 3/2 {d8 e d}
    b8 gis d fis r4 gis4~

    \mark \markup{\small \with-color #red "1:06"}
    gis4 r4 a8 cis e a
    fis8 d b g e b d fis

    % A
    % 25
    \mark \markup{\small \with-color #red "1:08"}
    a8 fis a fis a4. fis8
    a8 fis a fis a4. fis8

    \mark \markup{\small \with-color #red "1:10"}
    a8 fis a fis a fis a fis
    a4 a a4. f!8

    % 29
    \mark \markup{\small \with-color #red "1:12"}
    fis8 a b d~ d4 r4
    cis8 a fis d b'4 b8 cis

    \mark \markup{\small \with-color #red "1:14"}
    \tuplet 3/2 {d8 e d} b8 gis e b d fis
    a4 r4 r2
}

ssbScaleDegrees = \lyrics {
\markup \rN {5}8 \markup \rN {1} "" \markup \rN {5}8 \markup \rN {1}4 \markup \rN {6}4
\markup \rN {f7}4 \markup \rN {f5} \markup \rN {4} \markup \rN {2}
\markup \rN {f3}8 \markup \rN {f6} "" \markup \rN {f3} \markup \rN {f3}4 \markup \rN {5}8 \markup \rN {4}8
\markup \rN {f7}8 \markup \rN {5} \markup \rN {f3} \markup \rN {1} \markup \rN {6} \markup \rN {5} \markup \rN {6}4
}
scoreShoeShine = \score {
  <<
  \new Lyrics { \analysisA \analysisA \analysisB \analysisA }
  \new ChordNames { \transpose bes d \chordsRhythm }
  {
    % \tempo 4=150
    \global
    % \numericTimeSignature
    % \override Score.MultiMeasureRest.expand-limit = 1
    % \compressEmptyMeasures
    % \inlineMMR R1*4

    % \bar ".|-|"
    \soloShoeShine
  }
  \new Lyrics { \ssbScaleDegrees }
  >>
}

\scoreShoeShine
