\version "2.20.0"
%% \include "lilypond-book-preamble.ly"

%% https://lilypond.org/doc/v2.23/Documentation/notation/expressive-marks-attached-to-notes

%% stacatto, mordent, turn
\relative {
  c''4\staccato c\mordent b2\turn
  c1\fermata
}


% {
% ****************************************************************
% ly snippet contents follows:
% ****************************************************************
% \override Script.color = #(color 'vermillion)
% \override MultiMeasureRestScript.color = #(color 'blue)
% a'2\fermata r\fermata
% R1\fermata
% }

\relative { c''8 \breathe d e f g2 }


\fixed c' {
  \set breathMarkType = #'tickmark
  c2 \breathe d2
}


%% Falls and doits
\relative c'' {
  c2\bendAfter #+4
  c2\bendAfter #-4
  c2\bendAfter #+6.5
  c2\bendAfter #-6.5
  c2\bendAfter #+8
  c2\bendAfter #-8
}

%% Glissando
\relative {
  g'2\glissando g'
  c2\glissando c,
  \afterGrace f,1\glissando f'16
}

%% A contemporary glissando without a final note can be typeset using
%% a hidden note and cadenza timing.

\relative c'' {
  \time 3/4
  \override Glissando.style = #'zigzag
  c4 c
  \cadenzaOn
  c4\glissando
  \hideNotes
  c,,4
  \unHideNotes
  \cadenzaOff
  \bar "|"
}

%% Trills
\relative c'' {
  c2 \trill r2
  d1\startTrillSpan
  d1
  c2\stopTrillSpan
  r2
}

\relative c'' {
  d1\startTrillSpan
  d1
  b1\startTrillSpan
  d2\stopTrillSpan
  r2
}

\relative c'' {
  d1~\afterGrace
  d1\startTrillSpan { c32[ d]\stopTrillSpan }
  c2 r2
}

