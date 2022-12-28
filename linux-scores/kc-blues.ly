\version "2.24.0"

#(set-global-staff-size 24)
\include "../stylesheets/jazzchords.ily"
\include "../stylesheets/lilyjazz.ily"
\include "../stylesheets/jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  %  paper-height = 11\in
  %  paper-width = 8.5\in
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"K.C. Blues"
composer = #"Charlie Parker"
meter = #"126"
copyright = #""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #6
          \override #'(offset . 15)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #3 \concat { #composer " " }
        }
      }
      s
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
  enteredby = "Omnibook"
  tagline = ##f
  % tagline = #tagline
  % head = #instrument
  copyright = \copyright
}

Chords = \chordmode {
       % s1 s1 s1 s1
       % a1*4:7
       a1:7 a:7 a:7 a:7
       d1:7 d:7 a:7 a:7
       b1:m7 e:7 a:7 e:7

       a1:7 d:7 a:7 e2:m7 a:7
       d1:7 d:7 a:7 a:7
       b1:m7 e:7 a:7 e:7

       a1:7 d:7 a:7  a:7
       d:7 d:7 a:7 cis2:m fis:7
       b1:m7 e:7 b2:m e2:7


}

Tune = \relative c'' {
  \time 4/4
  \key a \minor

  % \inlineMMR{r1 r1 r1} r2 r4 r8 a8
  e4. d16 cis d8 e r8 a, |
  e'8 e~ e d16 cis d8 e r8 a, |
  e'4. d16 cis d8 cis a g~ |
  \break
  g4 r4 r8 a8 e' e~ |

  e4. d16 c! d8 e r8. gis16( |
  a4.) g16 e \tuplet 3/2 {e8 c a} \tuplet 3/2 {ees'8 d c16 a} |
  \break
  cis8 a \tuplet 3/2 {e8 d e} \tuplet 3/2 {cis8 e a~}  a4~ |
  a4 r8 gis'8~ gis4 \tuplet 3/2 {fis8 c cis} |

  e8 d r4 r4 r8 \tuplet 3/2 {a'16 a a} |
  \break
  \tuplet 3/2 {ees'4 d c8 a} cis8. a16 \tuplet 3/2 {e8 d e} |
  cis8 a \tuplet 3/2 {g16 a g} e8 d e \tuplet 3/2 {cis8 e a~} |
  a4 r8 cis8~ cis4~ cis8 a16 cis \bar "||"

  \break

  e4 r4 r8 a,8 \tuplet 3/2 {cis8 e fis} |
  a8 fis r4 ees8 d \tuplet 3/2 {c8 a cis~} |
  \tuplet 3/2 {cis8 a e~} e4 r2 |
  \break
  r8 e'16 fis gis a bes g a fis! \tuplet 3/2 {g16 a g} fis!16 d bes aes |

  a16 fis \tuplet 3/2 {g16 cis d} d16 a b a c!4 r4 
  r2 c'8. gis16 a f fis d |

  \pageBreak

  ees4 r8 c16 cis e fis gis a b a gis! fis! |
  f16 fis a fis r4 r8 \tuplet 3/2 {gis32 a gis} fis16 e d cis b

  ais16 b cis ais! b cis! d e fis d b fis bes fis' \tuplet 3/2 { d16 bes fis} |
  % \break

  a16 fis gis fis' r8 cis8~ cis e16 ees d16 des b gis! |
  a16 f' d dis e8 cis~ cis4 r4
  r4 a'2~ a8 \tuplet 3/2 {b16 a gis} | \bar "||"
  % \break


  a8 e~ e4 r4 a8 a16 gis |
  \tuplet 3/2 {a4 e ees'8 d} c16 a cis8~ cis8 a |
  \tuplet 3/2 {e8 d e} cis8 a~ a4 r4 |
  % \break
  r8 b'8~ b2~ b8 a16 g |

  fis16 d b a e' d a fis c'8 d,~ d4 |
  r8 a''4. fis8 e cis gis |
  % \break
  b8 gis a e'~ e4 r8 gis16 fis |
  e8 cis gis e g ees' \tuplet 3/2 {c8 cis d~} |

  d4 r8 cis'16 a fis8 d b fis |
  % \break
  a8 fis gis f'~ f4. e16 d |
  \tuplet 3/2 {cis4 a a} a4 r4
  r8 a8~ a \tuplet 3/2 {b16 a gis} b8 a gis16 a b gis | \bar "||"
}

\score {
  <<
    \new ChordNames \Chords
    \new Voice \Tune
  >>
  \layout {
    \override Score.Clef.break-visibility = #'#(#f #f #f)  % make only the first clef visible
    \override Score.KeySignature.break-visibility = #'#(#f #f #f)  % make only the first time signature visible
    \override Score.SystemStartBar.collapse-height = #1  % allow single-staff system bars
  }
}

