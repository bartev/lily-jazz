\version "2.19.80"

\include "all-of-me.ly"

\markuplist \table-of-contents
\pageBreak


\header { tagline = ##f }
\paper {
  tocActMarkup = \markup \large \column {
    \hspace #1
    \fill-line { \null \italic \fromproperty #'toc:text \null }
    \hspace #1
  }
}

tocAct =
#(define-music-function (parser location text) (markup?)
   (add-toc-item! 'tocActMarkup text))

\book {
  \markuplist \table-of-contents
  \markup \null
}
