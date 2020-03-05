\version "2.20.0"

% this is my first score

% use s/f instead if is/es for sharp/flat
\language "english"

\header {
  title = "My Score"
  composer = "Composer"
  subtitle = "for solo viola"
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
  e2 b f
  \clef alto
  \numericTimeSignature \time 4/4
  c1
 }