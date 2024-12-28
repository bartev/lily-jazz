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
%% date
%% bvTagline
%% timestop
%% markManualBox
%% markBlue
%% blueChord
%% redChord
%% greenChord

%% set up title, compser, meter, copyright

tagline = \bvTagline
copyright = #"Bartev 2024"

%% %%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

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

\markup { "1) ii-V-I in D maj" }
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

\markup \concat { "2) ii-V-I in E" \flat " maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { f1:m7 bes:7 ees:maj7 ees:maj7 }}
    \new Staff {
      \global
      \key ees \major
      \relative c''' {
        c8 ees d c bes aes f aes~
        aes8 f ees d ees4 f8 d~
        d8 ees f aes~ aes g f g~
        g4 r4 r2
      }
    }
    \lyrics {
      \markup \scaleDegree { 5 }2
      \markup \scaleDegree { 4 }4.
      \markup \scaleDegree { f3 }8

      \markup \scaleDegree { f7 }2
      \markup \scaleDegree { 4 }4.
      \markup \scaleDegree { 3 }8

      \markup \scaleDegree { 7 }2
      \markup \scaleDegree { 4 }4.
      \markup \scaleDegree { 3 }8

      \markup \scaleDegree { 3 }1
    }
  >>
}

\markup \concat { "3) ii-V-I in A maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { b2:m7 e:7 a1:maj7 } }
    \new Staff {
      \global
      \key a \major
      \relative c'' {
        r8 fis r e  d b a fis
        gis4 a8 e~ e4 r
      }
    }
  >>
}


\markup \concat { "4) ii-V-I in A maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { b1:m7 e:7 a1:maj7 a1:maj7 }}
    \new Staff {
      \global
      \key a \major
      \relative c'' {
        r4 d e fis
        e fis gis b
        a2. cis4
        gis,8 cis e gis~ gis4 e8 cis
      }
    }
  >>
}


\markup \concat { "5) ii-V-I in A maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { b1:m7 e:7 a1:maj7 a1:maj7 }}
    \new Staff {
      \global
      \key a \major
      \relative c'' {
        a2 d
        d2 gis
        gis2 cis
        s1
      }
    }
  >>
}


\markup { "4) ii-V-I in G maj" }
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { s4 a1:m7 d:7 g:maj7 g:maj7 }}
    \new Staff {
      \global
      \key g \major
      \relative c'' {
        \partial 4 { r8 g}
        \tuplet 3/2 { a8 c e } g8 fis8~ fis e~ e4~
        e8 d e fis d r r a
        aes g fis g b fis'~ fis e
        d b r2.
      }
    }
    \lyrics {
      s4
      \markup \scaleDegree { 1 }4
      \markup \scaleDegree { f7 }4.
      \markup \scaleDegree { 5 }4.
      s8
      \markup \scaleDegree { 1 }4
      \markup \scaleDegree { 3 }8
      \markup \scaleDegree { 1 }4.
      \markup \scaleDegree { 2 }8

      \markup \scaleDegree { f2 }8
      \markup \scaleDegree { 1 }8
      \markup \scaleDegree { 7 }8
      \markup \scaleDegree { 1 }8

      \markup \scaleDegree { 3 }8
      \markup \scaleDegree { 7 }4
      \markup \scaleDegree { 5 }8

      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { 3 }8

    }
  >>
}

\markup { "Minor ii-v-i in B" \fontsize #-2 \flat " minor (scales)" }
\markup {
  \column {
    \override #'(font . "Serif")  % Again, set font to basic serif
    "Think about a locrian or locrian nat 2 for the half dim chord."
    "The dominant chord may have a b13 (b6), so the nat 2 from the first chord to the b6 adds some chromatic motion."
  }
}
\score {
  \new StaffGroup <<
    \new ChordNames { \chordmode { c1:m7.5- f:7.9- bes:min7 des:maj}}
    \new Staff {
      \global
      \key c \minor
      \relative c' {
        c8 des ees f ges aes bes c
        f,8 ges aes bes c des ees f
        bes,8 c des ees f ges aes bes
        des,,8 ees f ges aes bes c des
      }
    }
  >>
}

\markup { "Minor ii-V-i in C-7" }
\score {
  \new StaffGroup <<
   \new ChordNames { \chordmode { d1:m7.5- g:7.9- c:m7 c:m7 }}
    \new Staff {
      \global
      \key c \minor
      \relative c''' {
        b8 a gis f ees4 c8 d
        s1 s1 s1
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

\markup { "Backdoor dominant C" }
