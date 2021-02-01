\version "2.20.0"


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

global = {
  \time 4/4
  \key a \major
                                % \tempo 4=224

                                % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

                                % make only the first time signature visible
                                % \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

                                % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
  
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
  \override LyricText #'font-name = #"serif"
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
    \mark \markup{\small \with-color #red "0:44"}
    s1 * 4
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
      \bar ".|"
      \numericTimeSignature
      \myChords
    }
  >>
}

myFullScore = \score {
  <<
    \new Lyrics { \myChordAnalysis}
    \new ChordNames \repeat unfold 2 { \myChords }
    {
                                % \tempo 4=150
      \global
                                % \numericTimeSignature
                                % \override Score.MultiMeasureRest.expand-limit = 1
                                % \compressFullBarRests
                                % \inlineMMR R1*4

                                % \bar ".|"
      \mySolo 
    }
    \new Lyrics { \myScaleDegrees }
  >>
}

\myChordAnalysisArpeg
\myFullScore
