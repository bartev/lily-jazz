\version "2.24.4"

%% Phrases from "Lester Leaps In" transposed to all 12 keys
%% 2 bar phrase shown in all keys (4 bars per line: 2 original + 2 transposed)

#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "bv_definitions.ily"

title = #"Phrases - Lester Leaps In"
composer = #"Lester Young"
tagline = "Bartev - Phrase Study - 2026-01"

\header {
  title = \markup \fontsize #3 #title
  composer = \composer
  tagline = \tagline
}

\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in

  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f

  %% Space between 2 music systems (staff to staff)
  system-system-spacing = #'((basic-distance . 12)
                             (minimum-distance . 8)
                             (padding . 1))

  %% Space between markup text and the next music system
  markup-system-spacing = #'((basic-distance . 3)
                             (minimum-distance . 2)
                             (padding . 1))

  %% - score-system-spacing: Space between a score and the next system
  %% - score-markup-spacing: Space between a score and following markup text
  %% - markup-markup-spacing: Space between two consecutive markup blocks
}

\layout {
  indent = 0\mm
  \context {
    \Score
    \numericTimeSignature
    %% \remove "Bar_number_engraver"

    %% \ChordNames
    chordChanges = ##t %% Only show chord when it changes%}
    \consists "Percent_repeat_engraver"
    \override ChordName.font-size = #1 % slightly larger chord symbols
    \override ChordName.font-family = #'sans

  }
  \override Score.SystemStartBar.collapse-height = #-inf.0

  %% Make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% Make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)
}


%%%%%%%%%%%%%%%%%%%% Convenience function for Lester Leaps In phrase
%%
%% This wrapper makes it easy to transpose the Lester Leaps In phrase
%% Just pass keyLabel, fromPitch, toPitch, and optionally keySig
%% Note: transposePhrase is defined in bv_definitions.ily

%% transposePhraseA =
%% #(define-void-function
%%    (fromPitch toPitch keySig)
%%    (ly:pitch? ly:pitch? (ly:music?))
%%    (transposePhrase #f fromPitch toPitch keySig chordsA melodyA))

%%%%%%%%%%%%%%%%%%%% Define Phrase A

%% Define phrase A
chordsA = \chordmode {
  \repeat percent 2 { g1:7 }
}

%% Define original melody (2 bars)
melodyA = \relative c'{
  \bar "||"
  \key c \major
  d8 e f g a f \tuplet 3/2 { g a g }
  e8 f4. \comp 2
  \bar "|"
}

phraseA = \score {
  <<
    \new ChordNames {
      \transpose c c  \chordsA
      \transpose c g   \chordsA
      \transpose c d   \chordsA
      \transpose c a   \chordsA
      %%
      \transpose c e   \chordsA
      \transpose c b   \chordsA
      \transpose c fis \chordsA
      \transpose c, des \chordsA
      %%
      \transpose c aes \chordsA
      \transpose c ees \chordsA
      \transpose c bes \chordsA
      \transpose c f   \chordsA
    }
    \new Staff {
      \transpose c c'   \melodyA
      \transpose c g    \melodyA
      \break
      \transpose c d    \melodyA
      \transpose c a    \melodyA
      \break
      \transpose c e    \melodyA
      \transpose c b    \melodyA
      \break
      \transpose c fis' \melodyA
      \transpose c cis  \melodyA
      \break
      \transpose c aes' \melodyA
      \transpose c ees  \melodyA
      \break
      \transpose c bes  \melodyA
      \transpose c f    \melodyA
      \break
    }
  >>
}

%%%%%%%%%%%%%%%%%%%% Define phrase B

%% Phrase B
chordsB = \chordmode {
  c2:6 a2:m7 d2:m7 g2:7
}

%% Define original melody (2 bars)
melodyB = \relative c''{
  \bar "||"
  \key c \major
  \comp 1 r8 c f-> e c a
  c8 c-^ \comp 3
  \bar "|"
}

phraseB = \score {
  <<
    \new ChordNames {
      \transpose c c   \chordsB
      \transpose c g   \chordsB
      \transpose c d   \chordsB
      \transpose c a   \chordsB
      \transpose c e   \chordsB
      \transpose c b   \chordsB
      \transpose c fis \chordsB
      \transpose c cis \chordsB
      \transpose c aes \chordsB
      \transpose c ees \chordsB
      \transpose c bes \chordsB
      \transpose c f   \chordsB
    }
    \new Staff {
      \transpose c c   \melodyB
      \transpose c g   \melodyB
      \break
      \transpose c d   \melodyB
      \transpose c a   \melodyB
      \break
      \transpose c e   \melodyB
      \transpose c b   \melodyB
      \break
      \transpose c fis \melodyB
      \transpose c cis \melodyB
      \break
      \transpose c aes \melodyB
      \transpose c ees \melodyB
      \break
      \transpose c bes, \melodyB
      \transpose c f   \melodyB
      \break
    }
  >>
}

%%%%%%%%%%%%%%%%%%%% Define phrase C

%% Phrase C
chordsC = \chordmode { e2:m7 a:7 | d2:m7 g:7 | c2:6 c:7 }

melodyC = \relative c''{
  \bar "||"
  \key c \major
  \comp 3 r8 e(
  f8) e( d) c( b) aes->( g f)
  e4-^ \comp 3
  \bar "|"
  \break
}

phraseC = \score {
  <<
    \new ChordNames {
      \transpose c c   \chordsC
      \transpose c g   \chordsC
      \transpose c d   \chordsC
      \transpose c a   \chordsC
      \transpose c e   \chordsC
      \transpose c b   \chordsC
      \transpose c fis \chordsC
      \transpose c cis \chordsC
      \transpose c aes \chordsC
      \transpose c ees \chordsC
      \transpose c bes \chordsC
      \transpose c f   \chordsC
    }
    \new Staff {
      \transpose c c   \melodyC
      \transpose c g   \melodyC
      \break
      \transpose c d   \melodyC
      \transpose c a   \melodyC
      \break
      \transpose c e   \melodyC
      \transpose c b   \melodyC
      \break
      \transpose c fis \melodyC
      \transpose c cis \melodyC
      \break
      \transpose c aes \melodyC
      \transpose c ees \melodyC
      \break
      \transpose c bes, \melodyC
      \transpose c f   \melodyC
      \break
    }
  >>
}

\markup \fontsize #4 "Phrase A - last 2 bars of bridge"
\phraseA

\pageBreak
\markup \fontsize #4 "Phrase B - last 2 measures of A section"
\phraseB

\pageBreak
\markup \fontsize #4 "Phrase C = A section, m3-5"
\phraseC
