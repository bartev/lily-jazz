\version "2.18.2"

manualBeam = 
#(define-music-function
  (parser location beg-end)
  (pair?)
  #{
    \once \override Beam.positions = #beg-end
  #} )

\relative c' {
  \manualBeam #'(-1 . 0) c8 d e f
  \manualBeam #'(0 . 1) c8 d e f
  \manualBeam #'(0 . 2) c8 d e f
  \manualBeam #'(0 . 3) c8 d e f
  \manualBeam #'(0 . 4) c8 d e f
  \manualBeam #'(0 . 5) c8 d e f
}

\relative c' {
  \manualBeam #'(3 . 0) c8 d e f
  \manualBeam #'(3 . 1) c8 d e f
  \manualBeam #'(3 . 2) c8 d e f
  \manualBeam #'(3 . 3) c8 d e f
  \manualBeam #'(3 . 4) c8 d e f
  \manualBeam #'(3 . 5) c8 d e f
}

\displayMusic \relative c' { c8 d e f }