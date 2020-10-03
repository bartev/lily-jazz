\version "2.20.0"


\header {
  title = "ii-v-i-licks"
}


\paper {
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
      % avoid some layout problems. Also, moving it in between the title and
      % the page number, makes these be typeset left and right aligned, respectively.
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}
