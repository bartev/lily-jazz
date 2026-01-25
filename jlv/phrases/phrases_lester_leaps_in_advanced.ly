\version "2.24.2"

%% ADVANCED SCHEME VERSION: Automatic iteration through all 12 keys
%% This version uses Scheme to loop through keys programmatically

#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "bv_definitions.ily"

title = #"Lester Leaps In - Phrases (Auto-Generated)"
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

originalKey = bes

originalChords = \chordmode {
  bes2:6 g:m7 | c:m7 f:7 |
}

originalMelody = \relative c' {
  d4 f bes d | c bes g f |
  \bar "||"
}

%%%%%%%%%%%%%%%%%%%% Scheme function to create a transposed score

makeTransposedScore =
#(define-scheme-function
   (fromPitch toPitch keyMusic keyLabel chords melody)
   (ly:pitch? ly:pitch? ly:music? string? ly:music? ly:music?)
   #{
     \markup \vspace #1
     \markup \fontsize #2 \bold #keyLabel
     \score {
       <<
         \new ChordNames {
           \transpose #fromPitch #toPitch #chords
         }
         \new Staff {
           #keyMusic
           \transpose #fromPitch #toPitch #melody
         }
       >>
       \layout { indent = 0 }
     }
   #})

%%%%%%%%%%%%%%%%%%%% Generate all 12 keys using the Scheme function
%% Note: Scheme for-each loops don't work well for generating top-level scores
%% So we use explicit calls instead (still much cleaner than manual approach)

\makeTransposedScore \originalKey bes  #{ \key bes \major #}  "Bb"  \originalChords \originalMelody
\makeTransposedScore \originalKey b    #{ \key b \major #}    "B"   \originalChords \originalMelody
\makeTransposedScore \originalKey c    #{ \key c \major #}    "C"   \originalChords \originalMelody
\makeTransposedScore \originalKey des  #{ \key des \major #}  "Db"  \originalChords \originalMelody
\makeTransposedScore \originalKey d    #{ \key d \major #}    "D"   \originalChords \originalMelody
\makeTransposedScore \originalKey ees  #{ \key ees \major #}  "Eb"  \originalChords \originalMelody
\makeTransposedScore \originalKey e    #{ \key e \major #}    "E"   \originalChords \originalMelody
\makeTransposedScore \originalKey f    #{ \key f \major #}    "F"   \originalChords \originalMelody
\makeTransposedScore \originalKey ges  #{ \key ges \major #}  "Gb"  \originalChords \originalMelody
\makeTransposedScore \originalKey g    #{ \key g \major #}    "G"   \originalChords \originalMelody
\makeTransposedScore \originalKey aes  #{ \key aes \major #}  "Ab"  \originalChords \originalMelody
\makeTransposedScore \originalKey a    #{ \key a \major #}    "A"   \originalChords \originalMelody
