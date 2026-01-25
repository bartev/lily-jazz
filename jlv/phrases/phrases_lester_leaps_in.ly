\version "2.24.2"

%% Phrases from "Lester Leaps In" transposed to all 12 keys
%% 2 bar phrase shown in all keys (4 bars per line: 2 original + 2 transposed)

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

global = {
  \numericTimeSignature
  \time 4/4
  \key bes \major

  %% Make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% Make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)
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

%%%%%%%%%%%%%%%%%%%% Helper function to create a phrase in a given key

%% This function takes a key and creates a 2-bar phrase
%% transposeInterval: the interval to transpose (e.g., c c for no change, c d for whole step up)
%% keySignature: the target key signature (e.g., c \major, d \major, etc.)
%% keyName: string to display (e.g., "Bb", "B", "C")

makePhrase =
#(define-music-function (transposeFrom transposeTo keySignature keyName)
   (ly:pitch? ly:pitch? ly:music? string?)
   #{
     <<
       \new ChordNames {
         \transpose $transposeFrom $transposeTo \originalChords
       }
       \new Staff {
         \key $keySignature
         \transpose $transposeFrom $transposeTo \originalMelody
       }
     >>
   #})

%%%%%%%%%%%%%%%%%%%% Create all 12 keys

%% Original key (Bb)
\markup \vspace #1
\markup \fontsize #2 \bold "Bb"
\score {
  <<
    \new ChordNames { \originalChords }
    \new Staff {
      \global
      \originalMelody
    }
  >>
}

%% B
\markup \vspace #1
\markup \fontsize #2 \bold "B"
\score {
  <<
    \new ChordNames {
      \transpose bes b \originalChords
    }
    \new Staff {
      \key b \major
      \transpose bes b \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% C
\markup \vspace #1
\markup \fontsize #2 \bold "C"
\score {
  <<
    \new ChordNames {
      \transpose bes c \originalChords
    }
    \new Staff {
      \key c \major
      \transpose bes c \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% Db
\markup \vspace #1
\markup \fontsize #2 \bold "Db"
\score {
  <<
    \new ChordNames {
      \transpose bes des \originalChords
    }
    \new Staff {
      \key des \major
      \transpose bes des \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% D
\markup \vspace #1
\markup \fontsize #2 \bold "D"
\score {
  <<
    \new ChordNames {
      \transpose bes d \originalChords
    }
    \new Staff {
      \key d \major
      \transpose bes d \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% Eb
\markup \vspace #1
\markup \fontsize #2 \bold "Eb"
\score {
  <<
    \new ChordNames {
      \transpose bes ees \originalChords
    }
    \new Staff {
      \key ees \major
      \transpose bes ees \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% E
\markup \vspace #1
\markup \fontsize #2 \bold "E"
\score {
  <<
    \new ChordNames {
      \transpose bes e \originalChords
    }
    \new Staff {
      \key e \major
      \transpose bes e \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% F
\markup \vspace #1
\markup \fontsize #2 \bold "F"
\score {
  <<
    \new ChordNames {
      \transpose bes f \originalChords
    }
    \new Staff {
      \key f \major
      \transpose bes f \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% Gb
\markup \vspace #1
\markup \fontsize #2 \bold "Gb"
\score {
  <<
    \new ChordNames {
      \transpose bes ges \originalChords
    }
    \new Staff {
      \key ges \major
      \transpose bes ges \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% G
\markup \vspace #1
\markup \fontsize #2 \bold "G"
\score {
  <<
    \new ChordNames {
      \transpose bes g \originalChords
    }
    \new Staff {
      \key g \major
      \transpose bes g \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% Ab
\markup \vspace #1
\markup \fontsize #2 \bold "Ab"
\score {
  <<
    \new ChordNames {
      \transpose bes aes \originalChords
    }
    \new Staff {
      \key aes \major
      \transpose bes aes \originalMelody
    }
  >>
  \layout { indent = 0 }
}

%% A
\markup \vspace #1
\markup \fontsize #2 \bold "A"
\score {
  <<
    \new ChordNames {
      \transpose bes a \originalChords
    }
    \new Staff {
      \key a \major
      \transpose bes a \originalMelody
    }
  >>
  \layout { indent = 0 }
}
