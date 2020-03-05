\version "2.20.0"

movementII =  \relative c' { 
  \key bes \major
  \time 2/2
  \set Score.markFormatter = #format-mark-box-numbers

  \partial 2 f'8( bes ) d,( f ) |

  %1
  bes,2 d8( f ) bes,( d ) |
  f,2 bes8( d f g |
  f8 d bes g f4 ) c |
  \break

  %4
  es4( d ) f8 bes d, f |
  bes8 d f bes d4 r4 |
  r2 a,8 c f, a |
  c8 f a c es4 r4 |
  \break

  %8
  r2 f,4( e8 d ) |
  f4( e8 d ) f4( e8 d ) |
  bes'4( a8 g ) a4( g8 f ) |
  e8( f e f g4 ) cis, |
  \break
  
  %12
  d2 f8( aes ) d,( f) |
  b,2 d8( f ) bes,( d ) |
  gis,2 a8( c e f |
  e8 c a a' gis a ais b |
  \break

  %16
  c4 ) r4 a8( c ) fis,( a ) |
  dis,2 fis8( a ) dis,?( fis? ) |
  c2 c8( e g a |
  g8 e c a g f e d |
  \break

  %20
  e4 ) r4 e8 g c, e |
  g8 c e g c4 r4 |
  r2 fis,,8 a d, fis |
  a8 d fis a d4 r4 |
  \break

  % 24
  r2 aes4( g |
  f4 es des es8 c |
  bes4 aes) bes'(a! |
  g4 fis es? fis8 d |
  \break

  %28
  c4 bes) g'( f8 e |
  g4 f8 e g4 f8 es) |
  c'4( bes8 a g4 f8 es) |
  d8( f bes bes,) d4 \tuplet 3/2 {c8( d c)} |
  \break

  %32
  bes2 \mark \default \bar "||" c'8 f,, c''4 ~ |
  c8 f,, c''4 ~ c8 f,, c''4 ~ |
  c4 r4 \tuplet 3/2 {c,8( d es} \tuplet 3/2 {f g aes} |
  \tuplet 3/2 {g8 aes g} \tuplet 3/2 {f es d} c4) \tuplet 3/2 {d8( c d} |

  %36
  es4) r4 c'8 f,, c''4 ~ |
  c8 f,, c''4 ~ c8 f,, c''4 ~ |
  c4 r4 \tuplet 3/2 {c,8( des es} \tuplet 3/2 {f g aes} |
  \tuplet 3/2 {g8 aes g} \tuplet 3/2 {f es des} c4) \tuplet 3/2 {des8( c des} |
  \break

  %40
  es4) r des( bes' |
  aes4 c, bes f' |
  es4 g, f des'~ |
  des8 c es des c4 bes |
  \break

  f'2) fis8 dis b fis |
  gis2 gis'8 eis b gis |
  ais2 bes,?8( d f bes |
  c8 bes es g aes f es d |
  \break

  es4) r c'8 f,, c''4 ~ |
  c8 f,, c''4 ~ c8 f,, c''4~ |
  c4 r4 \tuplet 3/2 {c,8( des es} \tuplet 3/2 {f g aes} |
  \tuplet 3/2 {g8 aes g} \tuplet 3/2 {f es des} c4) \tuplet 3/2 {des8( c des} |
  \break

  d2)

}
