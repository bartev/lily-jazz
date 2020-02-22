# README

* Example from http://lilypond.org/doc/v2.18/Documentation/usage-big-page.html#running-lilypond


* edit `bv-lilybook.lytex`
* add files to `tex/`

To run

``` shell
lilypond-book --output=outbv --pdf bv-lilybook.lytex
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

## Errors

* LaTeX Error: File `tikz.sty' not found.
  * See https://tex.stackexchange.com/questions/140555/how-to-fix-tikz-sty-problem
  * added `apt-get install -y texlive-full` to the Docker image
  * check, does `kpsewhich tikz` at terminal return the path of `tikz`
  
