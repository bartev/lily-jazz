%%%% The stylesheet for LILYJAZZ music font and LILYJAZZ-TEXT font
%%%%
%%%% In order for this to work, this file's directory needs to
%%%% be placed in LilyPond's path
%%%%
%%%% NOTE: If a change in the staff-size is needed, include
%%%% this file after it, like:
%%%%
%%%% #(set-global-staff-size 17)
%%%% \include "lilyjazz.ily"
%%%%
%%%% Copyright (C) 2014-2016 Abraham Lee (tisimst.lilypond@gmail.com)

% \version "2.19.80"
% BJV 2019-11-27 change version to hopefully run with 2.18.2
\version "2.18.2"

\paper {
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 20)
   ))
  #(set-paper-size "letter")
  between-system-space = 2.5\cm
  between-system-padding = #0
  indent = 0\mm
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
  page-breaking = #ly:minimal-breaking
  print-all-headers = ##f
  print-page-number = ##t
  print-first-page-number = ##f
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  % system-system-spacing.basic-distance = #12

}

\layout {
  \override Score.Hairpin.thickness = #2
  \override Score.Stem.thickness = #2
  \override Score.TupletBracket.thickness = #2
  \override Score.VoltaBracket.thickness = #2
  \override Score.SystemStartBar.thickness = #4
  \override StaffGroup.SystemStartBracket.padding = #0.25
  \override ChoirStaff.SystemStartBracket.padding = #0.25
  %\override Staff.Tie.thickness = #3
  \override Staff.Tie.line-thickness = #2
  \override Staff.Slur.thickness = #3
  \override Staff.PhrasingSlur.thickness = #3
  \override Staff.BarLine.hair-thickness = #4
  \override Staff.BarLine.thick-thickness = #8
  \override Staff.MultiMeasureRest.hair-thickness = #3
  \override Staff.MultiMeasureRestNumber.font-size = #2
  \override LyricHyphen.thickness = #3
  \override LyricExtender.thickness = #3
  \override PianoPedalBracket.thickness = #2
}

