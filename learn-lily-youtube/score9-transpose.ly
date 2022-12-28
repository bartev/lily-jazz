\version "2.24.0"

notes = \relative c'
{
  \key c \major
  c8 e g b8~ b2
}

% original key

\score { \notes }

% transpose up a minor 3rd
\score { \transpose c ees \notes }

% transpose down a minor 3rd & up an octave
\score { \transpose ees c' \notes }

% use transposition
% \score { \transposition ees \notes }