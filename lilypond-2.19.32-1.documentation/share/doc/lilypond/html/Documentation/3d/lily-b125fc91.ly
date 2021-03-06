%% Generated by lilypond-book.py
%% Options: [exampleindent=10.16\mm,indent=0\mm,line-width=160\mm,quote,ragged-right]
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
  line-width = 160\mm - 2.0 * 10.16\mm
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
  ragged-right = ##t
}

\layout {
  
}





% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefilename "piano-template-with-melody-and-lyrics.ly"
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
He aquí el típico formato dde una canción: un pentagrama con la
melodía y la letra, y el acompañamiento de piano por debajo.

"
  doctitlees = "Plantilla de piano con melodía y letra"

%% Translation of GIT committish: fabcd22c8f88ea9a87241597f1e48c0a9adbfc6e
  texidocja = "
これは一般的な歌曲のフォーマットです: 旋律と歌詞を持つ譜と、その下にピアノ伴奏譜があります。
"
  doctitleja = "旋律と歌詞を持つピアノ テンプレート"

%% Translation of GIT committish: a51b7ab55aed341ffd8af27a357212ed7ef528b9
  texidocit = "
Ecco un tipico formato per canzoni: un rigo con linea melodica e testo,
e sotto l'accompagnamento per pianoforte.

"
  doctitleit = "Modello per pianoforte con melodia e testo"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Das nächste Beispiel ist typisch für ein Lied: Im oberen System die
Melodie mit Text, darunter Klavierbegleitung.
"

  doctitlede = "Vorlage für Klavier und Gesangsstimme"


%% Translation of GIT committish: 8eae9a75fb3ec1d0b6633103c8a652608c8fa630
  texidocfr = "
Il s'agit du format classique pour le chant : une portée pour la mélodie
et les paroles au-dessus de l'accompagnement au piano.

"
  doctitlefr = "Piano, mélodie et paroles"

  lsrtags = "keyboards, really-simple, template, vocal-music"

  texidoc = "
Here is a typical song format: one staff with the melody and lyrics,
with piano accompaniment underneath.

"
  doctitle = "Piano template with melody and lyrics"
} % begin verbatim

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4

  a b c d
}

text = \lyricmode {
  Aaa Bee Cee Dee
}

upper = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

lower = \relative c {
  \clef bass
  \key c \major
  \time 4/4

  a2 c
}

\score {
  <<
    \new Voice = "mel" { \autoBeamOff \melody }
    \new Lyrics \lyricsto mel \text
    \new PianoStaff <<
      \new Staff = "upper" \upper
      \new Staff = "lower" \lower
    >>
  >>
  \layout {
    \context { \Staff \RemoveEmptyStaves }
  }
  \midi { }
}



% ****************************************************************
% end ly snippet
% ****************************************************************
