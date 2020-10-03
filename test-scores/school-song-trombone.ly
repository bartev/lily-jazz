\version "2.20.0"

#(set-global-staff-size 26)
\include "../stylesheets/lilyjazz.ily"
% \include "../stylesheets/jazzextras.ily"
% \include "../stylesheets/jazzchords.ily"

\paper {
  #(set-paper-size "letter")
%  paper-height = 11\in
%  paper-width = 8.5\in
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##t
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

% layout can be at the doc level, or at the score level
  \layout {
    % make only the first clef visible
    \override Score.Clef #'break-visibility = #'#(#f #f #f)

    % make only the first time signature visible
    \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

    % allow single-staff system bars
    % remove vertical bar at left of staff
    % \override Score.SystemStartBar #'collapse-height = #1
  }


title = "School Song"
composer = "Kasselman"
meter = #"allegro"
subtitle = "You're A Grand Old Flag"
% subsubtitle = "(another subtitle called subsubtitle)."
% arranger = "An Arranger"
% poet = "A Poet"


\header {
  title = \title
  subtitle = \subtitle
  % subsubtitle = \subsubtitle
  tagline = ##f
  composer = \composer
  % arranger = \arranger
  poet = "Trombone 1 - Areg"
  % copyright = "Coltrane's Sound"
}

melody = \relative c' {
  % \set Staff.instrumentName = "Trombone"
  \clef F
  \numericTimeSignature
  \key es \major
  \time 4/4

  %1
  \bar"||"
  r1 |
  r4 r bes\f g |
  es2-> es-> |
  es2-> c4 bes |

  es4 f2-> d4 |
  es2-> c4 bes | \break
  es2-> c4 bes |
  es2-> c4 bes |

  % 9
  d1-> ~ |
  d4 r bes c |
  d2-> es-> |
  f2.-> bes,4 | \break

  es2-> f-> |
  g2.-> es4 |
  f4 g2-> es4 |
  f4 g2-> es4 |

  % 17
  f1-> ~ |
  f4 r bes g | \break
  es2-> es-> |
  es2-> c4 bes |

  es4 f2-> d4 |
  es2-> d4 des |
  c2-> e4 g |
  c,2-> g'-> | \break

  % 25
  f1-> ~ |
  f4 r bes,2 |
  es2. d4 |
  es2 g |

  f2. e4 |
  f2 d4 bes | \break
  c4 es2-> c4 |
  es2-> d-> |

  % 33
  es1-> ~ |
  es4 r4 r2 | \bar"||"

}

\score  {  
  \new Staff { 
  \melody 

   % \layout { indent = 15 }
   }
  
}