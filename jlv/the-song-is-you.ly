\version "2.24.2"

#(set-global-staff-size 16)


%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord
\include "bv_definitions.ily"

%% Set up title
title = #"The Song Is You"
composer = #"Jerome Kern"
arranger = #"Alex Hahn solo"
transcribed = #"Bartev 2025-07"
meter = ""
instrument = \instrumentAlto

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"


%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

\paper {
  ragged-bottom = ##f
}

global = {
  \override Glissando.style = #'zigzag
}


% Define the chord progression
chordsAFirst = \chordmode {
  a1:maj7 | c:dim7 | b:m7          | e:7       |
  a1:maj7 | fis:7  | b:m7          | e:7       |
  cis1:m7 | fis:7  | b:m7          | e:7       |
  d1:m7   | g:7    | cis2:m7 fis:7 | b2:m7 e:7 | % different ending
}

chordsASecond = \chordmode {
  a1:maj7 | c:dim7 | b:m7 | e:7              |
  a1:maj7 | fis:7  | b:m7 | e:7              |
  cis1:m7 | fis:7  | b:m7 | e:7              |
  \repeat percent 3 a1:6  | dis2:m7.5- gis:7 | % turnaround ending
}

chordsB = \chordmode {
  \repeat percent 2 cis1:maj7 | ees:m7  | aes:7  |
  \repeat percent 2 cis1:maj7 | g:m7.5- | c:7.9- |
  \repeat percent 2 f1:m7     | \repeat percent 2 bes:7 |
  \repeat percent 2 ees1:7    | \repeat percent 2 aes:7 |
}

chordChanges = \chordmode {
  \chordsAFirst  % A1 (16 bars)
  \chordsASecond  % A2 (16 bars)
  \chordsB   % B  (16 bars)
  \chordsASecond  % A3 (16 bars) - same as A2
}

fourBars = { s1*4 \break }
sixteenBars = \repeat unfold 4 \fourBars

%% head is the original head
head = \relative c''' {
  \key a \major
  \mark "A"
  gis4 a a gis | gis4 a a gis | d1~ | d4 fis \tuplet 3/2 { fis4 f e } \break
  e4 fis fis e | e4 fis fis e | b1~ | b4 d \tuplet 3/2 { d4 b cis } \break
  e1~ | e4 cis d cis |  e1~ | e4 b cis b \break
  d1~ | d4 a b a | cis1~ | cis1 \break

  \mark "A"
  gis'4 a a gis | gis4 a a gis | d1~ | d4 r fis f8 e | \break
  e4 fis fis e | e4 fis fis e | b1~ | b4 r d cis8 e~ | \break
  e1~ | e4 r cis8 d e fis~ | fis1~ | fis4 e fis e \break
  a1~ | a1 | r1| r1 \break

  \mark "B"
  cis,4 gis' gis2~ | gis4 gis gis gis | gis4 fis fis2~| fis1 \break
  cis4 c' c2~ | c4 c c c | c4 ais ais2~ | ais1 \break
  c,4 gis' f2~ | f4 c \tuplet 3/2 { dis4 d cis } | c4 gis' f2~ | f4 c c c \break
  c4 dis dis2~ | dis4 dis dis dis | f4 gis gis2~ | gis4 gis gis gis \break

  \mark "A"
  gis4 a a gis | gis4 a a gis | d'1~ | d4 fis, \tuplet 3/2 { fis4 f e } \break
  gis4 a a gis | gis4 a a gis | a,1~ | a4 d \tuplet 3/2 { d4 b cis } \break
  e1~ | e4 cis d cis | fis1~ | fis4 e fis e \break
  a1 | r1 | r1 | r1 \break
}

%% Melody is what I'm transcribing
melody = \relative c''' {
  \key a \major
  \mark "A"
  \tempo 4=150
  gis4 a a gis
  gis4 a a gis
  d4. d8~ d2~
  d4 r4 r2
  \break

  r4 \tuplet 3/2 { fis4 f e } fis4
  e8 e fis4 fis e
  b4. b8~ b2~
  b4 cis8 cis d cis r e~
  \break

  e1~
  e4 cis8 cis d cis r e~
  e1~
  e4 b8 b cis b r d~
  \break

  d1~
  d4 a8 a b a r cis16 e
  cis1
  r1
  \break

  \mark "A"
  r1 | r1 | r1 | r1 | \break
  r1 | r1 | r1 | r1 | \break

  r4 cis8 cis d cis r e~
  e2. r4
  r4 cis8 cis d cis r8 fis~
  fis4 e fis e
  \break

  r4 cis, \glissando b'8 a gis a
  cis8 e fis g~ g4 fis8 d
  r8 fis, a cis b fis a b
  gis2 r
  \break

  \mark "B"
  \tempo 2=160
  r4 cis gis'4. gis8~
  gis2 gis4 gis
  gis8 fis r fis8~ fis2~
  fis2 f8 e ees d
  \break

  cis4 c' c2~
  c2 c4 c
  c8 bes r bes~ bes2~
  bes1
  \break

  c,4 gis' f2~
  f4 c \tuplet 3/2 { dis4 d cis }
  c4 gis' f2~
  f4 c c c
  \break

  c4 dis dis2~
  dis4 dis dis dis
  f4 gis gis2~
  gis4 gis gis gis
  \break

  \mark "A"
  gis4 a a gis
  gis4 a a gis
  d'1~
  d4 fis, \tuplet 3/2 { fis4 f e }
  \break

  gis4 a a gis
  gis4 a a gis
  a,1~
  a4 d \tuplet 3/2 { d4 b cis }
  \break

  e1~
  e4 cis d cis
  fis1~
  fis4 e fis e
  \break

  cis'8 gis f16 dis c'8 bes g ees bes'
  g8 gis f cis r gis' g fis
  f4 c8 cis gis4 \comp 1
  \comp 4
  \break
}

melodyTwo = {
  \mark "A"
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break

  \mark "A"
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break

  \mark "B"
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break

  \mark "A"
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
}

\score {
  <<
    \new ChordNames {
      \repeat unfold 2 \chordChanges
    }
    \new Staff \with {
      instrumentName = "Solo"
      shortInstrumentName = "Solo"
    } {
      \global
      \time 4/4
      \melody
      \melodyTwo
    }
    \new Staff \with {
      instrumentName = "Head"
      %% shortInstrumentName = "Head"
      \override NoteHead.color = #grey
      \override Stem.color = #grey
      \override StaffSymbol.color = #grey
      \override Beam.color = #grey
      \override Rest.color = #grey
      \override Flag.color = #grey
      \override Accidental.color = #grey
      \override Dots.color = #grey
    } {
      \global
      \time 4/4
      \head
    }
  >>
}

\pageBreak

%% Chords only
\score {
  <<
    \new ChordNames \chordChanges
    \new Staff {
      <<
        \chordChanges
        {
          \mark "A1" s1*8 \break s1*8 \break
          \mark "A2" s1*8 \break s1*8 \break
          \mark "B"  s1*8 \break s1*8 \break
          \mark "A2" s1*8 \break s1*8 \break
        }
      >>
    }
  >>
}
