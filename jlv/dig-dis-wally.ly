\version "2.24.2"

\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

fall = \bendAfter #-4

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
title = #"Dig Dis"
composer = #"Hank Mobley"
arranger = #"Bartev"
transcribed = #"Bartev 2026-08"
meter = "148"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

global = {
  %% \tempo 4=146
  \time 4/4
  \key c \major
}

% Define the chord progression

chordsIntro = \chordmode { s2 }
chordsA = \chordmode {
	c1:7 | f:7 | c:7 | g2:m7 c:7
	\repeat percent 2 f1:7 | c1:7 | a1:7
	d1:m7 | g:7 | c:7 | d2:m7 g:7
}

chordChanges = \chordmode {
	%% \chordsA
  \blueChord { \chordsA}  % A (8 bars)
  %% \greenChord {\chordsB}  % B (8 bars)
  %% \redChord {\chordsC}  % C (8 bars)
  %% \blueChord {\chordsASec}  % A (diff last bar)
}

introTenor = \relative c'' {
	\markRedBox "Head"
	\partial 2
	r8 c ees4
}
melodyTenor = \relative c''' {
  \bar "||"
	%% m1
  \timestop "0:40"
  g4 r r ees
  f8 ees r4 r8 c ees f
  \acciaccatura fis8 g4 \acciaccatura fis!8 g4 \tuplet 3/2 { ges8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

	%% m5
  \timestop "0:47"
  f4 r r g8 ees
  f8 f r4 r8 c ees f
  \acciaccatura fis8 g4 \acciaccatura fis!8 g4 \tuplet 3/2 { ges8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% m9
  \timestop "0:53"
  f4 r r ees
  f4 r \tuplet 3/2 { f8 ees c } bes4
  c4 r r r
  r2 r8 c ees4
	\bar "||"
	\break

	\markRedBox "Chorus 2"
	%% m13
  \timestop "1:01"
  g4 r r ees
  f8 ees r4 r8 c ees f
  \acciaccatura fis8 g4 \acciaccatura fis!8 g4 \tuplet 3/2 { ges8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% 17
  \timestop "1:07"
  f4 r r g8 ees
  f8 f r4 r8 c ees f
  \acciaccatura fis8 g4 \acciaccatura fis!8 g4 \tuplet 3/2 { ges8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% m21
  \timestop "1:14"
  f4 r r ees
  f4 r \tuplet 3/2 { f8 ees c } bes4
  c4 r r r
  r2 r8 c \tuplet 3/2 { e8 g a }
  \bar "||"
  \break

	\pageBreak

  \markRedBox "Solo 1"
  %% m25
  \timestop "1:21"
  c4 c8 d  bes g r g
  a4 c8 aes\fall r2
  r8 c16 b bes8 a g f e d
  c8 b bes16 c e g a8 g r4
  \break

  %% m29
  \timestop "1:28"
  r8 c,16 d f8 g aes a bes b
  c8 a f d ees \fall r8 r4
	r8 b'~ b16 bes a aes g8 f e d
  %% r8 bes'~ bes4 \grace {a16 aes} g8 f e d
  \tuplet 3/2 { cis8 e g } bes a r2
  \break

  %% m33
  \timestop "1:34"
  r8 e' d a e d r4
  r8 ees' des aes ees des r4
  r8 d'16 des c8 b bes a g ges
  f8 c' a f e d r4
  \break
  \bar "||"

	\markRedBox "Solo 2"
  %% m37
  \timestop "1:40"
  r8 c ees f \acciaccatura fis8 g4 \acciaccatura fis!8 g4
  \acciaccatura fis8 g4~ \tuplet 3/2 { g8 f ees } c8 ees r4
  r8 c ees f \acciaccatura fis8 g2
  \acciaccatura fis8 g4~ \tuplet 3/2 { g8 f ees } c8 c r4
  \break

  %% m41
  \timestop "1:48"
  \tuplet 3/2 { r8 a c } \tuplet 3/2 { ees8 g a } \tuplet 3/2 { d4 d d }
  d4 a8 ees r2
  r8 c ees f g bes r g
  \tuplet 3/2 { ges8 f ees } c8 c r2
  \break

  %% m45
  \timestop "1:54"
  r8 cis8 d16 e f g a8 d, r4
  r8 bes8 d16 e f g bes8 ees, r4
  r8 e~ \tuplet 3/2 { e16 g a } c8 f,4~ \tuplet 3/2 { f16 g a } c8
  fis,4~ \tuplet 3/2 { fis16 g a } c8 g4 c8 d
  \break
  \bar "||"

	\pageBreak

	\markRedBox "Solo 3"
	%% m49
  \timestop "2:00"
  c4 c2 r8 ees
  c8 c r4 r a
  c4 c8-. r r c16 b bes8 a
  g8 f e16 g bes d c4~ c8 bes?
  \break

  %% m53
  \timestop "2:08"
  a4 f8 r r c16 f \tuplet 3/2 { a8 c d }
  ees4 d8 ees16 d c8 bes g f
  e4~ e8 c'~ c4 r
  r8 bes16 a g8 f e d des a
  \break

  %% m57
  \timestop "2:15"
  d4 a' f8 d r a
  des8 a c4 b~ b8 d16 a'
  g8 f e d c r r4
  r4 r8 c f4~ f8 e
  \break
  \bar "||"

	\markRedBox "Solo 4"
  \timestop "2:22"
  %% m61
  c8 c r4 r8 c f \acciaccatura { g16 f } e8
  c8 c r c f e c a
  c2 r8 c e16 g bes d
  c8 b bes a g \acciaccatura { a16 g } e8 ees des
  \break

  %% 65
  \timestop "2:28"
  \tuplet 3/2 { c8 r c } \tuplet 3/2 { ees c ees } \tuplet 3/2 { g ees g } \tuplet 3/2 { b g b }
  d4~ d8 \tuplet 3/2 { b16 g ees } b2
  r4 r8 e32 g b d c8 b a aes
  g8 f e d des bes' a e
  \break

  %% 69
  \timestop "2:35"
  g4 a8 f~ f4~ \tuplet 5/2 { f8 e d c a }
  e'4 f8 d~ d4 r8 a
  d8 ees16 d a8 g c2
  r4 a' c8 d c a
  \break
  \bar "||"

	\pageBreak

	%% 73
	\timestop "2:41"
	c4 r e, r
  f4 r ges r
  \acciaccatura {a16 aes} g4 c e8 ees e r
  c4 c f8 ees c bes
  \break

	\markRedBox "Solo 5"
	%% m77%
	\timestop "2:48"
	c4 r4 r8 c ees f
	fis8 f ees c d c d c
	bes8 g bes g
  \comp 6 \break
  \comp 16 \break
	\comp 16 \break

	\markRedBox "Solo 6"
  \comp 16 \break
  \comp 16 \break
	\comp 16 \break

	\pageBreak
}

\score {
  <<
    \new ChordNames {
      \chordsIntro
      \repeat unfold 8 \chordChanges
    }
    \new Voice = soloist {
      \global
      \introTenor
      \melodyTenor
    }
  >>
}
