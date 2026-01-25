\version "2.24.2"

%% SCHEME FUNCTION VERSION: Phrases from "Lester Leaps In" transposed to all 12 keys
%% Uses a Scheme function to generate scores for each key
%% This version works reliably without complex Scheme embedding

#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "bv_definitions.ily"

title = #"Lester Leaps In - Phrases in All Keys"
composer = #"Lester Young"
tagline = "Bartev - Phrase Study"

\header {
  title = \markup \fontsize #5 #title
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

  system-system-spacing = #'((basic-distance . 15)
                             (minimum-distance . 8)
                             (padding . 1))
}

\layout {
  indent = 0\mm
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
}

%%%%%%%%%%%%%%%%%%%% Define the original phrase (in Bb)

originalChords = \chordmode {
  bes2:6 g:m7 | c:m7 f:7 |
}

originalMelody = \relative c' {
  d4 f bes d | c bes g f |
  \bar "||"
}

%%%%%%%%%%%%%%%%%%%% Scheme function to create a transposed score
%% This function avoids complex Scheme/LilyPond embedding issues

makeTransposedPhrase =
#(define-music-function
   (keyLabel fromPitch toPitch keySig)
   (string? ly:pitch? ly:pitch? ly:music?)
   #{
     \markup \vspace #1
     \markup \fontsize #2 \bold #keyLabel
     \score {
       <<
         \new ChordNames {
           \transpose #fromPitch #toPitch \originalChords
         }
         \new Staff {
           #keySig
           \transpose #fromPitch #toPitch \originalMelody
         }
       >>
       \layout { indent = 0 }
     }
   #})

%%%%%%%%%%%%%%%%%%%% Generate all 12 keys

\makeTransposedPhrase "Bb" bes bes  { \key bes \major }
\makeTransposedPhrase "B"  bes b    { \key b \major }
\makeTransposedPhrase "C"  bes c    { \key c \major }
\makeTransposedPhrase "Db" bes des  { \key des \major }
\makeTransposedPhrase "D"  bes d    { \key d \major }
\makeTransposedPhrase "Eb" bes ees  { \key ees \major }
\makeTransposedPhrase "E"  bes e    { \key e \major }
\makeTransposedPhrase "F"  bes f    { \key f \major }
\makeTransposedPhrase "Gb" bes ges  { \key ges \major }
\makeTransposedPhrase "G"  bes g    { \key g \major }
\makeTransposedPhrase "Ab" bes aes  { \key aes \major }
\makeTransposedPhrase "A"  bes a    { \key a \major }
