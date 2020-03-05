\version "2.20.0"


% 1.3
% http://lilypond.org/doc/v2.18/Documentation/extending/displaying-music-expressions


\layout {
% Don't justify the output
  ragged-right = ##t
}


% toDisplay = {
%   \displayMusic {c'4\f d'8 e'8 f'16 f'}
% }


% {
%   #(with-output-to-file "display-1.txt"
%     (lambda () #{ \displayMusic { c'4\f } #}))
% }

% \toDisplay

% (make-music 'SequentialMusic
%   'elements (list 
%         (make-music 'NoteEvent
%           'articulations (list 
%                   (make-music 'AbsoluteDynamicEvent
%                   'text
%                   "f"))
%           'duration (ly:make-duration 2)
%           'pitch (ly:make-pitch 0 0))))


% someNote = c'
% \displayMusic \someNote

% (make-music 'NoteEvent
%   'pitch (ly:make-pitch 0 0)
%   'duration (ly:make-duration 4))

someNote = < c' >
\displayMusic \someNote

% (make-music 'EventChord
%   'elements (list 
%     (make-music 'NoteEvent
%           'duration (ly:make-duration 2)
%           'pitch (ly:make-pitch 0 0))))


% Change the pitch manually 

% Did not work!
#(set! 
  (ly:music-property 
   (first 
    (ly:music-property someNote 'elements))
   'pitch)
  (ly:make-pitch 0 1))

 % ;; set the pitch to d'.

\displayLilyMusic \someNote
\displayMusic \someNote
  
% display-scheme-music function (used by \displayMusic)
#(display-scheme-music (first (ly:music-property someNote 'elements)))

% (make-music 'NoteEvent
%   'duration (ly:make-duration 2)
%   'pitch (ly:make-pitch 0 1))


% 1.3.3 Doubling a note with slurs (example)

\displayMusic{ a'( a') }

% (make-music 'SequentialMusic
%   'elements 
%   (list (make-music 'NoteEvent
%           'articulations (list (make-music
%                   'SlurEvent
%                   'span-direction
%                   -1))
%           'duration (ly:make-duration 2)
%           'pitch (ly:make-pitch 0 5))
%         (make-music 'NoteEvent
%           'articulations (list (make-music
%                   'SlurEvent
%                   'span-direction
%                   1))
%           'duration (ly:make-duration 2)
%           'pitch (ly:make-pitch 0 5))))


doubleSlur = #(define-music-function (parser location note) (ly:music?)
               "Return: { note ( note ) }.
               `note' is supposed to be a single note."
               (let ((note2 (ly:music-deep-copy note)))
                (set! (ly:music-property note 'articulations)
                 (cons (make-music 'SlurEvent 'span-direction -1)
                  (ly:music-property note 'articulations)))
                (set! (ly:music-property note2 'articulations)
                 (cons (make-music 'SlurEvent 'span-direction 1)
                  (ly:music-property note 'articulations)))
                (make-music 'SequentialMusic 'elements (list note note2))))

{
  \doubleSlur a'
}