\version "2.24.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\header {
  copyright = "Scales"
  tagline = # #f
}

#(set-global-staff-size 24)

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


\score {
  <<
  \new Staff \relative c' {
    c8 d e f  g a b c
    d c b a   g f e d
    }
  >>
  \header {
  piece = "C major"
  }
}


\score {
  <<
  \new Staff \relative c' {
    c8 d ees f  g aes bes c
    d c bes aes   g f ees d
    }
  >>
  \header {
  piece = "C natural minor"
  }
}



\score {
  <<
  \new Staff \relative c' {
    c8 d ees f  g aes b c
    d c b aes   g f ees d
    }
  >>
  \header {
  piece = "C harmonic minor"
  }
}


\score {
  <<
  \new Staff \relative c' {
    c8 d ees f  g a b c
    d c bes aes   g f ees d
    }
  >>
  \header {
  piece = "C melodic minor"
  }
}

\score {
  <<
  \new Staff \relative c' {
    c8 ees f ges g bes c4
    
    }
  >>
  \header {
  piece = "C blues"
  }
}

\score {
  <<
  \new Staff \relative c' {
    c8 ees f g bes c8 r4
    c8 bes g f ees c8 r4
    }
  >>
  \header {
  piece = "C minor pentatonic"
  }
}


\score {
  <<
  \new Staff \relative c' {
    c8 d e g a c r4
    c8 a g e d c r4
    }
  >>
  \header {
  piece = "C major pentatonic"
  }
}

\score {
  <<
  \new Staff \relative c' {
    c8 d e fis gis ais c4
    b,8 des ees f g a b4
    }
  >>
  \header {
  piece = "C, B whole tone"
  }
}
