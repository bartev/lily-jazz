\version "2.20.0"

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  % between-system-space = 2.\cm
  % between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f

  % markup-system-spacing = #'((basic-distance . 23)
  %                            (minimum-distance . 8)
  %                            (padding . 1))
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " "
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
  \numericTimeSignature
  % http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
  % beam across 4 eighth notes
  \time #'(4) 2/4

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  % \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}

\header {
  title = "Melodic Cells 1"
  composer = "Chad LB"
  arranger = "2020-10-01"
}

#(define (naturalize-pitch p)
   (let ((o (ly:pitch-octave p))
         (a (* 4 (ly:pitch-alteration p)))
         ;; alteration, a, in quarter tone steps,
         ;; for historical reasons
         (n (ly:pitch-notename p)))
     (cond
      ((and (> a 1) (or (eqv? n 6) (eqv? n 2)))
       (set! a (- a 2))
       (set! n (+ n 1)))
      ((and (< a -1) (or (eqv? n 0) (eqv? n 3)))
       (set! a (+ a 2))
       (set! n (- n 1))))
     (cond
      ((> a 2) (set! a (- a 4)) (set! n (+ n 1)))
      ((< a -2) (set! a (+ a 4)) (set! n (- n 1))))
     (if (< n 0) (begin (set! o (- o 1)) (set! n (+ n 7))))
     (if (> n 6) (begin (set! o (+ o 1)) (set! n (- n 7))))
     (ly:make-pitch o n (/ a 4))))

#(define (naturalize music)
   (let ((es (ly:music-property music 'elements))
         (e (ly:music-property music 'element))
         (p (ly:music-property music 'pitch)))
     (if (pair? es)
         (ly:music-set-property!
          music 'elements
          (map naturalize es)))
     (if (ly:music? e)
         (ly:music-set-property!
          music 'element
          (naturalize e)))
     (if (ly:pitch? p)
         (begin
           (set! p (naturalize-pitch p))
           (ly:music-set-property! music 'pitch p)))
     music))

naturalizeMusic =
#(define-music-function (m)
   (ly:music?)
   (naturalize m))

diatonicScale = \relative { c' d e f g a b }
chromaticScale = \relative { a bes b c cis d ees e f fis g gis }
motif_i = \relative c'' { a8 g d e }
pat_i_degrees = \lyrics {
              \markup \rN { 1 }8
              \markup \rN { f7 }
              \markup \rN { 4 }
              \markup \rN { 5 }}



motif_ii = \relative c'' { g8 a c d }
pat_ii_degrees = \lyrics {
              \markup \rN { f7 }8
              \markup \rN { 1 }
              \markup \rN { f3 }
              \markup \rN { 4 }}

motif_iii = \relative c'' { a8 aes g a }
pat_iii_degrees = \lyrics {
              \markup \rN { 1 }8
              \markup \rN { f1 }
              \markup \rN { 7 }
              \markup \rN { 1 }}

motif_iv = \relative c'' { g8 gis a g }
pat_iv_degrees = \lyrics {
              \markup \rN { f7 }8
              \markup \rN { 7 }
              \markup \rN { 1 }
              \markup \rN { f7 }}

motifDown = \relative { c'8 d e f e d c a }

pat_i_up = \relative c'' {
  \key c \major

  \motif_i
  \transpose a bes \motif_i
  \transpose a b   \motif_i
  \transpose a c'   \motif_i
  \transpose a cis' \motif_i
  \transpose a d'   \motif_i
  \transpose a ees' \motif_i
  \transpose a e'   \motif_i
  \transpose a f'   \motif_i
  \transpose a fis' \motif_i
  \transpose a g'   \motif_i
  \transpose a gis' \motif_i

  \transpose a a' \motif_i

  \transpose a gis' \motif_i
  \transpose a g'   \motif_i
  \transpose a fis' \motif_i
  \transpose a f'   \motif_i
  \transpose a e'   \motif_i
  \transpose a ees' \motif_i
  \transpose a d'   \motif_i
  \transpose a cis' \motif_i
  \transpose a c'   \motif_i
  \transpose a b   \motif_i
  \transpose a bes \motif_i
  \motif_i
}

pat_ii_up = \relative c'' {
  \key c \major

  \motif_ii
  \naturalizeMusic \transpose a bes \motif_ii
  \naturalizeMusic \transpose a b   \motif_ii
  \naturalizeMusic \transpose a c'   \motif_ii
  \naturalizeMusic \transpose a cis' \motif_ii
  \naturalizeMusic \transpose a d'   \motif_ii
  \naturalizeMusic \transpose a ees' \motif_ii
  \naturalizeMusic \transpose a e'   \motif_ii
  \naturalizeMusic \transpose a f'   \motif_ii
  \naturalizeMusic \transpose a fis' \motif_ii
  \naturalizeMusic \transpose a g'   \motif_ii
  \naturalizeMusic \transpose a gis' \motif_ii

  \naturalizeMusic \transpose a a' \motif_ii

  \naturalizeMusic \transpose a gis' \motif_ii
  \naturalizeMusic \transpose a g'   \motif_ii
  \naturalizeMusic \transpose a fis' \motif_ii
  \naturalizeMusic \transpose a f'   \motif_ii
  \naturalizeMusic \transpose a e'   \motif_ii
  \naturalizeMusic \transpose a ees' \motif_ii
  \naturalizeMusic \transpose a d'   \motif_ii
  \naturalizeMusic \transpose a cis' \motif_ii
  \naturalizeMusic \transpose a c'   \motif_ii
  \naturalizeMusic \transpose a b   \motif_ii
  \naturalizeMusic \transpose a bes \motif_ii
  \motif_ii
}

pat_iii_up = \relative c'' {
  \key c \major

  \naturalizeMusic \motif_iii
  \naturalizeMusic \transpose a bes \motif_iii
  \naturalizeMusic \transpose a b   \motif_iii
  \naturalizeMusic \transpose a c'   \motif_iii
  \naturalizeMusic \transpose a cis' \motif_iii
  \naturalizeMusic \transpose a d'   \motif_iii
  \naturalizeMusic \transpose a ees' \motif_iii
  \naturalizeMusic \transpose a e'   \motif_iii
  \naturalizeMusic \transpose a f'   \motif_iii
  \naturalizeMusic \transpose a fis' \motif_iii
  \naturalizeMusic \transpose a g'   \motif_iii
  \naturalizeMusic \transpose a gis' \motif_iii

  \naturalizeMusic \transpose a a' \motif_iii

  \naturalizeMusic \transpose a gis' \motif_iii
  \naturalizeMusic \transpose a g'   \motif_iii
  \naturalizeMusic \transpose a fis' \motif_iii
  \naturalizeMusic \transpose a f'   \motif_iii
  \naturalizeMusic \transpose a e'   \motif_iii
  \naturalizeMusic \transpose a ees' \motif_iii
  \naturalizeMusic \transpose a d'   \motif_iii
  \naturalizeMusic \transpose a cis' \motif_iii
  \naturalizeMusic \transpose a c'   \motif_iii
  \naturalizeMusic \transpose a b   \motif_iii
  \naturalizeMusic \transpose a bes \motif_iii
  \naturalizeMusic \motif_iii

}

pat_iv_up = \relative c'' {
  \key c \major

  \naturalizeMusic \motif_iv
  \naturalizeMusic \transpose a bes \motif_iv
  \naturalizeMusic \transpose a b   \motif_iv
  \naturalizeMusic \transpose a c'   \motif_iv
  \naturalizeMusic \transpose a cis' \motif_iv
  \naturalizeMusic \transpose a d'   \motif_iv
  \naturalizeMusic \transpose a ees' \motif_iv
  \naturalizeMusic \transpose a e'   \motif_iv
  \naturalizeMusic \transpose a f'   \motif_iv
  \naturalizeMusic \transpose a fis' \motif_iv
  \naturalizeMusic \transpose a g'   \motif_iv
  \naturalizeMusic \transpose a gis' \motif_iv

  \naturalizeMusic \transpose a a' \motif_iv

  \naturalizeMusic \transpose a gis' \motif_iv
  \naturalizeMusic \transpose a g'   \motif_iv
  \naturalizeMusic \transpose a fis' \motif_iv
  \naturalizeMusic \transpose a f'   \motif_iv
  \naturalizeMusic \transpose a e'   \motif_iv
  \naturalizeMusic \transpose a ees' \motif_iv
  \naturalizeMusic \transpose a d'   \motif_iv
  \naturalizeMusic \transpose a cis' \motif_iv
  \naturalizeMusic \transpose a c'   \motif_iv
  \naturalizeMusic \transpose a b   \motif_iv
  \naturalizeMusic \transpose a bes \motif_iv
  \naturalizeMusic \motif_iv

}

\book {

\score {
  <<
  \new Staff {
    \global
    \mark \markup{ \with-color #red "Am7 pattern 1 diatonic" }
    \pat_i_up  \break
  }
  \new Lyrics \pat_i_degrees
  >>
  \header {
    % piece = "Am7 pattern 1 diatonic"
  }
}

\score {
  <<
  \new Staff {
    \global
     \mark \markup{ \with-color #red "Am7 pattern 2 diatonic" }
    \pat_ii_up \break
  }
  \new Lyrics \pat_ii_degrees
  >>
  \header {
    % piece = "Am7 pattern 2 diatonic"
  }
}

\pageBreak

\score {
  <<
  \new Staff {
    \global
    \mark \markup{ \with-color #red "Am7 pattern 3 chromatic" }
    \pat_iii_up \break
 }
 \new Lyrics \pat_iii_degrees
 >>
  \header {
    % piece = "Am7 pattern 3 chromatic"
  }
}

\score {
  <<
  \new Staff {
    \global
    \mark \markup{ \with-color #red "Am7 pattern 4 chromatic" }
    \pat_iv_up \break
 }
 \new Lyrics \pat_iv_degrees
 >>
  \header {
    % piece = "Am7 pattern 4 chromatic"
  }
}
}