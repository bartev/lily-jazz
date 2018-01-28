% Try to mimic the Real Book look
% http://leighverlag.blogspot.in/2015/12/mimicking-real-book-look.html

\layout {
% make only the first clef visible
\override Score.Clef #'break-visibility = #'#(#f #f #f)

% make only the first time signature visible
\override Score.KeySignature #'break-visibility = #'#(#f #f #f)

% allow single-staff system bars
\override Score.SystemStartBar #'collapse-height = #1
}

realBookTitle = \markup {
  \score {
    {
      \override TextScsript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup {
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontize #8
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \sans #title
          \fontsize #1 \lower #1 \concat { #composer " " }
          }
      }
      s
    }
    \layout {
    \once \override Staff.Clef.stencil = ##f
    \once \override Staff.TimeSignature.stencil = ##f
    \once \override Staff.KeySignature.stencil = ##f
    ragged-right = ##f
    \override TextScript.font-name = #"Pea Missy with a Marker"
    }
  }
}