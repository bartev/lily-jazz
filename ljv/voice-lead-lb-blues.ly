\version "2.20.0"

% Voice leading exercise over Pfrancing (LB Blues)

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 23)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = #"Voice leading exercise, Pfrancing (LB Blues)"
composer = #""
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
    }
  }
}

global = {
  \numericTimeSignature
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
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
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

theChords = \chordmode {
  d1:7 g1:7 d1:7 a2:m7 d:7
  \break
  g1:7 gis:dim d:7 fis2:dim b:7.9
  \break
  e1:m7 a:7 d2:7 b:7 e:m7 a:7
  \break
}


theNotes_i = \relative c'' {
  d8 fis d a fis a c a
  b8 d f e d e g f?
  fis?8 r fis c' a fis e d
  c8 b a c b a g fis
  \break

  f8 g a b d c a g 
  gis8 b d f gis d b gis?
  a8 fis d c d e g e
  fis8 a c a b c a fis
  \break
  
  g8 e'4. \tuplet 3/2 { d8 b g } d8 b
  cis8 a'4. \tuplet 3/2 { g8 fis e } g e
  fis8 a c a b a gis fis
  g8 e d b cis e g e
  \break

  fis8 fis r4 r4 fis'8 e
  f8 e f e d c cis b
  c8 b c b a g gis fis
  g8 b e, g fis a c bes
  \break

  b8 d f a g f e cis
  d8 f d b gis b d b
  c8 b a g d fis a b
  c8 a e d dis fis a fis
  \break

  g8 b fis b e, b' d, b
  cis? e g b a fis d e
  fis g e d dis e fis dis
  e g d' b cis e g e
}

version_i = \score {
  <<
    \new ChordNames \repeat unfold 2 { \theChords }
    \new Staff {
      \global
      \theNotes_i
    }
  >>
}