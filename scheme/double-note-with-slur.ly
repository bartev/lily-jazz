\version "2.24.0"

\displayMusic{ a'( a') }

\displayMusic a'

doubleSlur = #(define-music-function (note) (ly:music?)
  "Return: { note ( note ) }.
  `note' is supposed to be a single note."
  (let ((note2 (ly:music-deep-copy note)))
    (set! (ly:music-property note 'articulations)
          (cons (make-music 'SlurEvent 'span-direction -1)
                (ly:music-property note 'articulations)))
    (set! (ly:music-property note2 'articulations)
          (cons (make-music 'SlurEvent 'span-direction 1)
                (ly:music-property note2 'articulations)))
    (make-music 'SequentialMusic 'elements (list note note2))))

