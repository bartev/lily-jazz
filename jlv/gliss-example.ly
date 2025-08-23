\version "2.24.2"

\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord
\include "bv_definitions.ily"

%% Set up title
title = #"The Song Is NOT You"
composer = #"Jerome Kern"
arranger = #"Alex Hahn solo"
transcribed = #"Bartev 2025-07"
meter = "(med swing)"
instrument = \instrumentAlto

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

global = { }



chordChanges = \chordmode {
  \repeat volta 1 {
    \mark \default
    \mark \default
    \repeat percent 4 bes1:7 \break
    \repeat percent 2 ees1:7
    \repeat percent 2 bes1:7 \break
    f1:7 | ees1:7 | bes1:7 | f1:7 \break
  }
}

                                % Define slash notation (one slash per beat)
slashes = {
  \repeat volta 1 {
    \mark \default
    \repeat unfold 4 {

      \repeat unfold 4 { c'4*4 }
    }
  }
}

fourBars = { s1*4 \break }
sixteenBars = \repeat unfold 4 \fourBars

fourBarsC = \repeat unfold 16 { c4 }
sixteenBarsC = {
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
}

% Method 1: Using grace notes (most common approach)
jazzGlissGrace = #(define-music-function (note target-pitch) (ly:music? ly:pitch?)
  #{
    #note \glissando
    \hideNotes
    \grace #(make-music 'NoteEvent 'pitch target-pitch)
    \unHideNotes
  #})

% Method 2: Using afterGrace for more control
jazzGlissAfter = #(define-music-function (note target) (ly:music? ly:music?)
  #{
    \afterGrace #note {
      \glissando
      \hideNotes
      #target
      \unHideNotes
    }
  #})

% Method 3: Using zero-duration spacer with positioned glissando
jazzGlissZero = #(define-music-function (note target-pitch) (ly:music? ly:pitch?)
  #{
    #note \glissando
    \hideNotes
    \once \override NoteHead.duration-log = #2
    \once \override Stem.transparent = ##t
    #(make-music 'NoteEvent 'pitch target-pitch 'duration (ly:make-duration 0))
    \unHideNotes
  #})

% Method 4: Simple version using grace - probably the best for jazz
jazzGliss = #(define-music-function (note) (ly:music?)
  #{
    #note \glissando
    \hideNotes
    \grace c,4
    \unHideNotes
  #})

% Method 5: Glissando with custom target pitch
jazzGlissPitch = #(define-music-function (note target-note) (ly:music? ly:music?)
  #{
    #note \glissando
    \hideNotes
    \grace #target-note
    \unHideNotes
  #})

% Method 7: Distance-based glissando (like \bendAfter - in semitones)
jazzGlissDistance = #(define-music-function (note distance) (ly:music? number?)
  (let* ((pitch (ly:music-property note 'pitch))
         (octave (ly:pitch-octave pitch))
         (note-name (ly:pitch-notename pitch))
         (alteration (ly:pitch-alteration pitch))
         (new-pitch (ly:pitch-transpose pitch (ly:make-pitch 0 0 (* distance 0.5)))))
    #{
      #note \glissando
      \hideNotes
      \grace #(make-music 'NoteEvent 'pitch new-pitch)
      \unHideNotes
    #}))

% Method 8: Distance-based with return to original pitch (semitones)
jazzGlissDistanceReturn = #(define-music-function (note distance) (ly:music? number?)
  (let* ((pitch (ly:music-property note 'pitch))
         (octave (ly:pitch-octave pitch))
         (note-name (ly:pitch-notename pitch))
         (alteration (ly:pitch-alteration pitch))
         (new-pitch (ly:pitch-transpose pitch (ly:make-pitch 0 0 (* distance 0.5)))))
    #{
      #note \glissando
      \hideNotes
      \grace #(make-music 'NoteEvent 'pitch new-pitch)
      \grace #note  % Return to starting pitch
      \unHideNotes
    #}))

% Usage examples:
melody_example = \relative c'' {
  \time 3/4
  \override Glissando.style = #'zigzag

  % Simple downward gliss - no beat counting issues
  c4 c \jazzGliss { c4 } |
  d'4 d d |

  % In the middle of a measure
  c4 \jazzGliss { c4 } c'4 |
  d4 d2 |

  % Multiple glisses
  c4 \jazzGliss { c4 } \jazzGliss { c'4 } |
  c'4 d b

  % Works anywhere in the measure
  \jazzGliss { c4 } c'4 c4 |
  c4 c4 \jazzGliss { c4 } |

  % Custom target pitch
  c4 c \jazzGlissPitch { c4 } { d' } |  % down to low C

  c4 c \jazzGlissDistanceReturn { c4 } #-12 |  % Classic octave fall
  %% c4 c \jazzGlissDistanceReturn { c4 } #-7 |   % Fall down a fifth
  %% c4 c \jazzGlissDistanceReturn { c4 } #+2 |   % Slight upward scoop

}


\score {
  <<
    %% \new ChordNames \chordChanges
    \new Voice = soloist \melody_example
  >>
}
