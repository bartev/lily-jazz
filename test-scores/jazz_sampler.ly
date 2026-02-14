\version "2.24.0"

%% Updated bjv 2025-07-21

#(set-global-staff-size 20)

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
title = #"Jazz Sampler"
composer = #"A Compser"
arranger = #"An Arranger"
transcribed = #"Some dude"
meter = "allegro"
instrument = ""

subtitle = "A Subtitle"
subsubtitle = "(Another subtitle called subsubtitle)"
poet = "A Poet (in header)"
tagline = \bvTaglineDateTime
copyright = #"copyright-Bartev 2025"


%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

\paper {
  between-system-space = 0.5\cm
  between-system-padding = #0
}

\header {
  title = \realBookTitle
  subtitle = \subtitle
  subsubtitle = \subsubtitle
  tagline = ##f
  %% arranger = \arranger
  poet = \poet
}


\score {
  \new StaffGroup <<
    \new Staff
    \relative c' {
      \set countPercentRepeats = ##t
      \key bes \major
      \numericTimeSignature
      \tempo 4 = 60
      \repeat percent 7 {
        <f bes d>4
        <f bes d> 4
        <g bes ees>4
        <g bes ees>4
      }
      \break
      \relative c''
      \repeat percent 2 {
        \ottava #1
        \set Staff.ottavation = "8a Alta - other text"
        <f bes d>4 \mp \< <f bes d>4 <g bes ees>4 <g bes ees>4 \! |
        <aes bes f>4 \mf \>
        \ottava #0
        <aes, bes f>4 <g bes ees>4 <g bes ees >4 \! |
      }
      s
    }
    \new Staff {
      \set countPercentRepeats = ##t
      \clef F
      \numericTimeSignature
      \key bes \major
      \repeat percent 7 {
        <f bes d>4 <f bes d>4 <g bes ees>4 <g bes ees>4 |
      }
      \repeat percent 2 {
        <f bes d>4 <f bes d>4 <g
                               bes ees>4 <g bes ees>4 |
        <aes bes f>4 <aes bes f>4 <g bes ees>4 <g bes ees >4|
      }
      s
    }
  >>
  \header {
    title = "2nd Title (in score)"
    piece = "A Piece to Play (in score)"
    opus = "Op.2 (in score)"
  }
  \layout {
    ragged-last = ##f
    \context {
      \Score
    }
  }
}

\score {
  <<
    \new ChordNames
    \chordmode {
      d1:7 s c:7/d s
    }
    \new Voice \with { \consists "Pitch_squash_engraver" } {
      \set Staff.instrumentName = "Guitar"
      \clef "G_8"
      \key d \major
      \mark \markup "(Bright Latin)"
      \numericTimeSignature
      \set fingeringOrientation = #'(left)
      \bar "[|:-|" % Left side repeat
      \improvisationOn
      \repeat volta 2 {
        \override Voice.Stem.stencil = ##f
        \repeat unfold 4 { c4 }
        \revert Voice.Stem.stencil
        \comp 8
      }
      \alternative {
        {
          c4 c
          \improvisationOff
          r8 <d' -1\3>4 <cis' -4\4>8
          \bar ":|]"
        }
        { d'1 }
      }

    }
    >>
}
