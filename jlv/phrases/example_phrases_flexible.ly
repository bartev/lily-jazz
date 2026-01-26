\version "2.24.2"

%% FLEXIBLE SCHEME FUNCTION VERSION: Transpose phrases with optional labels and key signatures
%% Supports markup for flats/sharps, optional labels, and customizable chords/melody

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

  %% Space between 2 music systems (staff to staff)
  system-system-spacing = #'((basic-distance . 12)
                             (minimum-distance . 8)
                             (padding . 1))

  %% Space between markup text and teh next music system
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

    \omit "TimeSignature"
  }
}

%%%%%%%%%%%%%%%%%%%% Define the original phrase (in Bb)

lesterLeapsInChords = \chordmode {
  bes2:6 g:m7 | c:m7 f:7 |
}

lesterLeapsInMelody = \relative c' {
  d4 f bes d | c bes g f |
  \bar "||"
}

%%%%%%%%%%%%%%%%%%%% Convenience function for Lester Leaps In phrase
%%
%% This wrapper makes it easy to transpose the Lester Leaps In phrase
%% Just pass keyLabel, fromPitch, toPitch, and optionally keySig
%% Note: transposePhrase is defined in bv_definitions.ily

lesterLeapsInPhrase =
#(define-void-function
   (keyLabel fromPitch toPitch keySig)
   ((scheme?) ly:pitch? ly:pitch? (ly:music?))
   (transposePhrase keyLabel fromPitch toPitch keySig lesterLeapsInChords lesterLeapsInMelody))


lesterLeapsInPhraseTwo =
#(define-void-function
   (fromPitch toPitch keySig)
   (ly:pitch? ly:pitch? (ly:music?))
   (transposePhrase #f fromPitch toPitch keySig lesterLeapsInChords lesterLeapsInMelody))

%%%%%%%%%%%%%%%%%%%% Generate all 12 keys with various label styles

\markup \fontsize #3 "Using plain strings"
\lesterLeapsInPhrase "Bb" bes bes  { \key bes \major }
\lesterLeapsInPhrase "B"  bes b    { \key b \major }

\markup \fontsize #3 "Using markup for flats and sharps"
\lesterLeapsInPhrase \markup { "D" \flat } bes des'  { \key des \major }

\markup \fontsize #3 "No label (just the transposed phrase)"
\lesterLeapsInPhrase ##f bes fis'  { \key fis \major }

\markup \fontsize #3 "3 ways to do the same thing"
\lesterLeapsInPhraseTwo bes c' { \key c \major }
\transposePhrase \markup { "C" \sharp  "C" \super \sharp} bes cis' { \key cis \major } \lesterLeapsInChords \lesterLeapsInMelody
\transposePhrase ##f bes d' { \key d \major } \lesterLeapsInChords \lesterLeapsInMelody

\pageBreak
\markup \fontsize #3 "From Lester Leaps In"

%% cleanly
\lesterLeapsInPhraseTwo bes bes  { \key bes \major }
\lesterLeapsInPhraseTwo bes b    { \key b \major }
\lesterLeapsInPhraseTwo bes c'   { \key c \major }
\lesterLeapsInPhraseTwo bes des' { \key des \major }
\lesterLeapsInPhraseTwo bes d'   { \key d \major }
\lesterLeapsInPhraseTwo bes ees' { \key ees \major }
\lesterLeapsInPhraseTwo bes e'   { \key e \major }
\lesterLeapsInPhraseTwo bes f'   { \key f \major }
\lesterLeapsInPhraseTwo bes fis' { \key fis \major }
\lesterLeapsInPhraseTwo bes g'   { \key g \major }
\lesterLeapsInPhraseTwo bes aes' { \key aes \major }
\lesterLeapsInPhraseTwo bes a'   { \key a \major }

%%%%%%%%%%%%%%%%%%%% Example: Create another phrase function

\pageBreak

%% Define another phrase
myOtherChords = \chordmode {
  c1:maj7 | a:m7 | d:m7 | g:7 |
}

myOtherMelody = \relative c'' {
  c4 d e f | e d c a | d e f g | f e d c |
  \bar "||"
}


%% Create a convenience function for this phrase
myOtherPhrase =
#(define-void-function
   (fromPitch toPitch keySig)
   (ly:pitch? ly:pitch? (ly:music?))
   (transposePhrase #f fromPitch toPitch keySig myOtherChords myOtherMelody))


%% Example usage (commented out):
\myOtherPhrase c c { \key c \major }
%% \myOtherPhrase "F" c f { \key f \major }
