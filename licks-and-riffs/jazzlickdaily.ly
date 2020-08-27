\version "2.20.0"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished
\include "jazzchords.ily"
% \include "lilyjazz.ily"
\include "roman_numeral_analysis_tool.ily"

\header {
  title = "Jazz Lick Daily"
  copyright = "lesson 2020-08-26"
  tagline = # #f
}

% #(set-global-staff-size 20)

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
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  indent = 0\cm
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " 
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

\layout {
  \context { 
    \Lyrics \override LyricText.font-name = #"serif"
  }
}



lxi_chords = \chords { 
    ges2:maj7 ees:7 aes:min7 des:7.9- ges1:maj7
  }
lxi_notes = \new Staff \relative c' {
    f8 aes ges f ees b' g ees
    bes'8 ges ees ces a' f d b
    bes8 des ees4-. ges r4
  }
lxi_analysis = \new Lyrics \lyricmode {
  \markup \rN { I 7 }2
  \markup \rN { VI 7 }
  \markup \rN { ii - 7 }
  \markup \rN { V 7f9 }
  \markup \rN { I 7 }
}
\score {
  \transpose ges g <<
    \lxi_analysis
    \lxi_chords
    \lxi_notes
  >>
  \header { piece="dailyjazzphrase #61 - turnaround - Chet Baker" }
}