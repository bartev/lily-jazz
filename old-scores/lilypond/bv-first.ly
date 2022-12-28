\version "2.24.0"

                                % set starting point at middle c
% simple whole, half, quarter, ... notes
\relative c'' {
  a1
  a2 a4 a8 a
  a16 a a a a32 a a a a64 a a a a a a a a2
}

% dotted quarter, eigth notes
\relative c'' {
  a4 a a4. a8
  a8. a16 a a8. a8 a4.
}

% Rests
\relative c'' {
  a4 r r2
  r8 a r4 r4. r8
}

% Add tempo markings
% Multiple time signatures
\relative c'' {
  \time 3/4
  \tempo "Andante"
  a4 a a
  \time 6/8
  \tempo 4. = 96
  a4. a
  \time 4/4
  \tempo "Presto" 4 = 120
  a4 a a a
}

% Multiple staves
\relative c' {
  \clef "treble"
  c1
  \clef "alto"
  c1
  \clef "tenor"
  c1
  \clef "bass"
  c1
}

% double bar, ending double bar
\relative c, {
  \clef "bass"
  \time 3/4
  \tempo "Slowly" 4 = 120
  c2 e8 c'
  \bar "||"
  g'2.
  f4 e d
  \bar "|."
  c4 c, r
}

% bar checks
\relative c'' {
g1 | e1 | c2. c'4 | g4 c | g e | c4 r r2 \bar "|."
}


% sharps and flats, (and doubles)
\relative c'' {
cis4 ees fisis, aeses
}

% add key signatures, naturals
\relative c'' {
\key d \major
a1 |
\key c \minor
a1 |
}


\relative c'' {
\key d \major
cis4 d e fis
}

% naturals and accidentals
\relative c'' {
\key aes \major
aes4 bes b bes
}

% ties
\relative c'' {
g4~ g c2~ | c4~ c8 a~ a2 | c4 (c8 a a2)
}

% slurs
\relative c'' {
d4( c16) cis( d e c cis d) e( d4)
}

% phrasing slurs
\relative c'' {
g4\( g8( a) b( c) b4\)
}

% articulations and dynamics
\relative c'' {
c4-^\ff  c-+\mf c-- c-!
c4->\< c-.\p\f  c2-_\pp
}

% fingerings
\relative c'' {
c4-3\< e-5 b-2 a-1\fff
}

% add text above and below
\relative c'' {
c2^"espr" a_"legato"
}

% partial measure
\relative c'' {
\partial 4 f8 g8 |
c2 d \bar "|."
}

% triplets (tuplets)
\relative c'' {
\tuplet 3/2 { f8 g a }
\tuplet 3/4 { c8 r c }
\tuplet 3/2 { f,8 g16[ a g a] }
\tuplet 3/2 { d4 a8 }
}

% multiple staves
\relative c'' {
<<
{ a2 g }
{ f2 e }
{ d2 b4 a4}
>>
}


% Simultaneous music expressions
% single staff, multiple notes
\relative c'' {
  c2 <<c e>> |
  << { e2 f } { cis4  r <<bes2 d>> } >> |
}


% Multiple staves
% start each piece of music with \new Staff before it
\relative c'' {
<<
\new Staff { \clef "treble" c4 }
\new Staff { \clef "bass" c,,4 }
>>
}

% Contexts:
% * Score
% * Staff
% * Voice

% * Lyrics
% * ChordNames
\relative c'' {
<<
\new Staff { \clef "treble" \key d \major \time 3/4 c4 }
\new Staff { \clef "bass" c,,4}
>>
}