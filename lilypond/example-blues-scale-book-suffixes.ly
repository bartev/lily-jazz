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
  tagline = "Bartev J. Vartanian"
  piece =  "" }
\layout { indent = 10 }
\midi { \tempo 4 = 80 }

music = {
  \Key
  \bar "||" 
  c8 es f ges g bes c4
  \bar "||"
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

mychords-alto = \chordmode {
  c1:min7
  f:min7
  bes:min7
  ees:min7
  aes:min7
  des:min7
  ges:min7
  b:min7
  e:min7
  a:min7
  d:min7
  g:min7
}

% ############ Horns ############

% ------ Alto Saxophone ------
alto = \transpose ees c {
  \bar ".|"
  \relative c'' \music 
  \transpose c f { \relative c'' \music }
  \transpose c bes { \relative c' \music } \break
  \transpose c ees { \relative c' \music }
  \transpose c aes { \relative c' \music }
  \transpose c des { \relative c'' \music } \break
  \transpose c ges { \relative c' \music }
  \transpose c b { \relative c' \music }
  \transpose c e { \relative c'' \music } \break
  \transpose c a { \relative c' \music }
  \transpose c d { \relative c'' \music }
  \transpose c g { \relative c' \music } \break
  \bar "||"
}

altoSax = {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \clef treble
  <<
    \naturalize \alto
  >>
}

% ------ Trombone ------

trombone = {
  \global
  \set Staff.instrumentName = #"Trombone"
  \clef bass
  <<
    \transpose c c,, \melody
  >>
}

% ------ Piano --------
piano = {
  \set Staff.instrumentName = #"Piano"
  \clef treble
  <<
    \melody
  >>
}

% \new StaffGroup {
%   <<
%     \chords { \mychords }
%     \global
%     \new Staff = "piano" \piano
%     \mychords
%   >>
% }
% \markup { \sans "" }


\book {
  % \bookpart {
    \bookOutputSuffix "C"
    \header {
      subtitle = "C instruments (treble clef)"
      tagline = \subtitle
    }
    \score {
      \new StaffGroup 
      <<
        \chords { \mychords }
        \global
        \new Staff = "piano" \piano
        \mychords
      >>
    }
  % }
}

\book {
  % \bookpart {
    \bookOutputSuffix "C-bass"
    \header {
      subtitle = "C instruments (bass clef)"
      tagline = \subtitle
    }
    \score {
      \new StaffGroup 
      <<
        \chords { \mychords }
        \global
        \new Staff = "trombone" \trombone
        \mychords
      >>
    }
  % }
}

\book {
  % \bookpart {
    \bookOutputSuffix "alto-sax"
    \header {
      subtitle = "E flat instruments"
      tagline = \subtitle
    }
    \score {
      \new StaffGroup 
      <<
        \chords { \transpose ees c \mychords-alto }
        \global
        \new Staff = "alto" \altoSax
        \naturalize \transpose ees c \mychords-alto
      >>
    }
  % }
}