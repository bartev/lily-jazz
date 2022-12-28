\version "2.24.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  indent = 0\mm

  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in

  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##t
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"There Will Never Be Another You"
composer = #"Warren/Gordon"
meter = \markup{ (Up) }
copyright = #"Lee Konitz version"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #7
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


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=210
}

% Eb instr
snippetAltoThirteen = \relative c'' {
  \global
  \key c \major

  \override Score.BarNumber.stencil 
            = #(make-stencil-boxer 0.1 0.25 ly:text-interface::print)
  % \set Score.barNumberVisability = #all-bar-numbers-visible
  \set Score.currentBarNumber = #13

  s1 |
  s2^\markup{ "~ 50 sec" } r8 b8 c cis |
  d8 cis d e   f e f fis |
  g8 fis f e   f fis g r8 |
  \break

  ais2 a8 ais a gis |
  g8 e c a   s2 |
  s1
  s1
}

% Eb instr
snippetAltoThirteenChords = \chordmode {
  d1:7 | a2:min7 d:7 | d1:min7 | g1:7 |
  c1:maj7 | c1:maj7 b1:min7.5- | e1:7.9-
}

% All the chords (for c instruments)
chords_twnbay = \chordmode {
  \partial 4 s4 | 
  ees1:maj7 | ees1:maj7 | d:m7.5- | g:7.9- |
  \break
  c:m7 | c:m7 | bes:m7 | ees:7 | 
  \break
  aes:maj7 | f2:m7.5- bes:7 | ees1:maj7 | c:m7 |
  \break
  f:7 | c2:m7 f:7 | f1:m7 | bes:7 |
  \break
  ees:maj7 | ees:maj7 | d:m7.5- | g:7.9- |
  \break
  c:m7 | c:m7 | bes:m7 | ees:7 | 
  \break
  aes:maj7 | f2:m7.5- bes:7 | ees1:maj7 | g2:m7 c:7 |
  \break
  ees2:maj7 d:7 | g:7 c:7 | f:m7 bes:7 | ees : bes:7 |
}

scoreSnippetAltoThirteen = \score {
  <<
  \new ChordNames \snippetAltoThirteenChords
  \new Staff \with {
    
    instrumentName = "Alto"
    midiInstrument = "alto sax"
  } \snippetAltoThirteen
  >>
}

\scoreSnippetAltoThirteen

scoreLickI = \score {
  <<
  \new ChordNames \chordmode {
    c1:maj7 | c1:maj7 | b1:min7.5- | e1:7.9-
  }
  \new Staff \relative c'' {
    \global
    \key c \major

    \override Score.BarNumber.stencil 
            = #(make-stencil-boxer 0.1 0.25 ly:text-interface::print)
    % \set Score.barNumberVisability = #all-bar-numbers-visible
    \set Score.currentBarNumber = #1

  r8 a c d e dis c4
  r8 c e g a g e4
  r8 d f a c b a g
  gis4 r4 r2
  }
  >> 
}

\scoreLickI

blankStaves = \score {
  {
    \repeat unfold 7 { s1 \break }
  }
  \layout {
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}

\blankStaves

\pageBreak

blankStavesTen = \score {
  {
    \repeat unfold 11 { s1 \break }
  }
  \layout {
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}

\blankStavesTen