\version "2.24.0"

#(set-global-staff-size 22)
\include "jazzextras.ily"
\include "jazzchords.ily"
\include "lilyjazz.ily"

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
  % oddHeaderMarkup = \markup
  %   \fill-line {
  %     \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
  %     % avoid some layout problems. Also, moving it in between the title and
  %     % the page number, makes these be typeset left and right aligned, respectively.
  %     \if \should-print-page-number
  %     \fromproperty #'page:page-number-string
  %   }

  % evenHeaderMarkup = \markup
  %   \fill-line {
  %     \if \should-print-page-number
  %     \fromproperty #'page:page-number-string " "
  %     \fromproperty #'header:title
  %   }
}
\header {
  title = "Dominant 7 Resolutions (BV copy)"
}

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major

  % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1
}

mychords = \chordmode { g1:7 c1 }
% see jazzextras.ily for jazz rests
rests = { \repeat unfold #8 { \rs } }

single_transition = \score {
  <<
    \new ChordNames \mychords
    \new Staff { \repeat unfold #8 { \rs } }
  >>
}


#(define-markup-command (rmark layout props text) (markup?)
   "draw a red box around markup text"
   (interpret-markup layout props
     (markup #:with-color red #:box text)))

% 1
res_one = \relative c'' {
      d8^\markup { \rmark 1 } f e d g f e d
      c2 r2 \bar "||"
    }


% 2
res_two = \relative c'' {
      b8^\markup { \rmark 2 } f a f b aes g f
      e2 r2 \bar "||"
    }

% 3
res_three = \relative c''' {
      a8^\markup { \rmark 3 } c a bes b bes a aes
      g2 r2 \bar "||"
    }

% 4
res_four = \relative c'' {
      d8^\markup { \rmark 4 } a c a b aes' f fis
      g2 r2 \bar "||"
    }

% 5
res_five = \relative c'' {
      d8^\markup { \rmark 5 } e f g a f e d
      c2 r2
    }

% 6
res_six = \relative c''' {
      a8^\markup { \rmark 6 } f e d ees ges b a
      g2 r2
    }

% 7
res_seven = \relative c'' {
      b8^\markup { \rmark 7 } aes' f fis g f e d
      c2 r2
    }

% 8
res_eight = \relative c'' {
      b8^\markup { \rmark 8 } aes g fis f g a b
      c2 r2
    }

% 9
res_nine = \relative c''' {
      a8^\markup { \rmark 9 } c b g aes a f d
      g2 r2
    }

% 10
res_ten = \relative c'' {
      f8^\markup { \rmark 10 } a, ais b e ees d des
      c2 r2
    }

% 11
res_eleven = \relative c'' {
      d8^\markup { \rmark 11 }e f g bes aes f fis
      g2 r2
    }

% 12
res_twelve = \relative c'' {
      d8^\markup { \rmark 12 } f e d g dis b g
      c2 r2
    }

\score {
  <<
    \new ChordNames \repeat unfold #6 \mychords
    \new Staff {
     \global
     \res_one
     \res_two
     \res_three
     \break
     \res_four
     \res_five
     \res_six
     \break
     \res_seven
     \res_eight
     \res_nine
     \break
     \res_ten
     \res_eleven
     \res_twelve
     }
  >>
}


\score {
  <<
    \new ChordNames {
      \transpose g g \mychords
      \transpose g c \mychords
      \transpose g f \mychords
      \transpose g bes \mychords
      \break
      \transpose g ees \mychords
      \transpose g aes \mychords
      \transpose g cis \mychords
      \transpose g fis \mychords
      \break
      \transpose g b \mychords
      \transpose g e \mychords
      \transpose g a \mychords
      \transpose g d \mychords
    }
    \new Staff {
      \global
      \bar "[|:-|"
      \repeat unfold #12 \rests
      \bar ":|]"
    }
  >>
}

\score {
  <<
    \new ChordNames {
      \transpose g g \mychords
      \transpose g f \mychords
      \transpose g ees \mychords
      \transpose g cis \mychords
      \break
      \transpose g b \mychords
      \transpose g a \mychords
      \transpose g aes \mychords
      \transpose g fis \mychords
      \break
      \transpose g e \mychords
      \transpose g d \mychords
      \transpose g c \mychords
      \transpose g bes \mychords
    }
    \new Staff {
      \global
      \bar "[|:-|"
      \repeat unfold #12 \rests
      \bar ":|]"
    }
  >>
}