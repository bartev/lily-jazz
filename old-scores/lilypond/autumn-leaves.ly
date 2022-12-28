\version "2.24.0"

date = #(strftime "%d-%m-%Y" (localtime (current-time)))

\header {
  % copyright = "copyright"
  title = "Autumn Leaves"
  subtitle = "Walking bass line"
  composer = "Seydou DIA"
  opus = \date
  tagline = ""
  % arranger = "arranger"
  % instrument = "instrument"
  % metre = "metre"
  % opus = "opus"
  % piece = "piece"
  % poet = "poet"
  % texidoc = "All header fields with special meanings."
  % copyright = "public domain"
  % enteredby = "jcn"
  % source = "urtext"
}
melody = \relative c {
    \clef "bass"
    \key bes \major
    \time 4/4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DOMINANT ONLY APPROACH      %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % A
    c2 g'       |f2 c2   |bes f'     |ees bes  |
    a  ees'     |d  a    |g   c      |g1       |
    c'2 g       |f  c'   |bes f'     |ees bes  |
    a  ees'     |d  a    |g c        |g1       |
    %B
    a2 ees      |d a'    |g d        |g,1      |
    c'2 g       |f c'    |bes f'     |ees  bes |
    %C
    a ees'       |d a     |g c        |f, bes   |
    ees, bes'    |a d,    |g c        | g1      |
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       SCALE ONLY APPROACH       %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % A
    c,4 d ees e  |f g a c     |bes a  g f |ees d c bes  |
    a bes c a   |d ees f fis |g f ees d  |c bes g d'    |
    c bes a g   |f g a f     |bes a g f  |ees' d c bes  |
    a bes c cis |d c bes a   |g a bes c  | d ees f ees  |
    % B
    a, g f ees' |d c bes a   |g a bes c  |d ees f g     |
    c bes a g   |f ees d c   |bes c d f  |ees d c bes   |
    % C
    a bes c cis | d ees f fis | g d' c g   | f c bes f' |
    ees f g bes |a g d a      | g a bes c  | d c bes g  |
}
harmonies = \chordmode {
  \time 4/4
  %A
  c1:m7   |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  c1:min7 |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  %B
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  c1:m7   |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  %C
  a1:dim7   |d1:7           |g2:m7 c2:7  |f2:min7 bes2:7  |       \break
  ees1:7    |a2:dim7 d2:7   |g1:m7       |g1:m7           |       \break
  %A
  c1:m7   |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  c1:min7 |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  %B
  a1:dim7 |d1:7  |g1:m7      |g1:m7      |  \break
  c1:m7   |f1:7  |bes1:maj7  |ees1:maj7  |  \break
  %C
  a1:dim7   |d1:7           |g2:m7 c2:7  |f2:min7 bes2:7  |       \break
  ees1:7    |a2:dim7 d2:7   |g1:m7       |g1:m7           |       \break
}
\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \melody
  >>
  \layout { }
  \midi { }
}