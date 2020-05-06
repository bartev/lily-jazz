\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"


title = #"Sugar - w/ solo"
composer = #"Stanley Turrentine"
meter = \markup{ (Swing) }
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
  copyright = \copyright
  %   title = "Sugar"
  %   composer = "Stanley Turrentine"
  %   meter = "Swing"
  %   copyright = "Stanley turrentine - “The Baddest Turrentine”"
  % Remove default LilyPond tagline
  tagline = ##f
}

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))

}

global = {
  \numericTimeSignature
  \time 4/4
  \key es \major
  \tempo  4=100

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1
}

chords_sugar_partial =\chordmode {  \partial 2. s4 s2 }
head_sugar_partial =  \relative c' { \partial 2. s8 c8 e8 f4 g8~ }

chords_sugar = \chordmode {
  c1:m7 |
  d2:m7.5- g2:7.5+ |
  c1:m7.9 |
  g1:7.5+ |

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
  {
    { aes1:7.11+ | g1:7.5+ }
    { c1:m7.9  |des1:maj7 }
  }
}       

chords_sugar_head = \chordmode {
  c1:m7 |
  d2:m7.5- g2:7.5+ |
  c1:m7.9 |
  g1:7.5+ |

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

  aes1:7.11+ | g1:7.5+

  % c1:m7.9  |des1:maj7

}


notes_sugar = \relative c'' {
  \noBreak

  \bar "[|:"
  \repeat volta 2 {
    g4. f8 \tuplet 3/2 {g16 aes g} f8 ees8 f8~
    \noBreak
    f4. ees8 \tuplet 3/2 {f16 g f} ees8 c8 ees~
    \noBreak
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
    \break
  }
  \alternative {
    { c1~  c4. c8 ees8 f4 g8 \bar ":|]"}
    { c1~ c1 \bar "|." }
    \break
  }
}

notes_sugar_solo = \relative c'' {
  \bar ".|"
  \break \repeat unfold 4 { s1 }
  \break \repeat unfold 4 { s1 }
  \break \repeat unfold 4 { s1 }
  \break \repeat unfold 4 { s1 }
  \bar "|."
}

right = {
  \global
  % Music follows here.
  \head_sugar_partial
  \notes_sugar
  \notes_sugar_solo
  \notes_sugar_solo
}

left = {
  \global
  % Music follows here
  \new ChordNames {
    %     http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides
    % \override ChordNames.ChordName.extra-offset = #'(0 . 4.5)
    \chords_sugar_partial
    \chords_sugar
    \chords_sugar_head
  }
}


MyTranspose =
#(define-music-function (m)
   (ly:music?)
   #{ \transpose ees, c $m #})
% In the previous line the transposition of the whole score is defined
% (in this case up a 6th from E flat to C).

% \score {
%   <<
%     \MyTranspose { \left }
%     {
%       \MyTranspose { \right }
%       \notes_sugar_solo
%     }
%   >>
% }

% \score {
%   \new GrandStaff  <<
%     \set GrandStaff.systemStartDelimiter = #'SystemStartBar
%     \new Staff = "right" \MyTranspose { \right }
%     \new Staff = "left" { \clef bass \transpose ees, c {  \left } }
%   >>
%   \layout {
%   \context {
%     % http://lilypond.1069038.n5.nabble.com/Fixed-width-measures-td172597.html
%     \Score proportionalNotationDuration = #(ly:make-moment 1/8)
%   }
%   }
% }

\score {
<<
\new ChordNames {
     transpose ees, c { \chords_sugar_head }
     transpose ees, c { \chords_sugar }
     transpose ees, c { \chords_sugar_head }
}
\new Voice \MyTranspose { \right }
>>
}
