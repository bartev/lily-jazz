\version "2.20.0"

% all the source for yardbird suite
% Called by yardbird-suite-arpeggios.ly and yardbird-suite.ly

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = #"Yardbird Suite"
composer = #"Charlie Prker"
meter = "224"
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
  \key a \minor
  % \tempo 4=224

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
}

% \chords { … } is a shortcut notation for \new ChordNames \chordmode { … }.
% http://lilypond.org/doc/v2.19/Documentation/notation/displaying-chords

ysChords = \chordmode {

  \mark #1
  a1:6
  d2:min g2:7 a2:7 g2:7 fis1:7
  \break
  b1:7 e1:7 cis2:min fis2:7 b2:min e2:7
  \break

  \mark #1
  a1:6 d2:min g2:7 a2:7 g2:7 fis1:7
  \break
  b1:7 e1:7 a1:6 a2 aes2:7+9
  \break

  \mark #2
  cis1:min dis2:m7.5- gis2:7 cis1:min fis1:7
  \break
  b1:min cis2:m7.5- fis2:7 b1:7 b2:7 bes2:7
  \break

  \mark #1
  a1:6 d2:min g2:7 a2:7 g2:7 fis1:7
  \break
  b1:7 e1:7 cis2:min fis2:7 b2:min e2:7
  \break

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
  a8 cis e gis~ fis2
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
  a,8 cis e gis~ fis2
  d8 f a c    g,8 b d f
  a,8 cis e g  g,8 b d f
  fis,8 ais cis e~ e2
  \break

  b8 dis fis a~ a2
  e,8 gis b d~ d2
  a8 cis e g~ fis2
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
  a,8 cis e gis~ fis2
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
  % A
  r8 a4.-1 e4-5 fis-6
  g4.-4 f8~-3 f-7 c-4 d-5 e-6~
  e2-5 e4.-6 cis8-4~
  cis4.-5 cis8-5 d-6 cis-5 d-6 e-7
  \break

  cis8-2 a-7 r8 a8-7~ a2-7
  r4 r8 b8-5 r8 cis-6 d-7 e-1~
  e4.-3 fis8~ fis-1 cis-5 d-6 e~-7
  e2~-4 e4-1 r4
  \break

  % A
  r8 a4.-1 e4-5 fis-7
  g4.-4 f8~-3 f-7 c-4 d-5 e-6~
  e2-5 e4.-5 cis8-3~
  cis4.-5 cis8-5 d-6 cis-5 d-6 e-7
  \break

  cis8-2 a-7 r8 a8-7~ a2-7
  r4 r8 a8-4 cis-6 a-4 cis-6 a~-4
  a1-1
  r2 r4 \tuplet 3/2 { e'16-5 fis-6 e-5 } ees8-5
  \break

  % B
  cis4.-1 dis8-2 e-3 cis?4-1 fis8-6
  r8 fis8-3 fis4-3~ fis2-7
  e8-3 fis-4 e-3 dis-2 cis-1 gis-5 a-6 ais~-6
  ais2-3 r4 r8 g8
  \break

  fis4.-5 fis'8-5 r8 cis8-2 d-3 e-4
  r8 e4.-3      d8-6 cis-5 b-4 ais-3
  cis8-2 fis,8-5 r8 cis'8~-2 cis4. fis,8-5
  b8-1 cis-2 d-3 e-4 r2
  \break

  % A
  r8 a4.-1 e4-5 fis-7
  g4.-4 f8~-3 f c-7 d-1 e-2~
  e2-5 e4.-5 cis8-3~
  cis4-5 cis8-5 d-6  r8 c8-5 cis-5 fis-1
  \break

  r8 fis8~-5 fis2.-5
  r8 fis,8-2  \tupletDown \tuplet 3/2 { gis8-3 a-4 b-5 }  cis4-6 e,8-1 a~-4
  a2~-6 a4-3 r4
  r4 r8 c16-6 cis d8-7 g-3 \tuplet 3/2 { f16-2 g-3 f-2 } dis8-7
  \break
  \pageBreak

  % Solo
  % A
  e8-5 cis-3 r4 r8 b'16-2 bes-2 a8-1 e-5
  g8-4 a16-5 g-4 fis8-3 f-3~ f8-7 d-5 c-4 a-2
  \tuplet 3/2 { e'16-5 fis-6 e-5 } d8-4 cis8-3 fis,-6 g-1 b-3 d-5 e-6
  cis8-5 b-4 \tuplet 3/2 { ais8-3 cis?-5 e-7 } g8-9 a16-3 g-2 fis8-1 e-7

  dis8 b \tuplet 3/2 { a16 b a } fis8  cis'2
  r1
  \repeat unfold 2 s1

  \repeat unfold 4 s1
  \repeat unfold 4 s1

  \repeat unfold 4 s1
  \repeat unfold 4 s1
  \repeat unfold 4 s1
  \repeat unfold 4 s1
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
    % \new Lyrics \repeat unfold 3 { \analysis }
    \new Lyrics \repeat unfold 2 { \analysis }
    \new ChordNames {
      % \repeat unfold 3 \ysChords
      \repeat unfold 2 \ysChords
    }
    {
      \global
      \numericTimeSignature
      \ysHead
    }
    % \new Lyrics \ysScaleDegrees
  >>
}


arpeggios = \score {
  <<
    \new Lyrics \analysis
    \new ChordNames \ysChords
    {
      \global
      \numericTimeSignature
      \ysArpeg
    }
  >>
}
