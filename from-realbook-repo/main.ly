\version "2.18.2"

% \require "lilyjazz"
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\layout {

  % \override Staff.Clef.stencil = ##f
  % \override Staff.TimeSignature.stencil = ##f
  % \override Staff.KeySignature.stencil = ##f

  ragged-right = ##f

  % \override Score.TextScript.font-name = #"LilyJAZZ Text"
  \override Score.Clef #'break-visibility = #'#(#f #f #f)
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)
  \override Score.SystemStartBar #'collapse-height = #1
  
  \numericTimeSignature
  % \jazzOn

}

\book {

  \paper {

    indent = 0\mm
    tagline = ##f
    ragged-bottom = ##f

    % #(define fonts
    %    (set-global-fonts
    %     #:roman "LilyJAZZ Text"
    %     #:factor (/ staff-height pt 20)))

    scoreTitleMarkup = \markup {
      \fill-line {
        \fontsize #1 \lower #1 \rotate #7 \fromproperty #'header:meter
        \fontsize #8
        \override #'(offset . 7)
        \override #'(thickness . 6)
        \underline \fromproperty #'header:title
        \fontsize #1 \lower #1 \fromproperty #'header:composer
      }
    }

  }

  \include "all.ly"

}