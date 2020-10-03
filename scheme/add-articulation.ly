\version "2.20.0"

music = \relative c' { c4 d e f }

\displayMusic c4->
 
(define (add-accent note-event)
  "Add an accent ArticulationEvent to teh articulations of `note-event`,
  which is supposed to be a NoteEvent expression"
  (set! (ly:music-property note-event 'articulations)
        (cons (make-music 'ArticulationEvent
                          'articulation-type 
                          "accent")
              (ly:music-property note-event 'articulations)))
  note-event)

% input

% (make-music
%   'NoteEvent
%   'duration
%   (ly:make-duration 2 0 1)
%   'pitch
%   (ly:make-pitch -1 0 0))
