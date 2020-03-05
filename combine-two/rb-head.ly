\version "2.20.0"

title = #"My Fancy Title"
composer = #"Joe Composer"
meter = \markup{ (Up) }
copyright = #"Don't copy me"


realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #7
            \override #'(offset . 7)
            \override #'(thickness . 6)
            \underline \larger #title
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

\displayScheme
\realBookTitle

\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

% \displayLilyMusic
\displayMusic
\relative c'' { c8 d e f g f e c }