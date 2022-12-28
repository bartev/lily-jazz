\version "2.24.0"

% this is my first score

\header {
  title = "My Score"
  subtitle = "for solo viola"
}

% use s/f instead if is/es for sharp/flat
\language "english"

ives = { c4 g f f }

\relative c'
{
  % crecsendo spanner "\<" (goes to next dynamic or termination "\!" )
  cs4\pp d8\< ef f g a4 \!
  % force bars with "[ ]"
  % stacatto "-."
  % accent "->"
  % add a fingering "-3"
  cs,4-3 d8([ ef f) g-.->] a4
  % add dynamic
  f16 g a e\ff a4 d f
  \time 3/2
  % markup text after "^"
  e2 ^"Intense" \ff b f
  \clef alto
  \numericTimeSignature \time 4/4
  % chord (duration outside of "< >"
  < c e> 1
  \ives | 
  \tuplet 3/2 { f8 g f } \tuplet 3/2 { f4 g f }
 }

% combine voices with angle brackets and separated them using
% 2 backslashes
% << { ... } \\ { ... } >>

\relative c'
{
  \tuplet 5/4 { e4 g c a fs }
       % Voice 1              % Voice 2
  << { g4 b8( g) a4 g } \\ { e4 c c8 f e4 } >> |
}