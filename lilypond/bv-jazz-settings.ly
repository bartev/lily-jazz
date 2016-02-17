\version "2.19.31"

% \include "./stylesheets/jazzchords.ily"
\include "./stylesheets/lilyjazz.ily"

\paper {
  #(define fonts
    ( set-global-fonts
      #:music "lilyjazz"
      #:brace "lilyjazz"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 20)
    )
  )
}

\paper { indent = #10 }

\layout {
  \override Staff.Slur.thickness = #3
}

%%%%%%%%%%%% Some macros %%%%%%%%%%%%%%%%%%%

sl = {
  \override NoteHead.style = #'slash
  \hide Stem
}

nsl = {
  \revert NoteHead.style
  \undo \hide Stem
}

crOn = \override NoteHead.style = #'cross
crOff = \revert NoteHead.style

%% insert chord name style stuff here.

% \set minorChordModifier = \markup { "-" }

% jazzChords = { }

%%%%%%%%%%%% Keys'n'thangs %%%%%%%%%%%%%%%%%

global = { \time 4/4 }

Key = { \key c \major }
