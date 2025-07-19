\version "2.24.2"

\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "bv_definitions.ily"
\include "realbook_layout.ily"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.%}

%% set up title, compser, meter, copyright
title = #"SET MY TITLE"
composer = #"SET COMPOSER"
arranger = #"Real Book v1, 5th ed p 229"
meter = "SET METER"

copyright = #"Bartev 2022 -- copyright goes at the bottom of the first page"
tagline = \bvTagline
rb_instrument = \markup \with-color "blue" {
  "Alto (E"
  \raise #0.5 \fontsize #-2 \flat ")"
}

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -6) % Adjust vertical position (X . Y)
      s^\markup {
        \fill-line {
          %% Left side: Meter and instrument
          \vcenter { % Center everything vertically
            \column {
              %% Meter
              {\fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }}
              {\fontsize #1 \rb_instrument}
            }
          }
          %% Center: Title
          %% Title
          \vcenter {
            \fontsize #7 % Bigger number is larger font
            \override #'(thickness . 6)
            { \override #'(offset . 18) % Add space above the underline (raises text)
              \underline
              #title
            }
          }
          %% Right side: Composer and Arranger
          \vcenter {
            \right-column {
              \fontsize #3 \lower #1 \concat { #composer " " }
              \fontsize #0 \lower #1 \concat { #arranger " " }
            }
          }
        }
      }
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##f
      ragged-last-bottom = ##t
      \override Score.BarLine.transparent = ##t  % Remove barline at the end of the staff
    }
  }
}

\header {
  title = \realBookTitle
  subtitle = "Subtitle"
}


realBookHeader =
#(define-music-function
  (title composer arranger meter instrument)
  (markup? markup? markup? markup? markup?)
  #{
    \markup
    \score {
      {
        \override TextScript.extra-offset = #'(0 . -6)
        s^\markup {
          \fill-line {
            %% Left: Meter & Instrument
            \vcenter {
              \column {
                \fontsize #2 \lower #2 \rotate #7 \concat {
                  \note { 4 } #1 " = " #meter
                }
                \fontsize #1
                #(if (markup? instrument) instrument empty-markup)
              }
            }

            %% Center: Title
            \vcenter {
              \fontsize #7
              \override #'(thickness . 6)
              {
                \override #'(offset . 18)
                \underline
                #title
              }
            }

            %% Right: Composer & Arranger
            \vcenter {
              \right-column {
                \fontsize #3 \lower #1 #composer
                \fontsize #0 \lower #1
                #(if (markup? arranger) arranger empty-markup)
              }
            }
          }
        }
      }
      \layout {
        \omit Staff.Clef
        \omit Staff.TimeSignature
        \omit Staff.KeySignature
        ragged-right = ##f
        ragged-bottom = ##f
        ragged-last-bottom = ##t
        \override Score.BarLine.transparent = ##t
      }
    }
  #})


fooTitle = \realBookHeader
    #"My Song Title"
    #"My Composer"
    #empty-markup    % No arranger
    #"132"
    #empty-markup    % No instrument



bluesChords = \chordmode {
  \repeat volta 1 {
    \mark \default
    \repeat percent 4 {bes1:7} \break
    \repeat percent 2 {ees1:7} \repeat percent 2 {bes1:7} \break
    f1:7 | ees1:7 | bes1:7 | f1:7
  }
}

                                % Define slash notation (one slash per beat)
slashes = {
  \repeat volta 1 {
    \mark \default
    \repeat unfold 12 {
      \once \override NoteHead.style = #'slash
      \repeat unfold 4 { c'4 }
    }
  }
}


\score {
  <<
    \new ChordNames { \bluesChords }

    \new Staff {
      \clef treble
      \key bes \major
      \time 4/4
      \slashes
    }
  >>


  \layout {
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}
