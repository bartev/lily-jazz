\version "2.24.4"

%% COMPACT VERSION: Phrases from "Lester Leaps In" transposed to all 12 keys
%% This version uses a more compact layout with multiple phrases per system

#(set-global-staff-size 16)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "bv_definitions.ily"

title = #"Example Phrases (Compact)"
composer = #"Rando"
tagline = "Bartev - Phrase Study"

\header {
  title = \markup \fontsize #4 #title
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
  }
  \override Score.SystemStartBar.collapse-height = #-inf.0
}


%%%%%%%%%%%%%%%%%%%% Define the original phrase (in Bb)

%% Define original chords (2 bars)
originalChords = \chordmode {
  bes2:6 g:m7 | c:m7 f:7 |
}

%% Define original melody (2 bars)
originalMelody = \relative c' {
  d4 f bes d | c bes g f |
  \bar "||"
}

%%%%%%%%%%%%%%%%%%%% Create all 12 keys in one score block

\score {
  \new StaffGroup <<
    \new ChordNames {
      \override ChordName.font-size = #-1
      \set chordChanges = ##t

      %% All 12 keys concatenated
      \originalChords                           % Bb
      \transpose bes b \originalChords          % B
      \break

      \transpose bes c \originalChords          % C
      \transpose bes des \originalChords        % Db
      \break

      \transpose bes d \originalChords          % D
      \transpose bes ees \originalChords        % Eb
      \break

      \transpose bes e \originalChords          % E
      \transpose bes f \originalChords          % F
      \break

      \transpose bes ges \originalChords        % Gb
      \transpose bes g \originalChords          % G
      \break

      \transpose bes aes \originalChords        % Ab
      \transpose bes a \originalChords          % A
    }

    \new Staff {
      \override Score.Clef.break-visibility = #'#(#f #f #f)
      \override Score.KeySignature.break-visibility = #'#(#f #f #f)

      %% Bb
      \mark "Bb"
      %% \key bes \major
      \transpose bes bes \originalMelody

      %% B
      \mark "B"
      %% \key b \major
      \transpose bes b \originalMelody

      %% C
      \mark "C"
      %% \key c \major
      \transpose bes c' \originalMelody

      %% C#
      \mark "C#"
      %% \key cis \major
      \transpose bes cis' \originalMelody

      %% D
      \mark "D"
      %% \key d \major
      \transpose bes d' \originalMelody

      %% Eb
      \mark "Eb"
      %% \key ees \major
      \transpose bes ees' \originalMelody

      %% E
      \mark "E"
      %% \key e \major
      \transpose bes e' \originalMelody

      %% F
      \mark "F"
      %% \key f \major
      \transpose bes f' \originalMelody

      %% F#
      \mark "F#"
      %% \key fis \major
      \transpose bes fis' \originalMelody

      %% G
      \mark "G"
      %% \key g \major
      \transpose bes g' \originalMelody

      %% Ab
      \mark "Ab"
      %% \key aes \major
      \transpose bes aes' \originalMelody

      %% A
      \mark "A"
      %% \key a \major
      \transpose bes a \originalMelody
    }
  >>

  \layout {
    indent = 0
    \context {
      \Score
      \override RehearsalMark.self-alignment-X = #LEFT
      \override RehearsalMark.font-size = #0
      \override RehearsalMark.padding = #2
    }
  }
}
