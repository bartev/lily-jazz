\version "2.19.80"

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

title = #"Sweet Georgia Brown"
composer = #"Bernie, Pinkard and Casey"
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
    enteredby = "Laurent Martelli"
    tagline = ##f
    % tagline = #tagline
    % head = #instrument    
    copyright = \copyright
}

Chords = \chordmode {
    \repeat "volta" 2 {
	d1*2:7 | d1*2:7 | 
	g1*2:7 | g1*2:7 | 
	c1*2:7 | c1*2:7 | 
	f1:maj | c:7.5+ | 
  f:maj  | e2:min7 a:7 |
	d1*2:7 | d1*2:7 | 
	g1*2:7 | g1:7 | a:7 |
	d:min7 | a:7 | d:min7 | a:7 |
	f2:maj e:7 | ees:7 d:7 | g:7 c:7 | f:7 e4:7 ees:7 |
    }
}

Tune = \relative f' {
    \time 4/4
    \key f \major

    \repeat "volta" 2 {
	d4 e fis d | 
  a' fis b a | 
  d2 a8 fis4 d8 ~| 
  d1 | 
  \break
	d4 e f! d | 
  a' f b! a | 
  d2 b8 a4 g8 ~ | 
  g1 | 
  \break
	c,4 d e c | 
  g' e a g  | 
  c2 g8 e4 c8 ~ | 
  c4 c8 d ~ d c d4 | 
  \break
	a'1 ~ | 
  a4 c,8 d ~ d c d4 | 
  a'2 ~ a8 a4. | 
  g a8 ~ a2 \bar "||" 
  \break
	
	d,4 e fis d | 
  a' fis b a | 
  d2 a8 fis4 d8 ~ | 
  d1 | 
  \break
	d4 e f! d | 
  a' f b! a | 
  d2 b8 a4 g8 ~ | 
  g2 a | 
  \break
	\repeat "unfold" 2 { 
          a4. a8 ~ a2 |
          g8 e4 a8 ~ a2 | 
          } 
  \break
	c,8 d4 f8 ~ f a4 c8 ~ | 
  c a cis d ~ d4 a | 
  % TODO FIX CODA
  % g2 c8 a4 f8 \toCoda ~ | 
  g2 c8 a4 f8 ~ | 
  f4 r r2 ~
  }
  % \coda ~ f1-\fermata \bar "|."
  f1 \bar "|."
}

\score {
  <<
    \new ChordNames \Chords
    \new Voice \Tune
  >>
  \layout {
    \override Score.Clef #'break-visibility = #'#(#f #f #f)  % make only the first clef visible
    \override Score.KeySignature #'break-visibility = #'#(#f #f #f)  % make only the first time signature visible
    \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
  }
}
% \midi { \tempo 4 = 160 }
