\version "2.18.2"

% this is my first score

% use s/f instead if is/es for sharp/flat
\language "english"

\header {
  title = "My Score"
  subtitle = "for solo viola"
  instrument = "alto sax"
}


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
 }