\version "2.18.2"

% https://lilypondblog.org/2014/03/music-functions-2-start-doing-something-useful/

makeRedNote =
#(define-music-function (parser location)()
   #{
     \once \override NoteHead.color = #red
     \once \override Stem.color = #red
   #})

\relative c' {
  c4 \makeRedNote c c c
}



% Needs an argument of scheme type color

% create arbitrary color
% #'(R G B)
% #'(0 0.75 0)
% see tutorial to see how to refer to scheme values
% (with a ' or with a '()
% http://lilypond.org/doc/v2.18/Documentation/extending/scheme-tutorial.en.html
% kind of hard to find

colorNote =
#(define-music-function (parser location my-color)
(color?)
#{
  \once \override NoteHead.color = #my-color
  \once \override Stem.color = #my-color
  #})

\relative c' {
  c4 \colorNote #blue c \colorNote #'(0 0.75 0) c c
}


% Process a music argument

% functions and predicates with the ly: prefix (like ly:music?)
% are defined by LilyPond

% return the music element
noOp = 
#(define-music-function (parser location my-music)
(ly:music?)
#{
        #my-music
#})

% same as noOp, except since my-music is a scheme music expression,
% can use it directly in the scheme function

noOpTwo = 
#(define-music-function (parser location my-music)
(ly:music?)
  my-music
)

\relative c' {
   c4 \noOp c \noOpTwo c c
}


% Coloring arbitrary music with arbitrary colors

colorMusic =
#(define-music-function (parser location my-color my-music)
   (color? ly:music?)
   #{
     \temporary \override NoteHead.color = $my-color
     \temporary \override Stem.color = $my-color
     \temporary \override Flag.color = $my-color
     \temporary \override Beam.color = $my-color
     \temporary \override Rest.color = $my-color
     \temporary \override Slur.color = $my-color
     \temporary \override PhrasingSlur.color = $my-color
     \temporary \override Tie.color = $my-color
     \temporary \override Script.color = $my-color
     \temporary \override Dots.color = $my-color
     
     $my-music
     
     \revert NoteHead.color
     \revert Stem.color
     \revert Flag.color
     \revert Beam.color
     \revert Rest.color
     \revert Slur.color
     \revert PhrasingSlur.color
     \revert Tie.color
     \revert Script.color
     \revert Dots.color
   #})


myMusic = \relative c' {
  c4. d8 e16 d r cis( d4) ~ | d1 \fermata
}

\relative c' {
  \colorMusic #blue \myMusic 
  \colorMusic #red { c4 c } d \colorMusic #green e\f
  \colorMusic #magenta \myMusic
}