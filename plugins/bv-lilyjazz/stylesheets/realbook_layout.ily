%% Default Real Book like paper and layout settings

\paper {
  #(set-paper-size "letter")
  indent = 0
  top-margin = 12\mm
  bottom-margin = 10\mm
  left-margin = 14\mm
  right-margin = 14\mm
  print-page-number = ##t
  ragged-bottom = ##t
}

\numericTimeSignature

\layout {
  \context { \Lyrics \override LyricText.font-name = #"serif" }
  \context {
    \Score
    %% See here for using colors
    %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
    %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
    \override RehearsalMark.color = #red
    \override RehearsalMark.font-family = #'jazz
    \override RehearsalMark.font-size = #6
    markFormatter = #format-mark-box-alphabet
  }
  \context {
    \Staff
    %% make only the first clef visible
    \override Clef.break-visibility = #'#(#f #f #t)

    %% make only the first time signature visible --  #'#(#f #f #f)
    %% Make the signature visible at each line break -- #'#(#f #f #t)
    \override KeySignature.break-visibility = #'#(#f #f #t)

    %% allow single-staff system bars
    \override SystemStartBar.collapse-height = #1

    \override MultiMeasureRest.expand-limit = 1

    %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark

    %% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
    %% \compressFullBarRests
  }
  \context {
    \ChordNames
    chordChanges = ##t %% Only show chord when it changes%}
    \consists "Percent_repeat_engraver"
  }
}
