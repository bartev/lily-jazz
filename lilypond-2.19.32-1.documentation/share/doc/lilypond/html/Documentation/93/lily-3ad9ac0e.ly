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
\sourcefilename "combining-dynamics-with-markup-texts.ly"
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
Ciertas indicaciones dinámicas pueden llevar textos (como @qq{più
forte} o @qq{piano subito}). Se pueden producir usando un bloque
@code{\\markup}.

"
  doctitlees = "Combinar indicaciones dinámicas con marcados textuales"

%% Translation of GIT committish: 8eae9a75fb3ec1d0b6633103c8a652608c8fa630
  texidocfr = "
Certaines indications de nuance peuvent requérir un complément textuel,
comme « più forte » ou « piano subito ».  Elles se réalisent aisément
à l'aide d'un bloc @code{\\markup}.

"
  doctitlefr = "Combinaison de nuance et de texte"

  lsrtags = "expressive-marks, really-simple, text"

  texidoc = "
Some dynamics may involve text indications (such as @qq{più forte} or
@qq{piano subito}). These can be produced using a @code{\\markup}
block.

"
  doctitle = "Combining dynamics with markup texts"
} % begin verbatim

piuF = \markup { \italic più \dynamic f }

\layout { ragged-right = ##f }

\relative c'' {
  c2\f c-\piuF
}



% ****************************************************************
% end ly snippet
% ****************************************************************
