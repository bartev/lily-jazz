\version "2.19.31"

\include "bv-jazz-settings.ly"
\include "naturalize.ly"

% \include "equinox-bv-notes.ly"
% \include "bv-bill-evans-header.ly"

%%%%%%%%%%%% Keys'n'thangs %%%%%%%%%%%%%%%%%

global = { 
  \time 4/4 
}

Key = { \key c \minor }

%%%%%%%%%%%% Headers %%%%%%%%%%%%%%%%%

\header { 
  title = "Blues Scales"
  % subtitle = "C - instruments"
  % composer = "'Trane"
  meter = ""
  tagline = "C - instruments"
  piece =  "" }
\layout { indent = 0 }
\midi { \tempo 4 = 80 }

music = {
  \Key
  \bar "||" 
  c8 es f ges g bes c4
  \bar "||"
}

chord-c = \chordmode {
  c1:min7
}

melody = {
  \bar ".|"
  \relative c' \music 
  \transpose c f { \relative c' \music }
  \transpose c bes { \relative c' \music } \break
  \transpose c ees { \relative c' \music }
  \transpose c gis { \relative c' \music }
  \transpose c cis { \relative c' \music } \break
  \transpose c fis { \relative c' \music }
  \transpose c b { \relative c' \music }
  \transpose c e { \relative c' \music } \break
  \transpose c a { \relative c' \music }
  \transpose c d { \relative c' \music }
  \transpose c g { \relative c' \music } \break
  \bar "||"
}

mychords = \chordmode {
  c1:min7
  f:min7
  bes:min7
  ees:min7
  gis:min7
  cis:min7
  fis:min7
  b:min7
  e:min7
  a:min7
  d:min7
  g:min7
}

% ############ Horns ############

% ------ Alto Saxophone ------
alto = \transpose c es {
  \relative c' \music 
  \transpose c f { \relative c'' \music }
  \transpose c bes { \relative c'' \music }
  \transpose c ees { \relative c'' \music }
  \transpose c aes { \relative c'' \music }
  \transpose c des { \relative c'' \music }
  \transpose c ges { \relative c'' \music }
  \transpose c ces { \relative c'' \music }
  \transpose c fes { \relative c'' \music }
  \transpose c gis { \relative c'' \music }
  \transpose c g { \relative c'' \music }

}

altoSax = {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \clef treble
  <<
    \naturalizeMusic \alto
  >>
}

% ------ Trombone ------

tbone = { 
  \melody
}

trombone = {
  \global
  \set Staff.instrumentName = #"Trombone"
  \clef bass
  <<
    \tbone
  >>
}

% ------ Piano --------
pi-no = {
  \melody
}

piano = {
  \set Staff.instrumentName = #"Piano"
  \clef treble
  <<
    \pi-no
  >>
}

\new StaffGroup <<
  \chords { 
    % \set minorChordModifier = \markup { "-" }
    \mychords 
  }
  \global
  \new Staff = "piano" \piano
  % \new Staff = "alto" \altoSax
  % \new Staff = "trombone" \trombone
  \mychords
>>
\markup { \sans "" }


\book {
  \bookpart {
    \header {
      subtitle = "C instruments"
    }
    \score {
      \new StaffGroup <<
        \chords { 
          \mychords 
        }
        \global
        \new Staff = "piano" \piano
        \mychords
      >>
      \markup { \sans "" }
    }
  }
  \bookpart {
    \header {
      subtitle = "Alto Sax (E flat instrument)"
    }
    \score {
      \new StaffGroup <<
        \chords { 
          \mychords 
        }
        \global
        \new Staff = "alto" \altoSax
        \mychords
      >>
      \markup { \sans "" }
    }
  }
}