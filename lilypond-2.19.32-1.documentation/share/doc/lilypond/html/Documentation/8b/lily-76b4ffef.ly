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
\sourcefilename "tick-bar-lines.ly"
\sourcefileline 0
%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
%% Translation of GIT committish: 26a079ca2393d053315ef8dbef626c897dc9645a
  texidoces = "
Con frecuencia se usan barras de compás en forma de 'tick' o raya
corta donde la línea divisoria se emplea solamente a efectos de
coordinación y no se quiere implicar con ella ningún énfasis rítmico.

"
  doctitlees = "Barras de compás en forma de raya corta"

%% Translation of GIT committish: 8eae9a75fb3ec1d0b6633103c8a652608c8fa630
  texidocfr = "
Lorsque les barres de mesure ne sont là que dans un but de coordination
et non pour accentuer le rythme, il arrive souvent qu'elles se
présentent sous la forme d'une simple encoche.

"
  doctitlefr = "Barre de mesure en encoche"

  lsrtags = "staff-notation"

  texidoc = "
'Tick' bar lines are often used in music where the bar line is used
only for coordination and is not meant to imply any rhythmic stress.

"
  doctitle = "Tick bar lines"
} % begin verbatim

\relative c' {
  \set Score.defaultBarType = #"'"
  c4 d e f
  g4 f e d
  c4 d e f
  g4 f e d
  \bar "|."
}



% ****************************************************************
% end ly snippet
% ****************************************************************
