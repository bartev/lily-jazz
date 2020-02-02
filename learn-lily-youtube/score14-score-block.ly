\version "2.18.2"
\language "english"

\header {
  title = "title"
  composer = "composer"
  tagline = # #f
}

\paper { 
  #(set-paper-size "letter")
}

global = { 
  \key e \minor
  \time 3/4
}

% score block
% put things that are related to musical score
% * each score block corresponds to one score in the tutorial
% * essentially a top-level expression like \book or \paper
% treat it like it's your output

% * must contain a single music expression which is surrounded by curly braces

% * version statement
% * header
% * definitions
% * \score block
%   * \layout block
%   * \midi block
%   * \new Staff with instrument name

% Why do you need a \score block?

% LilyPond provides one behind the scenes

myviolin = \relative c''
  { g4 d8 f e( d b c) }

mycello = \relative c'
  { \clef "bass" g2 a4 e }

\score {
  <<
    \new Staff { \myviolin }
    \new Staff \mycello
  >>
}