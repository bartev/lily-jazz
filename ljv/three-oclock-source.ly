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
  d1:6 d1:7.5+ \repeat unfold 2 { g1:6 }
  g2:maj7 g2:7 gis1:dim d1:7 fis2:m7 b:7
  e1:m7 a1:7.9- d1:6 d1:6
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

ysHead = \relative c' {
  % Head
  \bar ".|"
  \set Score.currentBarNumber = #1
  d4 r4 r4 c8 d~
  d2 fis4 a
  e'2. ees8 d~
  d4 r4 r2
  \break

  c8 d8-- r4 r4 b8 a~
  a2 r4 c,8 cis~
  cis2 r2
  r2 r4 a'8 e~
  \break

  e4 r4 r4 dis8 e~
  e2 g4 b
  fis'8 fis4.~ fis4 f8 e~
  e4 r4 r2
  \break

  r4 r8 d8 cis4  e
  d8 d4.~ d4 b8 a
  r8 a8~ a4 r4 a8 b
  d8 c~ c4 a8 g~ g4
  \bar "||"
  \break

  % 2nd 16
  d4 r4 r4 cis8 d~
  d4. r8 fis4 a
  e'2. ees8 d~
  d2 r2
  \break

  r4 r8 d8 cis4 d
  e4 d ais4. b8~
  b4 r8 fis16 a gis8 b,~ b4
  r1
  \break

  b'4. ais8 b4 cis8 d~
  d2~ \tuplet 3/2 { d4 cis b }
  d8 d4.~ d4 a8 fis~
  fis2 r8 g r8 a8
  \break

  \override Glissando.style = #'zigzag
  fis'8 fis4.~ fis2 \glissando
  cis1
  fis2 d2
  e2 a,2
  \break
  \bar "|."
  \pageBreak

  % Solo - chorus 1
  \bar ".|"
  d8 d d d d d r4
  d4 r8 d8 \tuplet 3/2 { cis4 b cis }
  d8 a r8 a8 a2
  r2 r4 r8 a8
  \break

  d8 e fis g a fis g( a16 g
  fis8 ) d b g gis f' e d
  \tuplet 3/2 { cis16 d cis } b8 a aes g b, d fis
  r8 e4. r4 e8 fis
  \break

  \tuplet 3/2 { g8 a fis } \tuplet 3/2 { g8 e4 } e4 r4  
  r8 a8 r8 b8 cis d b cis
  a8 a r4 r4 e'8 fis
  g8 b, d fis e d cis b
  \break

  \grace { cis16 } d4 b8 g fis e~ e4
  d'4 bes8 a g a bes d
  cis8 a b cis a fis~ fis4
  r4 e16 g b d a'8 fis~ fis4
  \bar "||"
  \break

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
      \new ChordNames { s1*4 }

      \repeat unfold 2 \ysChords
    }

    {
      \tempo "Swing" 4 = 146

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

