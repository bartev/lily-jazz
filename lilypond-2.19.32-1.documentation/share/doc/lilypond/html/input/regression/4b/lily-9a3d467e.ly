%% Generated by lilypond-book.py
%% Options: [exampleindent=10.16\mm,indent=0\mm,line-width=160\mm]
\include "lilypond-book-preamble.ly"


% ****************************************************************
% Start cut-&-pastable-section
% ****************************************************************



\paper {
  indent = 0\mm
  line-width = 160\mm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
}

\layout {
  
}





% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefilename "/home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-release-unstable/input/regression/tuplet-single-note.ly"
\sourcefileline 0

\header {

  texidoc = "Show tuplet numbers also on single-note tuplets (otherwise the timing would look messed up!), but don't show a bracket. Make sure that tuplets without any notes don't show any number, either."

}
\version "2.19.21"

\paper { ragged-right = ##t
indent = 0.0 }

\new Staff <<
  \new Voice \relative {
    \tuplet 6/4 { c''2.:8 } \tuplet 3/2 { g4.:8 } \tuplet 3/2 { a,4.:8 } \tuplet 6/4 {} \bar"|."
  }
>>
  



% ****************************************************************
% end ly snippet
% ****************************************************************
