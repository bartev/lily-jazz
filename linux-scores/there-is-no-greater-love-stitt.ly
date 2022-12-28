\version "2.24.0"

% ammons stitt version

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\include "there-is-no-greater-love.ly"

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=130

  % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1
}

tingl_stitt_music_partial = \relative c'' {
  \global
  \key g \major
  \partial 4*3 r8 fis8 g a r g~
}

tingl_stitt_music = \relative c''' {
  % \global
  % measure 1
  \bar ".|-|"
  \mark \markup{\small \with-color #red "14sec"}
  g4 fis e b
  d4 des c g8 b~
  b1~
  b4~ b8 bes16 b fis'4 f4

  \mark \markup{\small \with-color #red "21sec"}
  e2~ e4 r4
  e8 fis16 e dis8 e b'4~ b8 a8
  fis2 r2
  r8 b16 a g e d b d8   fis,8 g a\break

  \mark \markup{\small \with-color #red "28sec"}
  r8 g4 fis8 e4 r8 b8 
  d4. des8 c8 d e c 
  \tuplet 3/2 {b4 b b} r2
  r8 b8 d fis8~ fis4 d8 f


  \mark \markup{\small \with-color #red "35sec"}
  e2 r4 e8 fis 
  b4~ b8 a8 g4 fis8 a 
  g4 \mark \markup{\small \with-color #red "too low for alto"}
  \set Staff.ottavation = #"8vb" fis'8 g e d c b d 
  g,8~ g2 r4
  \unset Staff.ottavation
  r1 

  s1 s s s \break
  s1 s s s \break
  s1 s s s \break
  s1 s s s \break
  s1 s s s \break
  s1 s s s \break
  s1 s s s \break
}

tingl_stitt_score = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_tingl_partial
      \chords_tingl
    }
    \new Staff \with {
      instrumentName = "Alto-Stitt"
    } {
      \tingl_stitt_music_partial
      \tingl_stitt_music
    }
  >>
}

\tingl_stitt_score