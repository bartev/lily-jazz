\version "2.20.0"

left = {
  \global
  % Music follows here
  \new ChordNames {
    %     http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides
    \override ChordNames.ChordName.extra-offset = #'(0 . 4.5)
    \chords_sugar_partial
    \chords_sugar
  }
}
