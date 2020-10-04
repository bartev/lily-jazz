\version "2.20.0"

% all the source for Three O'Clock in the Morning
% Dexter Gordon

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = #"Three O'Clock in the Morning"
composer = #"Dexter Gordon"
meter = "146"
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
    }
  }
}

global = {
  \time 4/4
  \key d \major
  % \tempo 4=146

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  % \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
}

\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm
  between-system-space = 2.\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
  % oddHeaderMarkup = "Three O'Clock in the Morning"
  % evenHeaderMarkup = "Three O'Clock in the Morning"
  oddHeaderMarkup = \markup
    \fill-line {
      \title
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string " "
      \title
    }
}

% \chords { … } is a shortcut notation for \new ChordNames \chordmode { … }.
% http://lilypond.org/doc/v2.19/Documentation/notation/displaying-chords

ysChords = \chordmode {
  % \mark #1
  \repeat unfold 4 { d1:6 }
  d1:6 fis2:m7 b:7 e1:m7 a1:7
  \repeat unfold 2 { e1:m7 a1:7 }
  fis1:m7 b1:7 e1:m7 a1:7

  \repeat unfold 4 { d1:6 }
  d1:6 d1:7+ \repeat unfold 2 { g1:6 }
  g2:maj7 g2:7 gis1:dim d1:7
  fis2:m7 b:7 e1:m7 a1:7.9 d1:6
}

% #(define-markup-command (rN2 layout props symbols) (markup-list?) (rN symbols))

analysis = \lyricmode {
  \override LyricText #'font-name = #"serif"
  \set stanza = \markup \keyIndication { A }
  \markup \rN { I 6 }1
  \markup \rN { iv - 7 }2
  \markup \rN { flatVII 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatVII 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { iii - }2
  \markup \rN { VI 7 }2
  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2

  \set stanza = \markup \keyIndication { A }
  \markup \rN { I }1
  \markup \rN { iv - 7 }2
  \markup \rN { flatVII 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatVII 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { I 7 }
  \markup \rN { I }2
  \markup \rN { flatI 7+9 }2

  \set stanza = \markup \keyIndication { C-sharp }
  \markup \rN { I - }1
  \markup \rN { ii h }2
  \markup \rN { V 7+9 }2
  \markup \rN { I - }1
  \markup \rN { IV 7 }1
  \markup \rN { vii - 7 }1
  \markup \rN { I h }2
  \markup \rN { IV 7 }2
  \markup \rN { VII 7 }1
  \markup \rN { VII 7 }2
  \markup \rN { fVII 7 }2

  \set stanza = \markup \keyIndication { A }
  \markup \rN { I }1
  \markup \rN { iv - 7 }2
  \markup \rN { flatVII 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatVII 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { iii - 7 }2
  \markup \rN { VI 7 }2
  \markup \rN { ii - 7 }2
  \markup \rN { V 7 }2

}

ysArpeg = \relative c'' {
  % \mark \default
  \bar ".|"
  a8 cis e fis~ fis2
  d,8 f a c    g8 b d f
  a,8 cis e g  g,8 b d f
  fis,8 ais cis e~ e2
  \break

  b8 dis fis a~ a2
  e,8 gis b d~ d2
  cis8 e gis b  fis,8 ais cis! e
  b8 dis fis a  e8 gis b d
  \bar "||"
  \break

  % \mark #1
  a,8 cis e fis~ fis2
  d8 f a c    g,8 b d f
  a,8 cis e g  g,8 b d f
  fis,8 ais cis e~ e2
  \break

  b8 dis fis a~ a2
  e,8 gis b d~ d2
  a8 cis e fis~ fis2
  a,8 cis e gis  aes,8 c ees g
  \bar "||"
  % \pageBreak
  \break

  % \mark \default
  cis,8 e gis b~ b2
  dis,8 fis a cis  gis,8 bis dis! fis!
  cis8 e gis b~ b2
  fis,8 ais cis e~ e2
  \break

  b8 d fis a~ a2
  cis,8 e g b   fis,8 ais cis! e
  b8 dis fis a~ a2
  b,8 dis fis a bes,8 d f aes
  \bar "||"
  \break

  % \mark #1
  a,8 cis e fis~ fis2
  d,8 f a c    g8 b d f
  a,8 cis e g  g,8 b d f
  fis,8 ais cis e~ e2
  \break

  b8 dis fis a~ a2
  e,8 gis b d~ d2
  cis8 e gis b  fis,8 ais cis! e
  b8 dis fis a  e,8 gis b d
  \bar "|."
  \break
}

ysHead = \relative c''' {
  % Head
  \bar ".|"
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \bar "||"

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \bar "|."

  % Solo - chorus 1
  \bar ".|"
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \bar "||"

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  \bar "|."

}

ysScaleDegrees = \lyrics {
  \markup \rN { "" }8
  \markup \rN { 1 }4.
  \markup \rN { 5 }4
  \markup \rN { 6 }4
  \markup \rN { 4 }4.
  \markup \rN { f3 }8
  \markup \rN { f7 }

}

% This setup will print the chord analysis on top,
% Then the chords
% 1st chorus is arpeggios
% 2nd chorus is the head
% 3rd chorus is the solo

headAndSolo = \score {
  <<
    % \new Lyrics \repeat unfold 2 { \analysis }

    \new ChordNames {
      % \repeat unfold 4 { s1 }
      \new ChordNames { s1*4 }
      \repeat unfold 2 \ysChords
    }

    {
      \global
      \numericTimeSignature
      \override Score.MultiMeasureRest.expand-limit = 1
      \compressFullBarRests
      \inlineMMR R1*4

      \bar ".|"
      \ysHead
    }
    % \new Lyrics \ysScaleDegrees
  >>
}

