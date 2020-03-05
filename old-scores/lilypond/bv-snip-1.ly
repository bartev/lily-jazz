\version "2.20.0"
% ****************************************************************
% Start cut-&-pastable-section
% ****************************************************************



\paper {
  indent = 30\mm
  line-width = 160\mm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
  line-width = 160\mm - 2.0 * 10.16\mm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
}

\layout {
  
}





% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefileline 721
\relative {
  c''4-\markup { \bold \huge { Click here. } }
}



% ****************************************************************
% end ly snippet
% ****************************************************************
