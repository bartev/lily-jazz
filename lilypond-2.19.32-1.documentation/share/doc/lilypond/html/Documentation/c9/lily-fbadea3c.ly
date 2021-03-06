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
\sourcefilename "making-some-staff-lines-thicker-than-the-others.ly"
\sourcefileline 0
%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
%% Translation of GIT committish: 56145dfed8f19bb34459d5b40cab388776d2ec49
  texidoces = "
Se puede engrosar una línea del pentagrama con fines pedagógicos
(p.ej. la tercera línea o la de la clave de Sol).  Esto se puede
conseguir añadiendo más líneas muy cerca de la línea que se quiere
destacar, utilizando la propiedad @code{line-positions} del objeto
@code{StaffSymbol}.

"
  doctitlees = "Hacer unas líneas del pentagrama más gruesas que las otras"

%% Translation of GIT committish: a51b7ab55aed341ffd8af27a357212ed7ef528b9
  texidocit = "
In ambito didattico può essere utile rendere più spesso una linea del
rigo (per esempio, la linea centrale, o per sottolineare la linea
della chiave di Sol).  Per farlo si possono aggiungere altre linee
e posizionarle molto vicino alla linea che deve essere evidenziata,
usando la proprietà @code{line-positions} dell'oggetto @code{StaffSymbol}.

"
  doctitleit = "Rendere alcune linee del rigo più spesse delle altre"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Für den pädagogischen Einsatz kann eine Linie des Notensystems dicker
gezeichnet werden (z. B. die Mittellinie, oder um den Schlüssel hervorzuheben).
Das ist möglich, indem man zusätzliche Linien sehr nahe an der Linie, die
dicker erscheinen soll, einfügt.  Dazu wird die @code{line-positions}-Eigenschaft
herangezogen.

"
  doctitlede = "Eine Linie des Notensystems dicker als die anderen machen"

%% Translation of GIT committish: 8eae9a75fb3ec1d0b6633103c8a652608c8fa630
  texidocfr = "
Vous pourriez avoir envie, dans un but pédagogique, de rendre certaines
lignes d'une portée plus épaisses que les autres, comme la ligne médiane,
ou bien pour mettre en exergue la ligne portant la clef de sol.  Il
suffit pour cela d'ajouter une ligne qui sera accolée à celle qui doit
être mise en évidence, grâce à la propriété @code{line-positions} de
l'objet @code{StaffSymbol}.

"
  doctitlefr = "Empâtement de certaines lignes d'une portée"

  lsrtags = "editorial-annotations, really-cool, staff-notation, workaround"

  texidoc = "
For educational purposes, a staff line can be thickened (e.g., the
middle line, or to emphasize the line of the G clef).  This can be
achieved by adding extra lines very close to the line that should be
emphasized, using the @code{line-positions} property of the
@code{StaffSymbol} object.

"
  doctitle = "Making some staff lines thicker than the others"
} % begin verbatim

{
  \override Staff.StaffSymbol.line-positions =
    #'(-4 -2 -0.2 0 0.2 2 4)
  d'4 e' f' g'
}



% ****************************************************************
% end ly snippet
% ****************************************************************
