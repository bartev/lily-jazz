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
\sourcefilename "/home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-release-unstable/input/regression/identifier-following-chordmode.ly"
\sourcefileline 0
\header {

  texidoc = "Identifiers following a chordmode section are not
interpreted as chordmode tokens.  In the following snippet, the
identifier `m' is not interpreted by the lexer as a minor chord
modifier."

}

\version "2.19.22"

myDisplayMusic =
#(define-void-function (music)
 (ly:music?)
 (display-scheme-music music (current-error-port)))

\myDisplayMusic \chordmode { c }

m = \relative { c'4 d e f }

\new Staff { \m }



% ****************************************************************
% end ly snippet
% ****************************************************************
