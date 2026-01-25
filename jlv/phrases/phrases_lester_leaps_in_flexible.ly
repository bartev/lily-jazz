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

  system-system-spacing = #'((basic-distance . 15)
                             (minimum-distance . 8)
                             (padding . 1))
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

%%%%%%%%%%%%%%%%%%%% Generic transpose function (low-level)

%% This is the flexible base function that takes all parameters
%% Parameters:
%%   keyLabel - string, markup, or #f (false) for no label
%%   fromPitch - original pitch (ly:pitch?)
%%   toPitch - target pitch (ly:pitch?)
%%   keySig - key signature music, or #f for no change
%%   chords - chord progression music
%%   melody - melody music

transposePhrase =
#(define-void-function
   (keyLabel fromPitch toPitch keySig chords melody)
   ((scheme?) ly:pitch? ly:pitch? (ly:music?) ly:music? ly:music?)
   ;; Add vspace and label only if keyLabel is provided
   (if keyLabel
       (begin
         (add-text #{ \markup \vspace #1 #})
         (cond
          ;; If keyLabel is markup, use it directly
          ((markup? keyLabel)
           (add-text #{ \markup \fontsize #2 \bold #keyLabel #}))
          ;; If keyLabel is string, wrap it in markup
          ((string? keyLabel)
           (add-text #{ \markup \fontsize #2 \bold #keyLabel #})))))
   ;; Add the score
   (add-score
     (if keySig
         ;; If keySig provided, include it
         #{
           \score {
             <<
               \new ChordNames {
                 \transpose #fromPitch #toPitch $chords
               }
               \new Staff {
                 #keySig
                 \transpose #fromPitch #toPitch $melody
               }
             >>
             \layout { indent = 0 }
           }
         #}
         ;; If no keySig, omit it
         #{
           \score {
             <<
               \new ChordNames {
                 \transpose #fromPitch #toPitch $chords
               }
               \new Staff {
                 \transpose #fromPitch #toPitch $melody
               }
             >>
             \layout { indent = 0 }
           }
         #})))

%%%%%%%%%%%%%%%%%%%% Convenience function for Lester Leaps In phrase

%% This wrapper makes it easy to transpose the Lester Leaps In phrase
%% Just pass keyLabel, fromPitch, toPitch, and optionally keySig

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

%%%%%%%%%%%%%%%%%%%% Define the original phrase (in Bb)

lesterLeapsInChords = \chordmode {
  bes2:6 g:m7 | c:m7 f:7 |
}

lesterLeapsInMelody = \relative c' {
  d4 f bes d | c bes g f |
  \bar "||"
}

%%%%%%%%%%%%%%%%%%%% Generate all 12 keys with various label styles

%% Using plain strings
\lesterLeapsInPhrase "Bb" bes bes  { \key bes \major }
\lesterLeapsInPhrase "B"  bes b    { \key b \major }
%% Using markup for flats and sharps
\lesterLeapsInPhrase \markup { "D" \flat } bes des'  { \key des \major }
%% No label (just the transposed phrase)
\lesterLeapsInPhrase ##f bes fis'  { \key fis \major }

%% 3 ways to do the same thing
\lesterLeapsInPhraseTwo bes c' { \key c \major }
\transposePhrase \markup { "C" \super \sharp } bes cis' { \key cis \major } \lesterLeapsInChords \lesterLeapsInMelody
\transposePhrase \markup { "C" \sharp } bes cis' { \key cis \major } \lesterLeapsInChords \lesterLeapsInMelody
\transposePhrase ##f bes d' { \key d \major } \lesterLeapsInChords \lesterLeapsInMelody

\pageBreak

%% cleanly
\lesterLeapsInPhraseTwo bes bes  { \key bes \major }
\lesterLeapsInPhraseTwo bes b    { \key b \major }
\lesterLeapsInPhraseTwo bes c'   { \key c \major }
\lesterLeapsInPhraseTwo bes des'  { \key des \major }
\lesterLeapsInPhraseTwo bes d'   { \key d \major }
\lesterLeapsInPhraseTwo bes ees'  { \key ees \major }
\lesterLeapsInPhraseTwo bes e'   { \key e \major }
\lesterLeapsInPhraseTwo bes f'   { \key f \major }
\lesterLeapsInPhraseTwo bes fis'  { \key fis \major }
\lesterLeapsInPhraseTwo bes g'   { \key g \major }
\lesterLeapsInPhraseTwo bes aes'  { \key aes \major }
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
