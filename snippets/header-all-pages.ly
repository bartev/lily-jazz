\version "2.24.0"


\header {
  title = "ii-v-i-licks"
}


\paper {
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
      % avoid some layout problems. Also, moving it in between the title and
      % the page number, makes these be typeset left and right aligned, respectively.
      \if \should-print-page-number
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \if \should-print-page-number
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}
