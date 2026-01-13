%% Default Real Book like paper and layout settings

%% #(set-global-staff-size 16)

\include "lilyjazz.ily"
\include "jazzchords.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\paper {
  #(set-paper-size "letter")
  %% These are set in lilyjazz.ily
  %% #(define fonts
  %%   (set-global-fonts
  %%    #:music "lilyjazz"
  %%    #:brace "lilyjazz"
  %%    #:roman "lilyjazz-text"
  %%    #:sans "lilyjazz-chord"
  %%    #:factor 1.0
  %%    ;; #:factor (/ staff-height pt 18)
  %%  ))

  indent = 0\mm
  %% print-page-number = ##t
  %% margins
  top-margin = 12\mm % or 0.5\in
  bottom-margin = 10\mm
  left-margin = 14\mm
  right-margin = 14\mm

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f

  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))

  oddHeaderMarkup = \markup
  \fill-line {
    %% If not using the realBookTitle, can use
    %% \fromproperty #'header:title " "
    \title
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
    \fromproperty #'page:page-number-string " "
    \title
  }
}

%% #(end-of-line beginning-of-line middle-of-line)
%% visibility = #'#(#f #f #t)
%% visibilityFirstOnly = #'#(#f #f #f)
%% #begin-of-line-visible = #'#(#f #f #t) - at beginning of every line
%% #all-visible = #'#(#t #t #t) - everywhere


\layout {
  \numericTimeSignature
  \context { \Lyrics \override LyricText.font-name = #"serif" }
  \context {
    \Score
    %% (end-of-line middle-of-line beginning-of-line)
    \override BarNumber.break-visibility = #begin-of-line-visible
    \override BarNumber.font-family = #'jazz

    %% Make only the first clef visible
    \override Clef.break-visibility = #'#(#f #f #f)

    %% See here for using colors
    %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
    %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
    \override RehearsalMark.color = #red
    \override RehearsalMark.font-family = #'jazz
    \override RehearsalMark.font-size = #6

    %% \override SystemStartBar.break-visibility = #'#(#f #f #t)
    %% Show barline at beginning of lines
    \override SystemStartBar.collapse-height = #1

    markFormatter = #format-mark-box-alphabet
  }
  \context {
    \Staff
    \clef treble

    %% Make the signature visible at each line break
    \override KeySignature.break-visibility = #'#(#f #f #t)

    \override MultiMeasureRest.expand-limit = 1

    %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark

    %% Uncomment this to have multibar, jazz style repeats. BUT, bar lines won't
    %% show when using "s" to fill in blanks
    %% \compressFullBarRests
  }
  \context {
    \ChordNames
    chordChanges = ##t %% Only show chord when it changes%}
    \consists "Percent_repeat_engraver"
    \override ChordName.font-size = #1.5 % slightly larger chord symbols
    \override ChordName.font-family = #'sans
  }
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
              %% {\fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }}
              {\fontsize #1 \lower #1 \rotate #7 \concat { \note { 4 } #1 "=" #meter } }
              {\fontsize #3 \rotate #7 \instrument}
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
              \fontsize #1 \lower #1 \concat { #arranger " " }
              \fontsize #1 \lower #1 \concat { #transcribed " " }
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
  tagline = \tagline
  copyright = \copyright
  %% The following fields are evenly spread on one line
  %% the field "instrument" also appears on following pages
  %% instrument = \markup \with-color #blue "Alto Sax"
  %% arranger = \arranger
  %% instrument = \instrument
}
