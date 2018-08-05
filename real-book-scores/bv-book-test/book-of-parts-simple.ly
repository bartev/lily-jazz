\version "2.19.80"

#(set-global-staff-size 18)
\include "../../stylesheets/jazzchords.ily"
\include "../../stylesheets/lilyjazz.ily"
\include "../../stylesheets/jazzextras.ily"


\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
  % tocTitleMarkup = \markup \huge \column {
  %   \fontsize #6
  %   \hspace #1
  %   \fill-line { \null "Table of Contents" \null }
  %   \hspace #1
  % }
  % % user larger font size
  % tocItemMarkup = \markup \fontsize #10 \fill-line {
  %   \fromproperty #'toc:text 
  %   \fromproperty #'toc:page
  % }

  tocItemMarkup = \tocItemWithDotsMarkup 
}

title = "The Real Book"
subtitle = "Bartev"
curDate = "2018-07-25"

myBookTitle = \markup \center-column {
  {
    \fontsize #10
    \lower #70
    \override #'(offset . 15)
    \override #'(thickness . 10)
    \underline \larger \larger #title
  }
  {
    \fontsize #8
    \lower #20 #subtitle
  }
  { 
    \fontsize #2
    \lower #10 #curDate
  }
}

\header {
  title = \myBookTitle
}


\pageBreak

\markuplist \table-of-contents
\pageBreak


\include "bop-all-of-me.ly"
\include "bop-b.ly"
\include "bop-equinox.ly"
\include "bop-a.ly"
\include "bop-sweet-georgia-brown.ly"

% \bop-a
% \bop-equinox
% \fb-book-part-b
% \bop-all-of-me
