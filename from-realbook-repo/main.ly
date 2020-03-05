\version "2.20.0"

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

    % scoreTitleMarkup = \markup {
    %   \score {
    %     {
    %       \override TextScript.extra.offset = #'(0 . -4.5)
    %       s4
    %       s^\markup {
    %         \fill-line {
    %           \fontsize #1 \lower #1 \rotate #7 \concat { " " \fromproperty #'header:meter }
    %           \fontsize #7
    %           \override #'(offset . 7)
    %           \override #'(thickness . 6)              
    %           \underline \larger \fromproperty #'header:title
    %           \fontsize #1 \lower #1 \fromproperty #'header:composer
    %         }
    %       }
    %     }
    %   }
    % }

    %   \layout {
    %     % \omit Staff.Cleff
    %     % \omit Staff.TimeSignature
    %     % \omit Staff.KeySignature
    %     ragged-right = ##f        
    %   }
  }

  \include "scores/all.ly"

}
