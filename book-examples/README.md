# README

* Example from http://lilypond.org/doc/v2.18/Documentation/usage-big-page.html#running-lilypond

To run

``` shell
lilypond-book --output=out --pdf lilybook.lytex
lilypond-book (GNU LilyPond) 2.18.2 
Reading lilybook.lytex...
…lots of stuff deleted…
Compiling lilybook.tex...
cd out
pdflatex lilybook
…lots of stuff deleted…
xpdf lilybook
(replace xpdf by your favorite PDF viewer)

```
