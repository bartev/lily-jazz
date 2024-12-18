\version "2.24.2"

%% Compose some ii-v-i phrases (major, minor, other)

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% %% set to 18 to fit entire head and title on 1 page
%% %% #(set-global-staff-size 16)
\include "jazzchords.ily"
%% \include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright

tagline = "Bartev 2024-12"
copyright = #"Bartev 2024"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

title = #"Compose ii-v-i phrases"
%% meter = ""
%% \concat spaces differently than if I didn't say \concat
%% instrument = \markup \with-color "blue" \concat {
%%   "Alto (E "
%%   \raise #0.5 \fontsize #-2 \flat ")"
%% }
instrument = ""
composer = #"Bartev"
arranger = #"2024-12 lesson 26"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -5) % Adjust vertical position (X . Y)
      s^\markup {
        \fill-line {
          %% Left side: Meter and instrument
          \vcenter { % Center everything vertically
           ""
            %% \column {
            %%   %% Meter
            %%   {\fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }}
            %%   {\fontsize #1 \instrument}
            %% }
          }
          %% Center: Title
          %% Title
          \vcenter {
            \fontsize #7 % Bigger number is larger font
            \override #'(thickness . 6)
            {
              \override #'(offset . 18) % Add space above the underline (raises text)
              %% \underline
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
  %% tagline = \tagline
  %% copyright = \copyright
  %% The following fields are evenly spread on one line
  %% the field "instrument" also appears on following pages
  %% instrument = \markup \with-color #blue "Alto Sax"
  %% arranger = \arranger
  %% instrument = \instrument
}

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  indent = 0\mm

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f
}

global = {
  \numericTimeSignature
  \time 4/4
  %% \tempo 4=224  % this would be over the clef on the first line

  %% See here for using colors
  %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
  %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
  \override Score.RehearsalMark.color = #darkred
  %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
  \override Score.RehearsalMark.font-size = 6

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

%%%%%%%%%%%%%%%%%%%% Begin music

\markup { "ii-V-I in D maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { e1:m7 a:7 d:maj7 d:maj7 }}
    \new Staff {
      \global
      \key d \major
      \relative c'' {
        g8 fis g a b a b cis
        e8 d e fis g fis g a
        b8 cis d g, a4 fis8 d
        e8 fis e d~ d4 r
      }
    }
    \lyrics {
      \markup \scaleDegree { f3 }2
      \markup \scaleDegree { 5 }2

      \markup \scaleDegree { 3 }2
      \markup \scaleDegree { f7 }2

      \markup \scaleDegree { 6 }8
      \markup \scaleDegree { 7 }8
      \markup \scaleDegree { 1 }8
      \markup \scaleDegree { 4 }8
      \markup \scaleDegree { 5 }2

      \markup \scaleDegree { 2 }4.
      \markup \scaleDegree { 1 }8
    }
  >>
}

\markup { "ii-V-i in C-" }
\score {
  \new StaffGroup <<
%%    \new ChordNames { \chordmode { d1:m7.5- g:7 c:m7 c:m7 }}
    \new Staff {
      \global
      \key c \major
      \relative c'' {
        s1 s1 s1 s1
      }
    }
  >>
}

\markup { "Backdoor dominant C" }
\score {
  \new StaffGroup <<
  %%  \new ChordNames { \chordmode { f1:m7 bes:7 c:maj7 c:maj7 }}
    \new Staff {
      \global
      \key c \major
      \relative c'' {
        s1 s1 s1 s1
      }
    }
  >>
}

\markup { "Tritone substitution D" }
\score {
  \new StaffGroup <<
    %% \new ChordNames { \chordmode { d1:m7 g:7 fis:maj7 fis:maj7 }}
    \new Staff {
      \global
      \key c \major
      \relative c'' {
        s1 s1 s1 s1
      }
    }
  >>
}
