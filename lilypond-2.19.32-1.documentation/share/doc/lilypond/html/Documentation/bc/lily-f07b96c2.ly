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
\sourcefilename "ottava-text.ly"
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
Internamente, @code{\\ottava} establece las propiedades
@code{ottavation} (por ejemplo, a @code{8va} o a @code{8vb}) y
@code{middleCPosition}.  Para sobreescribir el texto del corchete,
ajuste @code{ottavation} después de invocar la instrucción
@code{\\ottava}.

"
  doctitlees = "Texto de octava alta y baja"

%% Translation of GIT committish: a51b7ab55aed341ffd8af27a357212ed7ef528b9
  texidocit = "
Internamente, @code{\\ottava} imposta le proprietà @code{ottavation} (ad
esempio, su @code{8va} o @code{8vb}) e @code{middleCPosition}.  Per
sovrascrivere il testo della parentesi, occorre specificare @code{ottavation}
dopo il comando @code{\\ottava}.

"
  doctitleit = "Testo dell'ottava"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
texidocde = "
Intern setzt die @code{set-octavation}-Funktion die Eigenschaften
@code{ottavation} (etwa auf den Wert @code{\"8va\"} oder @code{\"8vb\"})
und @code{middleCPosition}.  Um den Text der Oktavierungsklammer zu
ändern, kann @code{ottavation} manuell gesetzt werden, nachdem
@code{set-octavation} benützt wurde.

"

doctitlede = "Ottava-Text"

%% Translation of GIT committish: 8eae9a75fb3ec1d0b6633103c8a652608c8fa630
  texidocfr = "
En interne, la fonction @code{\\ottava} détermine les
propriétés @code{ottavation} (par ex. en @code{\"8va\"} ou @code{\"8vb\"})
et @code{centralCPosition}.  Vous pouvez modifier le texte d'une marque
d'octaviation en définissant @code{ottavation} après avoir fait appel
à @code{ottava} :

"
  doctitlefr = "Texte des marques d'octaviation"

  lsrtags = "pitches, text"

  texidoc = "
Internally, @code{\\ottava} sets the properties @code{ottavation} (for
example, to @code{8va} or @code{8vb}) and @code{middleCPosition}.  To
override the text of the bracket, set @code{ottavation} after invoking
@code{\\ottava}.

"
  doctitle = "Ottava text"
} % begin verbatim

{
  \ottava #1
  \set Staff.ottavation = #"8"
  c''1
  \ottava #0
  c'1
  \ottava #1
  \set Staff.ottavation = #"Text"
  c''1
}



% ****************************************************************
% end ly snippet
% ****************************************************************
