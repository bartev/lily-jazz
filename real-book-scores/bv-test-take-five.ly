\version "2.24.0"


#(set-global-staff-size 22)
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
  top-margin = 0.5\in
  bottom-margin = 0.5\in
}

title = #"Take Five"
composer = #"-Paul Desmond"
meter = #""

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
  tagline = ##f
}

theNotes = \relative c' {
  \time 5/4
  \key ges \major
  \set Timing.beatStructure = #'(2 3)

  \partial 2 bes8 es ges aes |
  \bar "||"
  a8 bes a aes ges4 bes,( des) |
  es2. f16( ges f es des4) | \break

  es2. des16( es des bes aes4) |
  bes2. bes8 es ges aes |
  a8 bes a aes ges4 bes,( des) | \break

  es2. des16( es des bes aes4) |
  bes2. f'16( ges f es des4) |
  es2. ~ es4 r4 \bar "||" | \break

  % middle part
  es'8 ges4 es8 ces4 aes8 bes ces c |
  des8 f4 des8 bes4 ges8 aes a bes |
  ces8 es4 ces8 aes4 f8 ges aes a | \break 

  bes8 a bes ces des4 des8 c des d |
  es8 ges4 es8 ces4 aes8 bes ces c |
  des8 f4 des8 bes4 ges8 aes a bes | \break

  ces8 es4 ces8 aes4 f8 aes des ces |
  bes2. bes,8 es ges f \bar "||" |
  a8 bes a aes ges4 bes,( des) | \break

  es2. f16( ges f es des4) |
  es2. des16( es des bes aes4) |
  bes2. bes8 es ges aes | \break

  a8 bes a aes ges4 bes,( des) |
  es2. des16( es des bes aes4) |
  bes2. f'16( ges f es des4) | \break

  es2. r2 \bar "||" |
  \override TextScript.extra-offset = #'(2 . 4)
  s4-\markup {"Dave Brubek 'Time Out'"}
  s1
  s2.-\markup{"'Greatest Hits'"}
  s2
  
}

theChords = \chordmode {
  \time 5/4
  \partial 2 s2 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |

  % middle part
  ces2.:maj7 aes2:m6 |
  bes2.:m7 es2:m7 |
  aes2.:m7 des2:7 |

  ges2.:maj7 ges2:maj7 |
  ces2.:maj7 aes2:m6 |
  bes2.:m7 es2:m7 | 

  aes2.:m7 des2:7 |
  f2.:m7 bes2:7 |
  es2.:m bes2:m7 |

  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |

  es2.:m bes2:m7 |
  es2.:m bes2:m7 |
  es2.:m bes2:m7 |

  es2.:m s2 |

}

bv-take-five = 
\score {
  <<
    \new ChordNames \theChords
    \new Voice = soloist \theNotes
  >>
  \layout {
    % make only the first clef visible
    \override Score.Clef.break-visibility = #'#(#f #f #f)
    % make only the first time signature visible
    \override Score.KeySignature.break-visibility = #'#(#f #f #f)
    % allow single-staff system bars
    \override Score.SystemStartBar.collapse-height = #1
    \override LyricHyphen.thickness = #4
    \override Score.VoltaBracket.font-name = #"Pea Missy with a Marker"
  }
}
