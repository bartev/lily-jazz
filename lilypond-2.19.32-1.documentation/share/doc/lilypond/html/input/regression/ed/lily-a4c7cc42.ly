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
\sourcefilename "/home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-release-unstable/input/regression/tuplet-rest.ly"
\sourcefileline 0

\version "2.19.21"
\header {

  texidoc = "Tuplets may contain rests. "

}


\context Voice  \relative {
  \time 2/4
  \tuplet 3/2 { r c, c''' }
  \tuplet 3/2 { r c c  }
  \tuplet 3/2 { r c r }
  \tuplet 3/2 { r r r }
  \tuplet 3/2 { r c e }
  \tuplet 3/2 { c r e }
  \tuplet 3/2 { r c g }
  \tuplet 3/2 { c r g }
}






% ****************************************************************
% end ly snippet
% ****************************************************************
