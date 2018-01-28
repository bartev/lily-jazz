\version "2.18.2"

% Lyrics to multiple staves
<<
  \relative c'' {
    \key f \major
    \time 6/8
    \partial 8
    c8 | c8([ bes]) a a([ g]) f | f'4. b, | c4.~ c4
  }

  \addlyrics {
    Let | flee -- cy flocks the | hills a -- | dorn, __
  }

  \relative c' {
    \key f \major
    \time 6/8
    \partial 8
    r8 | r4. r4 c8 | a'8([ g]) f f([ e]) d | e8([ d]) c bes'r
  }

  \addlyrics {
    Let | flee -- cy flocks the | hills a -- dorn,
  }
>>

