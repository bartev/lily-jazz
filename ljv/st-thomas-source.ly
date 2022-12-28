\version "2.24.0"


                                % set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\include "rhythm-changes-source.ly"

                                % set up title, compser, meter, copyright
title = #"St. Thomas"
composer = #"Sonny Rollins"
meter = "fast"
copyright = #"Bartev 2021-02"


realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {4} #1 " = " #meter }
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

global = {
  \time 4/4
  \key a \major
                                % \tempo 4=224

                                % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

                                % make only the first time signature visible
                                % \override Score.KeySignature.break-visibility = #'#(#f #f #f)

                                % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

}

                                % AABA
myChords = \chordmode {
                                % \mark "A"
                                % bes2:6 g:min7
  a1:6 cis2:m7 fis2:7 b2:m7 e2:7 a1:6 \break
  a1:6 cis2:m7 fis2:7 b2:m7 e2:7 a1:6 \break
                                % cis2:m7.5  g2:7 fis1:7.9 b1:m7 e1:7 \break
  cis1:m7.5- fis1:7.9- b1:m7 e1:7 \break
  a2:maj7 a2:7 d2:maj7 dis2:dim7 e2:sus7 e2:7 a1:6 \break
}

myChordAnalysis = \lyricmode {
  \override LyricText.font-name = #"serif"
  \set stanza = \markup \keyIndication { I }

                                % \markup \rN { I 6 }2 \markup \rN { vi - 7 }2
  \markup \rN { I 6 }1
  \markup \rN { iii-7 }2   \markup \rN { VI7 }2
  \markup \rN { ii-7 }2    \markup \rN { V7 }2
  \markup \rN { I 6 }1

  \markup \rN { I 6 }1
  \markup \rN { iii-7 }2   \markup \rN { VI7 }2
  \markup \rN { ii-7 }2    \markup \rN { V7 }2
  \markup \rN { I 6 }1


  \markup \rN { iii-7(flat5) }1
  \markup \rN { VI7(flat9) }1
  \markup \rN { ii-7 }1
  \markup \rN { V7 }1


  \markup \rN { I maj7 }2 \markup \rN { I7 }2
  \markup \rN { IV maj7 }2   \markup \rN { sharpIV 7(dim) }2
  \markup \rN { V7sus }2    \markup \rN { V7 }2
  \markup \rN { I 6 }1

}

mySolo = \relative c'' {
                                % A
                                % 1
  \mark \markup{\small \with-color #red "1st Chorus - 0:56"}
  r4 r8 e8 a, r8 r4
  r4 r8 e'8 ais,8 r8 r4
  r8 e'8 b e r2
  r8 e8 b e a, e' b e

  \mark \markup{\small \with-color #red "1:00"}
  a,4 r4 r8 e'8 b4
  r8 e8 cis r8 r8 e8 ais,8 r8
  r8 e'8 a,8 r8 r8 e'8 b e
  a,8 r8 r8 e'8 b e b e

  \mark \markup{\small \with-color #red "1:04"}
  a,8 r8 r4 r8 e'8 cis e
  gis8 b d ais cis g e f
  fis?8 d b e cis d fis a
  cis?8 d, fis a c g f ees

  \mark \markup{\small \with-color #red "1:09"}
  e8 a, a r8 r8 cis' cis, r8
  r8 e8 d r8 r8 fis dis r8
  r4 r8 e8 r4 r8 e8
  r4 r8 e8 r8 e b e

  \pageBreak

  \mark \markup{\small \with-color #red "2nd Chorus - 1:14"}
  a,8 r8 r8 e' a, r r e'
  a,8 r r e' ais, r r4
  r8 e'8 a, r r e' ais, e'
  a,8 r r e' d r r fis

  \mark \markup{\small \with-color #red "1:19"}
  e8 a, r4 r8 gis?8 ais d
  b8 bis cis16 d cis b ais8 g fis e
  cis8 d fis a cis e, gis? b
  a8 e cis8 fis8~ fis8 r8 r4

  \mark \markup{\small \with-color #red "1:23"}
  r4 r8 e gis b d b
  cis8 b \tuplet 3/2 {ais8 cis e} a8 g \tuplet 3/2 {dis8 e f}
  fis8 d cis b fis'16 g fis e d8 cis
  b8 a gis b d fis e d

  \mark \markup{\small \with-color #red "1:28"}
  cis8 e, g e b' a g! f
  fis8 a b cis e d cis b
  a'8^\markup {\with-color #red "up 8va to hit final note"} fis e d cis e b e
  a,4 r4 r8 e8 gis a

  \mark \markup{\small \with-color #red "3rd Chorus - 1.32"}
  d8 cis a e gis a r4
  r4 r8 gis'8~ gis4~ gis8 fis8
  e8 a, r4 r2
  \override Glissando.style = #'zigzag
  r4 r8 a16 \glissando e' dis4 e4~

  \mark \markup{\small \with-color #red "1:37"}
  e8 r8 r8 dis8~ dis4. e8~
  e8 r8 r4 r8 a,8 e'4
  fis2 e4 d8 cis~
  cis8 r8 r4 r2

  \mark \markup{\small \with-color #red "1:41"}
  r4 gis'4 cis, cis'~
  cis8 b8~ b8 ais8~ ais8 r8 r4
  r1
  b4 a8 fis gis fis e d

  \mark \markup{\small \with-color #red "1:46"}
  cis8 e b bes a gis g f
  fis8 d cis b f' ees e d
  cis8 e fis a b gis a a
  gis a cis e gis fis e gis,


  \mark \markup{\small \with-color #red "1:50"}
  a8 d cis s8 s2
  s1 * 3

  s1 * 4
  s1 * 4
  s1 * 4
  
}

myScaleDegrees = \lyrics {
                                % example
                                % \markup \rN {5}8
                                % \markup \rN {scale-tone}duration
}

myChordAnalysisArpeg = {
  <<
    \new Lyrics \myChordAnalysis
    \new ChordNames {
                                % \set chordChanges = ##t
      \myChords
    }
    \new Staff {
      \global
      \bar ".|-|"
      \numericTimeSignature
      \myChords
    }
  >>
}

myFullScore = \score {
  <<
    \new Lyrics { \myChordAnalysis}
    \new ChordNames \repeat unfold 4 { \myChords }
    {
                                % \tempo 4=150
      \global
                                % \numericTimeSignature
                                % \override Score.MultiMeasureRest.expand-limit = 1
                                % \compressEmptyMeasures
                                % \inlineMMR R1*4

                                % \bar ".|-|"
      \mySolo
    }
    \new Lyrics { \myScaleDegrees }
  >>
}

\myChordAnalysisArpeg
\myFullScore
