\version "2.24.0"

\include "extras.ly"

movementI =  \relative c' { 
  \key f \major
  \time 12/8
  \set Score.rehearsalMarkFormatter = #format-mark-box-numbers
  \tempo 4. = 76

  % \mark \markup { Allegretto }
  % 1
  r2. r4 r8 f4\p\<(e8 |
  g4.--\>f\!) r4 r8 a4\<( g8 |
  bes4.--\> a4.^"vib."\!) r4 r8 a4\<( f'8) |
  f4\>( e8 d4.\!) r4 d8\<( f e d) |

  %5
  g4( e8 d4 c8 bes4 c8 d4 e8) |
  f4\<( c8) c( d a) c4.( c4 bes8) |
  a4.\> r4\! r8 r4 r8 f4( e8 |
  g4.-- f4.) r4 r8 a4(g8 |

  %9
  bes4.--\<_"cresc." a4.\!) r4 r8 a4( a'8) |
  a4.\<( g4 fis8 ees4. d4.) |
  bes'2.\mf\< r4 d,8\>( e4 f8) | 
  f4.( e\!) r4 c8( d4\< e8) |

  %13
  e4.( d\!) r4 bes8(\> c4 d8\!) |
  d4.(\< c bes a\!) |
  d,\mf->( d8) e_"dim"\>( fis g8 d' g a bes d) |
  d4.( c\!) r8 a,( c e f bes) |

  %17
  bes4.( a) r8 e,\p( f a c a') | 
  a4( g8 f4 d8) e4( d8 c4 e,8) |
  g4.( f) r4 r8 f4( e8) |

  g4.( f) r4 r8 f4( e8) |
  g4_"dim"( f8 g4 f8 g4 f8 g4 f8) |
  f4. r4 r8 f4. r4 r8 |

  R1.*2 |
  f'4.\p\<( ~ f8 e d\!  bes\> a g e d cis\! | 
  f'4.\p) r8 e\<( d bes a g \tuplet 3/2 { e16 f e} d8 cis \!|

  gis''4.\<) r8\! f8( d   bes a gis   f\< cis d |
  a''4.) r8\! gis8\<( bes a g f d a f\!) |
  f4.\f ~ f8( dis e) bes'4.->( a4) r8 |

  %30
  f'4.^"echo p" ~ f8( dis e) bes'4.->( a4) r8 | 
  r8 a\mf\<( g fis d a g f' es d bes f \! |
  es4.^\downarrow) r16^\downarrow bes'?\<( g es? bes? es? 
  g^\downarrow es? g bes? es? g \!
  bes8^\downarrow) a g |

  % 33
  fis4.^\downarrow r16^\downarrow c16(a fis? c fis? a^\downarrow fis? a c fis? a) 
  c8^\downarrow r8 \breathe a8 | \bar "||"
  \mark \default
  \time 9/8
  cis8^\downarrow\mf( d bes g4^\downarrow) r8 f4.^\downarrow\trill \grace { e16 f } |
  a8^\downarrow( bes g es4^\downarrow) r8 d4.^\downarrow\trill \grace { cis16 d } |
  c4.^\downarrow d4^\downarrow( bes8 a4.^\downarrow) |

  % 37
  f'8^\downarrow( ~ f16 d bes a g4.^\downarrow) r8^\downarrow e( f) | \bar "||"
  \time 12/8 
  aes4.\f r8 f aes des, f aes des f aes |
  g8->\<( ~ g16 aes bes g)_"Build!" e8->( ~ e16 f g e) bes8->( ~ bes16 c des bes) g8->( ~ g16 aes bes g) |

  % 40
  aes4.\! r8 f aes? des, f aes? des f aes |
  g16--\<^\downarrow^"Emphasize beat"( e g aes bes g)\! 
  e--\<^\downarrow( bes e f g e)\! bes?--\<^\downarrow( g bes c des bes?)\! 
  g--\<^\downarrow( e g aes bes? g)\! |

  % 42
  aes4.^\downarrow\< r16\!^\downarrow f16_"sub p"^\markup{ "D"\flat "maj" }\<( ges aes! bes! c  
  des->^\downarrow es f ges a bes? \!   c->\<^\downarrow des,! es! f ges! aes! \!\f |
  bes4_"sempre f"^\downarrow) bes,8( aes4^\downarrow) aes'8( c4^\downarrow) c,8( bes4^\downarrow) g8-- |

  % 44
  fis16\<^\downarrow( a) d a fis? a \!  g\<^\downarrow( bes) e bes g bes \!  
  a\<^\downarrow( c) fis c a c \!   bes\<^\downarrow( d) g d bes g \! |
  e4.^\downarrow->\< ~ e16^\downarrow( g bes? cis e g \!   bes,?^\downarrow\< cis? e g) bes8 \! ~ 
  bes^\downarrow \< a g \! |

  % 46
  f4-- \< r8 \! a4\>( g8 f4)\! r8 a4( g8 |
  f4.\p ~ f8 g es   d4. ~ d8 e c |
  bes4.) r8 d( c bes4.) r8 d'( c |
  bes4. ~ bes8 c aes g4. ~ g8 a f |
  e4.) r4 r8 cis,8\<( e g gis d' f)\! |

  % 51
  f4.->_"cres"\< ~ f8( e d   bes a g   es d c--)\! |
  g''4.^\downarrow-> ~ g8^\downarrow\<( f d \tuplet 3/2 { bes16^\downarrow c bes } a8 g f^\downarrow e d \!) |
  a''4->\f( gis8) e4->( d8) a4->( gis8) e4->( d8) |
  f8_"dim"^"poco rit."( e f)\> bes( a bes) d( cis d) f( e f)\!_"rit" |

  % 55
  \mark \default a,4.->\pp^"a Tempo"( gis) r4 r8 b4\<( a8 ) |
  c4.\>( b)\! r4 r8 b4\<( g'8)\! |
  g4->\>( f8 e4.)\! r4 e8(\< g f e)\! |

  a4\<( f8 e4 d8 c4 d8 e4 f8)\! |
  g4\<( d8) d( e bes)\! d4. ~ d4( c8)\> |
  bes4. r4\! r8 r4 r8 bes4\<( a8 |

  c4.-> b\>) r4\! r8 d4(\< c8 |
  e4.-> \> d)\! r4 r8 d4\<( b'8) |
  b4.\mf( a4 gis8 \< f4. e)\! |

  c'2. r4 d,8_"dim"( e4 f8) |
  f4.( e4.) r4 c8\<(d4 e8) |
  e4.\>( d)\! r4 bes8( c4 d8) |
  d4.\<( c bes a) |

  d,4.-> ~ d8\>( e fis g d' g a bes d)\! |
  d4.\p( c) r8 a,( c e f bes) |
  bes4.( a) r8 e,( f a c a') |
  a4( g8 f4 d8) e4( d8 c4 e,8) |

  g4.( f) r4 r8 f4( e8) |
  g4.( f) r4 r8 f4( e8) |
  g4( f8 g4 f8 g4 f8 g4 f8) |
  f4 r8 r4 r8 r2. |

  g'4\pp( f8 g4 f8 g4 f8 g4 f8) |
  g,4( f8 g4 f8 g4 f8 g4 f8) |
  c''4.( ~ c8 bes a) f4.( ~ f8 e d) |
  bes4.( a2. g4.) |

  r4 r8 f4_"sempre pp"\<( e8 g4.\> f)\!
  r4 r8 f4\<( e8 g4.\> f)\!
  r4 r8 c''4.\<\mf ~ c4( a8\! f4_"rit" c8 |
  a4\> f8 c'4 a8 f2.)\p\! |
  R1. ||
}
