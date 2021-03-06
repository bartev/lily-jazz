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
\sourcefilename "/home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-release-unstable/input/regression/parent-alignment-synchronized-with-self-alignment.ly"
\sourcefileline 0
\version "2.19.11"

\header {
  texidoc = "When @code{parent-alignment-X} property is unset,
the value of @code{self-alignment-X} will be used as the factor
for parent alignment.  This happens e.g. for LyricTexts."
}

{
  \time 4/2
  % use breve noteheads because their refpoints aren't on their
  % left edges - this may help catching subtle bugs.
  \override NoteHead.style = #'altdefault
  <>^"alignments “synchronized”:"
  f'\breve f' f'
  <>^"parent-alignment set to ##f:"
  f' f' f'
}
\addlyrics {
  \override LyricSpace.minimum-distance = 5

  \override LyricText.self-alignment-X = #LEFT
  left
  \override LyricText.self-alignment-X = #CENTER
  center
  \override LyricText.self-alignment-X = #RIGHT
  right

  \override LyricText.parent-alignment-X = ##f
  \override LyricText.self-alignment-X = #LEFT
  left
  \override LyricText.self-alignment-X = #CENTER
  center
  \override LyricText.self-alignment-X = #RIGHT
  right
}



% ****************************************************************
% end ly snippet
% ****************************************************************
