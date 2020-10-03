\version "2.20.0"

% https://github.com/uliska/scheme-book/blob/master/scheme/music-function-primer.md

% #{ LilyPond code #}

% starting with v2.19, the parameter list doesn't need to start with
% (parser location ...)
% in this case, it would've been
% (parser location argument-name)
% current stable version 2.18.2 still requires this format

% mySchemeFunction = #(define-scheme-function 
%                  (argument-name)
%                  (string?);
%                  function body)

mySchemeFunction = #(define-scheme-function (name) (string?)
                 (string-append name "|" name))

\header {
        title = \mySchemeFunction "Doubled Title"
}
                 

myMusicFunction = #(define-music-function (color) (color?)
                #{ 
                \override NoteHead.color = #color 
                \override Stem.color = #color 
                \override Flag.color = #color 
                #})

{ c'4 \myMusicFunction #red d'8 e' }


myVoidFunction = #(define-void-function (a-value) (number?)
               (display (* 2 a-value)))

\myVoidFunction 4
