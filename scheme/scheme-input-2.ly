\version "2.24.0"

someNote = <c'>

\displayMusic \someNote

#(display-scheme-music (first (ly:music-property someNote 'elements)))

#(display-scheme-music 
  (ly:music-property
    (first 
      (ly:music-property someNote 'elements))
    'pitch))

#(set! (ly:music-property
         (first (ly:music-property someNote 'elements))
         'pitch)
       (ly:make-pitch 0 1 0) ;; set the pitch to d'
)
\displayLilyMusic \someNote