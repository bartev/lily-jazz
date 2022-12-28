\version "2.24.0"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished
\include "jazzchords.ily"
% \include "lilyjazz.ily"
\include "roman_numeral_analysis_tool.ily"

\header {
  title = "Jazz Lick Daily"
  copyright = "lesson 2020-08-26"
  tagline = # #f
}

% #(set-global-staff-size 20)

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
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " 
      \if \should-print-page-number
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \if \should-print-page-number
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

\layout {
  \context { 
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}



i_chords = \chords { s8 c2 a:m7 d:m7 g:7 c1 }
i_notes = \new Staff \relative c'' {
  \partial 8 { e8 }
  f8 g e d c b d b
  c8 g e c ees b' a aes
  g r8 r4 r2
  }
i_analysis = \new Lyrics \lyricmode {
  \partial 8 { ""8 }
  \markup \rN { I }2
  \markup \rN { vi - 7 }
  \markup \rN { ii - 7 }
  \markup \rN { V 7 }
  \markup \rN { I }
}
\score {
  \transpose c c <<
    \i_analysis
    \i_chords
    \i_notes
  >>
  \header { piece="#1 - turnaround - Charlie Parker - http://www.youtube.com/watch?v=P-ZoZ3BeQ2U&t=3m52s" }
}

ii_chords = \chords { s4 d1:m7 g:7 c:maj7 }
ii_notes = \new Staff \relative c'' {
  \partial 4 { f8 cis }
  e8 d a f dis e g ges
  f8 g a c e c f e
  c8 g f dis e c' r4
  }
ii_analysis = \new Lyrics \lyricmode {
  \partial 4 { ""4 }
  \markup \rN { ii - 7 }1
  \markup \rN { V 7 }
  \markup \rN { I maj 7 }
}
\score {
  \transpose c c <<
    \ii_analysis
    \ii_chords
    \ii_notes
  >>
  \header { piece="#2 ii-V-I Chris Potter - https://www.youtube.com/watch?v=8FWPJE8ASh4=0m21s" }
}

iii_chords = \chords { s4 d1:m7 g2..:7 c:maj7 }
iii_notes = \new Staff \relative c' {
  \partial 4 { r8 e8 }
  f8 g a b cis d e cis?
  d8 e f g bes4 aes8 g
  r1
  }
iii_analysis = \new Lyrics \lyricmode {
  \partial 4 { ""4 }
  \markup \rN { ii - 7 }1
  \markup \rN { V 7 }
  \markup \rN { I maj 7 }
}
\score {
  \transpose c c <<
    \iii_analysis
    \iii_chords
    \iii_notes
  >>
  \header { piece="#3 ii-V-I Roy Hargrove - https://www.youtube.com/watch?v=Pt9_2lwlyjk=2m04s" }
}


iv_chords = \chords { d1:m7 g:7 c:maj7 }
iv_notes = \new Staff \relative c''' {
  c8 a b a g ges f a
  e8 d cis d g ees b g
  f8 dis \tuplet 3/2 { e8 g b } d8 c b c
  e4 r4 r2
  }
iv_analysis = \new Lyrics \lyricmode {
  \markup \rN { ii - 7 }1
  \markup \rN { V 7 }
  \markup \rN { I maj 7 }
}
\score {
  \transpose c c <<
    \iv_analysis
    \iv_chords
    \iv_notes
  >>
  \header { piece="#4: ii-V-I Seamus Blake - https://www.youtube.com/watch?v=xiMm4QJ7mLQ=2m21s" }
}

xii_chords = \chords { c1:m7 }
xii_notes = \new Staff \relative c'' {
  c8 b c d ees d ees? f
  fis8 g aes fis? g ees d c
  f4. d8 ees g, a b
  d8 b c r8 r2
  }
\score {
  \transpose c c <<
    \xii_chords
    \xii_notes
  >>
  \header { piece="#12: minor7 chord - Dexter Gordon - https://www.youtube.com/watch?v=hkyJQcmVtZQ&t=1m29s" }
}

xiii_chords = \chords { d1:m7.5- g:7.9-.13- c:m7 }
xiii_notes = \new Staff \relative c'' {
  r8 g8 \tuplet 3/2 { aes c ees } g8 r8 aes8 f~
  f4. ees8 g d~ d4
  f4 \tuplet 3/2 { d8 ees b } d8 c g ees
  \tuplet 3/2 { d8 ees d } c8 ees~ ees4 r4
  }
xiii_analysis = \new Lyrics \lyricmode {
  \markup \rN { ii h }1
  \markup \rN { V 7 }
  \markup \rN { i - 7 }
}
\score {
  \transpose c c <<
    \xiii_analysis
    \xiii_chords
    \xiii_notes
  >>
  \header { piece="#13:minor ii-V-i - ChetBaker - https://www.youtube.com/watch?v=3zrSoHgAAWo&t=1m11s" }
}

lxi_chords = \chords { 
    ges2:maj7 ees:7 aes:min7 des:7.9- ges1:maj7
  }
lxi_notes = \new Staff \relative c' {
    f8 aes ges f ees b' g ees
    bes'8 ges ees ces a' f d b
    bes8 des ees4-. ges r4
  }
lxi_analysis = \new Lyrics \lyricmode {
  \markup \rN { I 7 }2
  \markup \rN { VI 7 }
  \markup \rN { ii - 7 }
  \markup \rN { V 7f9 }
  \markup \rN { I 7 }
}
\score {
  \transpose ges g <<
    \lxi_analysis
    \lxi_chords
    \lxi_notes
  >>
  \header { piece="#61 - turnaround - Chet Baker" }
}

lx_chords = \chords { f:7 }
lx_notes = \new Staff \relative c' {
    r8 f8 a c ees g d\turn c
    f8 d ees f g a bes c
    d4-- c8-. bes-- a g f\turn e
    ees8 g d\turn c f4 r4
  }

\score {
  \transpose f f <<
    \lx_chords
    \lx_notes
  >>
  \header { piece="#66 - Hank Mobley over dom 7 chord" }
}