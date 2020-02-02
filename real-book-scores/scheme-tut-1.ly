\version "2.19.80"

% http://lilypondblog.org/2014/03/music-functions-2-start-doing-something-useful/

% define a variable using the usual LilyPond syntax
bpmA = 60

% define a variable using Scheme
#(define bpmB 72)

myscore =  \relative c' {
  % assign a tempo literally
  \tempo 8 = 54
  r1

  % assign tempos using the LilyPond syntax for variables
  \tempo 8 = \bpmA
  r1

  \tempo 8 = \bpmB
  r1

  % assign tempos by referecing variables using Schems
  \tempo 8 = #bpmA
  r1

  \tempo 8 = #bpmB
  r1
}


\score {
  \myscore
}


myFunction = { c2 }

mySchemeFunction = #(define-music-function (parser location) ()
                     #{
                     c2
                     #}) 
                    
\score {
  \relative c' {
    c4 \myFunction c
  }
}

\score {
  \relative c' {
    c4 \mySchemeFunction c
  }
}


makeRedNote = 
#(define-music-function (parser location)()
  #{
  \once \override NoteHead.color = #red
  \once \override Stem.color = #red
  #})

\score {
  \relative c' {
    c4 \makeRedNote c c c 
  }
}

colorNote = 
#(define-music-function (parser location my-color)
  (color?)
  #{
  \once \override NoteHead.color = #my-color
  \once \override Stem.color = #my-color
  #})



\score {
  \relative c' {
    c4 \colorNote #blue c \colorNote #red c c 
  }
}

% does nothing
noOp = 
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  #my-music   % treat it as scheme code
  #})

% does nothing
noOpTwo = 
#(define-music-function (parser location my-music)
  (ly:music?)
  my-music
)

\score {
  \relative c' {
    c4 \noOp c \noOpTwo c c
  }
}

% Color arbitrary music with arbitrary colors

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
     
     #my-music
     
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

% test
myMusic = \relative c' {
  c4. d8 e16 d r cis( d4) ~ | d1 \fermata
}

\relative c' {
  \colorMusic #blue \myMusic
  \colorMusic #red {c4 c} d \colorMusic #green e\f
  \colorMusic #magenta \myMusic
}

crossNote = 
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override NoteHead.style = #'cross
  #my-music
  \revert NoteHead.style
  #}
)

\relative c' {
  c4 \crossNote d e f
  \crossNote {g a} b c
}

red-markup = 
#(define-music-function (parser location foo)()
  #{
  \markup {
  \with-color #red {#foo}
  }
  #}
)

\relative c' {
  % c4^\red-markup { stuff here } d e f
}
