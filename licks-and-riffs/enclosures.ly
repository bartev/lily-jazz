\version "2.20.0"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished
% \include "jazzchords.ily"
% \include "lilyjazz.ily"

\header {
  copyright = "lesson 2020-01-01"
  tagline = # #f
}

#(set-global-staff-size 25)

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
      #:music "lilyjazz"
      #:brace "lilyjazz"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 18)
      ))
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  indent = 0\cm
    }


% enclosures

\score {
  <<
  \new ChordNames \chordmode {
  c1 c1 c1
  c1 c1 c1
  c1 c1 c1
  s1 a2:m7 d:7 g1
  s1 a2:m7 d:7 g1
  s1 a2:m7 d:7 g1
  s1 a2:m7 d:7 g1
  }
  \new Staff \relative c'' {
  % \markup {enclose 3rd diatonically}
  d8 f e4~ e2
  dis8 f e4~ e2
  g8 f fis4~ fis2
  \break
  f8 dis e4~ e2
  dis8 f e4~ e2
  r8 dis8 f e~ e2
  \break
  f8 d dis e~ e2
  fis8 d f dis e2
  f8 dis4 e8~ e2
  \break
  r1 a,8 c e g fis e d c b1
  \break
  r2 r4 b8 gis a c e g fis e d c b1
  \break
  r1 a8 c e g e f fis ees d c b4~ b2
  \break
  r1 a8 c e g fis e d c a ais c ais b2
  }
  >>
  \header {piece="enclosures https://www.jazzadvice.com/how-to-effectively-use-enclosure/"}
}

\pageBreak

\score {
  <<
  \new ChordNames \chordmode {
  c1:7 f1:7 c1:7 c1:7
  f1:7 f1:7 c1:7 a1:7
  d1:min7 g1:7 c1:7 g1:7
  }
  \new Staff \relative c'' {
  dis8 f e4~ e2
  gis,8 bes a4~ a2
  dis8 f e4~ e2
  dis8 f e4~ e2
  \break
  gis,8 bes a4~ a2
  gis8 bes a4~ a2
  dis8 f e4~ e2
  a,8 b cis4~ cis2
  \break
  e,8 g f4~ f2
  ais8 c b4~ b2
  dis8 f e4~ e2
  ais,8 c b4~ b2
  }
  >>
  \header {piece="enclosures around 3rd - blues"}
}
