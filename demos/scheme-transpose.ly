\version "2.18.2"

singleNote = c''1
#(display-scheme-music singleNote)

singleNote_two = c''2
#(display-scheme-music singleNote_two)

singleNote_four = c''4
#(display-scheme-music singleNote_four)

singleNote_eight = c''8
#(display-scheme-music singleNote_eight)

notes = \relative c'' {
      \key c \major
      c4 d e f
}

\displayMusic
\new Staff {
     \transpose ees c { \notes } 
}




#(display-scheme-music 
    (ly:music-property notes 'element))


% #(define (get_elems music)
%          (let ((es (ly:music-property music 'elements))
%                (e (ly:music-property music 'element))
%                (p (ly:music-property music 'pitch)))
%                (if (pair? es)
%   )))                 

% \new Staff {
%     \notes
%     \transpose ees c { \notes }
%     \transpose bes c { \notes }
%  }


#(define newNotes
         (map ly:music-deep-copy
         (list notes 
               (ly:music-transpose notes (ly:make-pitch 0 5 0)))))


% #(display-scheme-music
%   (ly:music-transpose notes (ly:make-pitch 0 6 0)))

% #(ly:music-transpose notes (ly:make-pitch 0 6 0))



#(define twice
         (make-sequential-music newNotes))

\twice

#(display-scheme-music twice)

#(display-scheme-music 
  #(ly:music-transpose notes #{bes#})
)

\notes
