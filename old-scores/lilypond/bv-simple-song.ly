\version "2.24.0"

<<
  \relative c'' {
    \key g \major
    \time 6/8
    d4 b8 c4 a8 | d4 b8 g4 g8 |
    % note manual beaming  in the following line
    a4 b8 c([ b]) a | d4 b8 g4. |
  }

  \addlyrics {
    Girls and boys come | out to play,
    % could use slur, or here melismata (underscore)
    The | moon doth shine _ as | bright as day; |
  }
>>

  <<
    \relative c'' {
      \key g \minor
      \time 3/2
      g2 a bes | bes2( a) b2 |
      c4.( bes8 a4. g8 fis4.) g8 | fis1
    }

    \addlyrics {
      When I am | laid,
      am | laid __ in | earth,
    }
  >>

  % One word over multiple notes
  <<
    \relative c' {
      \key g \major
      \time 3/4
      \partial 4
      d4 | g4 g a8( b) | g4 g b8( c) |
      d4 d e | c2
    }
    \addlyrics {
      A -- | way in a __ | man -- ger,
      no __ | crib for a | bed, __
    }
  >>

  <<
    \relative c' {
      \clef "bass"
      \key c \major
      \time 6/8
      c4.~ c8 d b | c8([ d]) b c d b | c8
    }
    \addlyrics {
      Lar -- go_al fac -- | to -- tum del -- la cit -- | ta
    }
  >>

