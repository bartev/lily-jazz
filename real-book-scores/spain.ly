\version "2.19.80"

% Copy transcription by Kaz Takasugi at
% https://www.youtube.com/watch?v=sMg161bfeHg

#(set-global-staff-size 24)
\include "../stylesheets/jazzchords.ily"
\include "../stylesheets/lilyjazz.ily"
\include "../stylesheets/jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  between-system-space = 2.5\cm
  between-system-padding = #0
  indent = 0\mm
  page-breaking = #ly:minimal-breaking
  print-all-headers = ##f
  print-page-number = ##t
  print-first-page-number = ##f
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##t
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"Spain"
composer = #"Chick Corea"
meter = #""
copyright = #""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #8
            \override #'(offset . 7)
            \override #'(thickness . 6)
            \underline \larger \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
    }
  }
}


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

theNotes = \relative c''' {
  \key c \major
  \time 2/2
  \set Score.markFormatter = #format-mark-box-numbers
  % \partial 8 g8 |
  % \showStartRepeatBar \bar "[|:"
  \mark \default
  r8 c \noBeam b a g es4-- c8 |
  b a g d e4-- fis8 a |
  fis g a bes c a b e |
  r e cis4-. r2 | \break

  r8 e \noBeam cis bes e4-- cis8 bes |
  e4-- \noBeam  cis8 bes e cis r4 |
  r8 e cis bes e4-- cis8 b |
  e cis bes cis r cis a4( | \break
  
  a4) r a8 bes a aes |
  g a b d fis a b, g |
  e'4-. r r8 bes16( a) \noBeam bes8 c |
  des ees f g aes bes,4-- gis8 | \break

  a8 aes g f fis a cis e |
  d4-. r r2 |
  c8 bes b a' g4-. r |
  c,8 bes b a' g4-. r | \break

  cis,4-. aes8 bes r bes \noBeam aes bes |
  r bes \noBeam aes bes r bes \noBeam aes c |
  r c \noBeam g c( c2) |
  r2 r8 b8 \noBeam e fis | \break

  b,4-. r r8 a8 \noBeam \tuplet 3/2 {b e fis} |
  b,4-. r r2 |
  c8 b e b r2 |
  r1 | \break

  \mark \default
  b8 c b a g a b d |
  a8 c e g b, d fis a |
  c,8 e g b d, fis a a |
  r8 a \noBeam aes g( g4.) e8 | \break
  \repeat unfold 4 {r1} | \break

  r1 |
  r4 a8 aes g fis e d |
  cis e, g a bes c des ees |
  e fis g a bes c a g | \break

  fis a cis e d b g e |
  fis a e d( d4) r |
  \repeat unfold 2 {r1} \break

  r8 d' \noBeam cis b bes d c b |
  bes4-. r r16 bes8[ a16]( \noBeam a) g8.( |
  g2.) e16( d c b |
  bes cis e g) fis4-. r2 | \break

  r4 \tuplet 3/2 {r8 fis cis'} \tuplet 3/2 {b f c'} \tuplet 3/2 {b c c} |
  \tuplet 3/2 {b fis cis'} \tuplet 3/2 {b fis cis'} \tuplet 3/2 {b c c} c16 b fis' gis |
  \tuplet 3/2 {fis8 fis gis} \tuplet 3/2 {gis fis gis} \tuplet 3/2 {cis, cis b} \tuplet 3/2 {fis b e,} |
  e4 r r2 | \break

}

theChords = \chordmode {
  \repeat unfold 4 {g1:maj7.11+} 
  \repeat unfold 4 {fis:7.13-}
  \repeat unfold 2 {e:m7} \repeat unfold 2 {a:7}
  \repeat unfold 2 {d:maj7} \repeat unfold 2 {g:maj7.11+}
  \repeat unfold 2 {cis:7} \repeat unfold 2 {fis:7.13-}
  \repeat unfold 2 {b:min7} \repeat unfold 2 {b:7}

  \repeat unfold 4 {g:maj7.11+}
  \repeat unfold 4 {fis:7.13-}
  \repeat unfold 2 {e:m7} \repeat unfold 2 {a:7}
  \repeat unfold 2 {d:maj7} \repeat unfold 2 {g:maj7.11+}
  \repeat unfold 2 {cis:7} \repeat unfold 2 {fis:7.13-}
  \repeat unfold 2 {b:min7} \repeat unfold 2 {b:7}


}

\score {
  <<
    \new ChordNames \theChords
    \new Voice = soloist \theNotes
  >>
  \layout {
    \override Score.Clef #'break-visibility = #'#(#f #f #f)  % make only the first clef visible
    \override Score.KeySignature #'break-visibility = #'#(#f #f #f)  % make only the first time signature visible
    \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
  }
  \midi {
    \tempo 4 = 120
  }

}