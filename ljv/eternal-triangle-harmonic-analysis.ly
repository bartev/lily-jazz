\version "2.24.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

title = "The Eternal Triangle"
composer = "E-flat transcription"
arranger = ""
tagline = ""
meter = "240"
copyright = "Sonny Rollins solo - Transcribed by Jazz Music Lab"

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
      ragged-bottom = ##f
      last-ragged-bottom = ##t
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
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##t

  %% markup-system-spacing = #'((basic-distance . 23)
%%                            (minimum-distance . 8)
%%                            (padding . 1))
  oddHeaderMarkup = \markup
  \fill-line {
    \title
    %% \fromproperty #'header:title " "
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
    \fromproperty #'page:page-number-string " "
    %% \fromproperty #'header:title
    \title
  }
}

\layout {
  \context {
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  %% http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
  \key g \major
  %% %% beam across 4 eighth notes
  %% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}


eternal_triangle_chord_names = \chordmode {
  %% A
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  b2:min e:7
  a2:min d:7

  %% A (modified)
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  a2:min d:7
  g1

  %% B
  gis1:min
  cis1:7
  g1:min
  c1:7

  fis2:min b:7
  f2:min bes:7
  e2:min a:7
  dis2:min gis:7

  %% A (modified again)
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  a2:min d:7
  g2 d:7
  
}

empty_bars = {
  \repeat unfold 4 {
    \repeat unfold 16 \rs \break
    \repeat unfold 16 \rs \bar "||" \break
  }
}


chordAnalysis = \new Lyrics \lyricmode {
  %% A (1st time)
  \markup \rN { I }2
  \markup \rN { VI 7 }2

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \markup \rN { iii - 7 }2
  \markup \rN { VI 7 }2 

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
  \markup \rN { ii - 7 / IV }2
  \markup \rN { V 7 / IV }2

  \markup \rN { I / IV }2
  \markup \rN { IV 7 / IV }2

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
  \markup \rN { iii - 7 }2
  \markup \rN { VI 7 }2 

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  %% A (2nd time)
  \markup \rN { I }2
  \markup \rN { VI 7 }2

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \markup \rN { iii - 7 }2
  \markup \rN { VI 7 }2 

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
  \markup \rN { ii - 7 / IV }2
  \markup \rN { V 7 / IV }2

  \markup \rN { I / IV }2
  \markup \rN { IV 7 / IV }2

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2

  \markup \rN { I }1 

  %% B
  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { VII }
  \markup \rN { ii - 7 / VII }1
  \markup \rN { V 7 / VII }1
  
  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { fVII }
  \markup \rN { ii - 7 / fVII }1
  \markup \rN { V 7 / fVII }1

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { VI }
  \markup \rN { ii - 7 / VI }2
  \markup \rN { V 7 / VI }2
  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { fVI }
  \markup \rN { ii - 7 / fVI }2
  \markup \rN { V 7 / fVI }2

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { V }
  \markup \rN { ii - 7 / V }2
  \markup \rN { V 7 / V }2
  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { fV }
  \markup \rN { ii - 7 / fV }2
  \markup \rN { V 7 / fV }2

  %% A (3rd time)
  \markup \rN { I }2
  \markup \rN { VI 7 }2

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \markup \rN { iii - 7 }2
  \markup \rN { VI 7 }2 

  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
  \markup \rN { ii - 7 / IV }2
  \markup \rN { V 7 / IV }2

  \markup \rN { I / IV }2
  \markup \rN { IV 7 / IV }2

  \set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2 

  \markup \rN { I }2
  \markup \rN { V 7 }2 
}




\score {
  <<
    \chordAnalysis
    \new ChordNames { \eternal_triangle_chord_names }
    \new Staff {
      \global
      \empty_bars
    }
    >>
}

