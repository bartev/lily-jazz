\version "2.19.31"

\include "bv-jazz-settings.ly"

% \include "equinox-bv-notes.ly"
% \include "bv-bill-evans-header.ly"


%\new Staff {
  % \tpart
% }

#(define (naturalize-pitch p)
   (let ((o (ly:pitch-octave p))
         (a (* 4 (ly:pitch-alteration p)))
         ;; alteration, a, in quarter tone steps,
         ;; for historical reasons
         (n (ly:pitch-notename p)))
     (cond
      ((and (> a 1) (or (eq? n 6) (eq? n 2)))
       (set! a (- a 2))
       (set! n (+ n 1)))
      ((and (< a -1) (or (eq? n 0) (eq? n 3)))
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
          (map (lambda (x) (naturalize x)) es)))
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

%%%%%%%%%%%% Keys'n'thangs %%%%%%%%%%%%%%%%%

global = { \time 4/4 }

Key = { \key c \minor }

%%%%%%%%%%%% Headers %%%%%%%%%%%%%%%%%

\header { 
  title = "Blues Scale"
  % subtitle = "(Subtitle)"
  % composer = "'Trane"
  meter = ""
  % tagline = "Coltrane's Sound"
  piece =  "" }
\layout { indent = 0 }
\midi { \tempo 4 = 80 }

melody-c = \new Staff \relative c' {
  \clef treble
  \bar "||" 
  c8 es f ges g bes c4
  \bar "||"
}

chordmusic-c = \chordmode {
  c1:min7
}

% \score {
%   \new StaffGroup <<
%     \trumpet
%     \alto
%     \tclef
%     \bclef
%   >>
% }

\new StaffGroup 
<<
  \chords { 
    \set minorChordModifier = \markup { "-" }
	\break
  \chordmusic-c
  }
  \melody-c
  \chordmusic-c
>>


\markup { \sans "" }