\version "2.18.2"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  indent = 15\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"Sugar-2"
composer = #"Stanley Turrentine"
meter = \markup{ (Up) }
copyright = #"Stanley Turrentine - 'The Baddest Turrentine'"

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

% quest = \mark \markup {\small \with-color #red "questionable"}
% q_three = \mark \markup{\small \with-color #red "???"}

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=120
}

chords_sugar_partial = \partial 2. \chordmode { s4 s2 }
chords_sugar = \chordmode {
  \repeat volta 2 {
  c1:m7
  d2:m7.5- g2:7.5+
  c1:m7.9

  g1:7.5+
  c1:m7
  c1:m7
  d1:m7.9  

  g1:7.5+
  c1:m7
  c1:m7
  f1:m7.9  

  ees1:7.13
  d1:m7.5-
  g1:7.5+
  aes1:7.11+

  g1:7.5+
  }
  \alternative 
  { aes1:7.11+ g1:7.5+ }
  { c1:m7.9 des1:maj7 }
}

head_sugar_partial =  \relative c' {
  \partial 2.
  r8 c8 e8 f4 g8~
}

head_sugar = \relative c'' {
  \repeat volta 2 {
  g4. f8 \tuplet 3/2 {g16 aes g} f8 ees8 f8~
  f4. ees8 \tuplet 3/2 {f16 g f} ees8 c8 ees~
  ees1~
  \break

  ees4. c8 ees8 f4 g8~
  g4. f8 \tuplet 3/2 {g16 aes g} f8 ees f~
  f4. g8 \tuplet 3/2 {bes16 c bes} g8 f g~
  g1~
  \break

  g4. g8 bes8 c4 ees8~
  ees4. c8 \tuplet 3/2 {ees16 f ees} c8 bes c~
  c4. bes8 \tuplet 3/2 {c16 d c} bes8 g bes~
  bes4. g8 \tuplet 3/2 {bes16 c bes} g8 f g~
  \break

  g4. f8 \tuplet 3/2 {g16 aes g} f8 ees f~
  f4. ees8 \tuplet 3/2 {f16 g f} ees8 c ees~
  ees4. c8 \tuplet 3/2 {ees16 f ees} c8 bes c
  }
  \alternative
    {
      c1~ 
      c4. c8 ees8 f4 g8~
    }
    {
      c1~ c1
    }
}

\score {
  << 
    \new ChordNames {
    \chords_sugar_partial 
    \chords_sugar
    }
    \new PianoStaff {
    <<
      \context Staff {
      \global
      \key ees \major
      \head_sugar_partial 
      \head_sugar
    }
      \context Staff {
      \clef bass 
      \global
      \key ees major
      }
    >>
    }
  >>
}
