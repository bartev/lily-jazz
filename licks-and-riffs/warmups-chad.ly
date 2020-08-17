\version "2.20.0"

% https://www.youtube.com/watch?v=hOQL9grV7Lw

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\header {
  title = "warm up exercises - chad"
  subtitle = "https://www.youtube.com/watch?v=hOQL9grV7Lw"
  tagline = # #f
}

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
      \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
      % avoid some layout problems. Also, moving it in between the title and
      % the page number, makes these be typeset left and right aligned, respectively.
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

global = {
  \key c \major
  \numericTimeSignature
  \time 4/4
}

warmup_one_chords = \chordmode { \repeat percent 4 { c1:maj c:maj } }
warmup_one = \relative c' {
  c8 d e f  g f e c
  d e f g  a g f d
  e f g a  b a g e
  f g a b  c b a f
  g a b c  d c b g
  a b c d  e d c a
  b c d e  f e d b
  c1
  \bar "||"
}

warmup_one_desc = \relative c'' {
  c8 d e f e d c a
  b c d e d c b g
  a b c d c b a f
  g a b c b a g e
  f g a b a g f d
  e f g a g f e c
  d e f g f e d b
  c1
  \bar "||"

}

% chromatic approach note
% watch out when have 1/2 step instead of full step in scale
warmup_two = \relative c' {
  c8 d e f  g f e cis
  d e f g   a g f dis
  e f g a b a g e
  f g a b c b a fis
  g a b c d c b gis
  a b c d e d c bes
  b c d e f e d b
  c1
  \bar "||"
}

warmup_two_desc = \relative c'' {
  c8 d e f e d c bes
  b c d e d c b gis
  a b c d c b a fis
  g a b c b a b e
  f g a b a g f ees
  e f g a g f e cis
  d e f g f e d b
  c1
  \bar "||"
}


warmup_three = \relative c' {
  c8 d e g  f e d c
  d e f a  g f e d
  e f g b a g f e
  f g a c b a g f
  g a b d c b a g
  a b c e d c b a
  b c d f e d c b
  c1
  \bar "||"  
}

warmup_three_desc = \relative c'' {
  c8 d e g  f e d c
  b c d f e d c b
  a b c e d c b a
  g a b d c b a g
  f g a c b a g f
  e f g b a g f e
  d e f a  g f e d
  c1
  \bar "||"
}

% scale enclosure exercise
% asc 1 2 3 5 4 approach next scale tone with 2 1/2 steps above and 1 1/2 step below
% desc 1 2 3 1 
warmup_four = \relative c' {
  c8 d e g  f e ees des 
  d e f a  g fis f ees
  e f g b  a g fis e
  f g a c  b a aes fis
  g a b d  c b bes aes
  a b c e  d cis c bes
  b c d f  e d cis b
  c1
  \bar "||"
}

% 1 2 3 1
% See video at https://www.youtube.com/watch?v=hOQL9grV7Lw
% 5:18
warmup_four_desc = \relative c' {
  c8 d e c 
  b c d b 
  a b c a
  g a b g
  f g a b
  e f g e
  d e f d
  c1
  \bar "||"
}


sec_one = {
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff {
    \global
    \warmup_one
    \break
    \warmup_one_desc
    }
  >>
}

sec_two = {
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff {
    \global
    \warmup_two
    \break
    \warmup_two_desc
    }
  >>
}

sec_three = {
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff {
    \global
    \warmup_three
    \break
    \warmup_three_desc
    }
  >>
}

sec_four = {
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff {
    \global
    \warmup_four
    \break
    \warmup_four_desc
    }
  >>
}

\score { \sec_one }
% \score {\transpose c f \sec_one}
% \score {\transpose c bes, \sec_one}
% \score {\transpose c aes \sec_one}
% \score {\transpose c ees \sec_one}
% \score {\transpose c cis \sec_one}
% \score {\transpose c fis \sec_one}
% \score {\transpose c b, \sec_one}
% \score {\transpose c e \sec_one}
% \score {\transpose c a \sec_one}
% \score {\transpose c d \sec_one}
% \score {\transpose c g \sec_one}

% \pageBreak
\score { \sec_two \header { piece="chromatic approach note" }}

\score { \sec_three \header { piece="1 2 3 5 -  4 3 2 1" }}
\score { \sec_four \header { piece="scale enclosure exercise" }}


\score {
  {
    \repeat unfold 5 { s1 \break }
  }
  \layout {
    % #(layout-set-staff-size 28)
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}
