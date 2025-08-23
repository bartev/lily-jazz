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
  \repeat percent 2 cis1:maj7 | dis:m7  | gis:7  |
  \repeat percent 2 cis1:maj7 | g:m7.5- | c:7.9- |
  \repeat percent 2 f1:m7     | \repeat percent 2 bes:7 |
  \repeat percent 2 dis1:7    | \repeat percent 2 gis:7 |
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
  bis4 dis dis2~ | dis4 dis dis dis | eis4 gis gis2~ | gis4 gis gis gis \break

  \mark "A"
  gis4 a a gis | gis4 a a gis | d'1~ | d4 fis, \tuplet 3/2 { fis4 f e } \break
  gis4 a a gis | gis4 a a gis | a1~ | a4 d, \tuplet 3/2 { d4 b cis } \break
  e1~ | e4 cis d cis | fis1~ | fis4 e fis e \break
  a1 | r1 | r1 | r1 \break
}

%% Melody is what I'm transcribing
melody = \relative c''' {
  \key a \major
  \mark "A"
  \tempo 4=150
  %% m1
  \timestop "0:00"
  gis4 a a gis
  gis4 a a gis
  d4. d8~ d2~
  d4 r4 r2
  \break

  %% m5
  \timestop "0.08"
  r4 \tuplet 3/2 { fis4 f e } fis4
  e8 e fis4 fis e
  b4. b8~ b2~
  b4 cis8 cis d cis r e~
  \break

  %% m9
  \timestop "0:16"
  e1~
  e4 cis8 cis d cis r e~
  e1~
  e4 b8 b cis b r d~
  \break

  %% m13
  \timestop "0:24"
  d1~
  d4 a8 a b a r cis16 e
  cis1
  r1
  \break

  \mark "A"
  %% m17
  \timestop "0:30"
  r1 | r1 | r1 | r1 | \break
  \timestop "0:38"
  r1 | r1 | r1 | r1 | \break

  %% m25
  \timestop "0:46"
  r4 cis8 cis d cis r e~
  e2. r4
  r4 cis8 cis d cis r8 fis~
  fis4 e fis e
  \break

  %% m29
  \timestop "0:54"
  r4 cis, \glissando b'8 a gis a
  cis8 e fis g~ g4 fis8 d
  r8 fis, a cis b fis a b
  gis2 r
  \break

  \mark "B"
  \tempo 2=160
  %% m33
  \timestop "1:01"
  r4 cis gis'4. gis8~
  gis2 gis4 gis
  gis8 fis r fis8~ fis2~
  fis2 f8 e ees d
  \break

  %% m37
  \timestop "1:05"
  cis4 c' c2~
  c2 c4 c
  c8 bes r bes~ bes2~
  bes2 f8 e ees d
  \break

  %% m41
  \timestop "1:08"
  cis4 gis' f2~
  f4 r ees8 r d cis
  c4 gis' f2~
  f4 r e8 ees d cis
  \break

  %% m45
  \timestop "1:11"
  c4 dis dis2~
  dis4 dis dis dis
  f4 gis gis2~
  gis1
  \break

  \mark "A"
  %% m49
  \timestop "1:15"
  gis4 a a gis
  gis4 a a gis
  d'2 d~
  d4 r fis, f
  \break

  %% m53
  \timestop "1:18"
  e4. fis8 fis4 e
  e4 fis fis8 e ees d
  a'2 a~
  a4 cis, d cis
  \break

  %% m57
  \timestop "1:22"
  e2 e~
  e4 cis d cis
  fis1~
  fis4 e fis e
  \break

  %% m61
  \timestop "1:25"
  cis'8 gis f16 dis c'8 bes g ees bes'
  g8 gis f cis \tuplet 3/2 { gis'?4 g fis }
  f4 c8 cis f ees c bes16 cis
  c8 ees \comp 1 c8 bes aes ees
  \break
}

melodyTwo = \relative c' {
  \mark "A"
  %% m65
  \timestop "1:28"
  e4. cis'8~ cis2
  r1
  e,4. d'8~ d2
  r1
  \break

  %% m69
  \timestop "1:32"
  e,4. e'8~ e2
  r2 e4-- fis-.
  e4. e,8~ e2
  r2 e'4-- fis-.
  \break

  %% m73
  \timestop "1:35"
  e4. e,8~ e2
  g'4-- fis-. e-- g-.
  fis4. d8~ d2
  d4-- e-. a-- g-.
  \break

  %% m77
  \timestop "1:38"
  f4. d8~ d2
  d4-- e-. f-- ees-.
  e4. e,8~ e2
  r1
  \break

  \mark "A"
  %% m81
  \timestop "1:41"
  r8 e fis a b a gis a
  cis8 \xNote c fis \xNote e g4-- fis8-- d-.
  r8 fis, a cis b fis a b
  gis4 g4. f8 e d
  \break


  %% m85
  \timestop "1:45"
  e8 f e d e f fis a
  b a gis a cis \xNote c fis \xNote e
  g4-- fis8-- d4.-- r4
  r4 r r r8 e8
  \break

  %% m89
  r8 e r des e4-. des-.
  e4-. e'4-. r r8 e,
  r8 e r des e4-. des-.
  e4-. cis' b cis8 a~
  \break

  %% m93%
  a2 r
  \comp 12 \break
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
      \override KeySignature.color = #grey
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
