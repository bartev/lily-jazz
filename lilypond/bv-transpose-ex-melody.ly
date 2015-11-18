% Melody for c instrument
% Include key signature here

melody =  \relative c'' {
  \key c \major
  \time 4/4
    c4 d e f | g a b c | \bar "|."
}

piano  = {
  \clef treble
  <<
    \melody
    \harmony
  >>
}

alto =  {
  \clef treble
  \transpose es c \melody 
}

bari =  {
  \clef bass
  \transpose es c,, \melody
}

tenor = {
  \clef treble
  \transpose bes c' \melody
}

soprano = \transpose bes c {
  \clef treble
  \melody
}

text = {
  do re me fa | so la ti do |
}

harmony = \new ChordNames \with {
  \override ChordName #'font-size = #0
  \override ChordName #'font-name = #"lilyjazzchord"
} \chordmode {
  c2:7 g:m | d:maj cs:m7
}
