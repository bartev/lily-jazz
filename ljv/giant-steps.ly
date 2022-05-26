\version "2.20.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = "Giant Steps"
composer = "John Coltrane"
arranger = ""
tagline = ""
meter = "290"
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
	\fill-line {
	  \fontsize #1 \lower #2 \rotate #7 \concat {\note #"4" #1 " = " #meter }
	  \fontsize #5
	  \override #'(offset . 7)
	  \override #'(thickness . 6)
	  \underline \larger #title
	  \fontsize #1 \lower #1 \concat { #composer " " }
	}
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##t
      last-ragged-bottom = ##t
    }
  }
}


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##t

  %% markup-system-spacing = #'((basic-distance . 23)
%%                            (minimum-distance . 8)
%%                            (padding . 1))
  oddHeaderMarkup = \markup
  \fill-line {
    \title
    %% \fromproperty #'header:title " "
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string " "
    %% \fromproperty #'header:title
    \title
  }
}

\layout {
  \context {
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  %% http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
  \key c \major
				% %% beam across 4 eighth notes
				% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}


%%%%%%%%%%%%%%%%%%%% Functions

timestop = #(define-music-function
	     (parser location string)
	     (string?)
	     "colored markup (for timestamps)"
	     #{ <>^\markup \large \with-color #red #string #})

markManualBox = #(define-music-function
		  (parser location string)
		  (string?)
		  "manually set a box mark that matches current color/size"
		  #{ <>\mark \markup \with-color #darkred \box \sans \normalsize  #string #})

markBlue = #(define-music-function
	     (parser location string)
	     (string?)
	     "blue markup string"
	     #{ <>\mark \markup \override
	     #'(font-name . "lilyjazz-chord")
		\fontsize #-6
		\with-color #blue #string #})

crossNote = 
#(define-music-function (parser location my-music)
  (ly:music?)
  #{
  \override NoteHead.style = #'cross
  #my-music
  \revert NoteHead.style
  #}
)

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

	%% Start with blank staves
	blankStaves= \score {
	  {
	    \repeat unfold 11 { s1 \break }
	  }
	  \layout {
	    #(layout-set-staff-size 28)
	    indent = 0\in
	    \context {
	      \Staff
	      \remove "Time_signature_engraver"
	      \remove "Clef_engraver"
	      \remove "Bar_engraver"
	    }
	    \context {
	      \Score
	      \remove "Bar_number_engraver"
	    }
	  }
	}

	%% \blankStaves
	%% \pageBreak


	%% Head
	giant_steps =  \relative c'' {
	  %% Head
	  \markManualBox "Head"
	  \timestop "0:37"
    ees2 b
    gis2 e4. g8~
    g2. r4
    gis4. fis8~ fis2
    \break

    b2 g
    e2 c4. ees8~
    ees2 r2
    e?2 d4. g8~
    \break
    
    g1
    gis2 fis4. b8~
    b2 r
    c2 c4. ees8~
    \break
    
    ees1
    e?2 e4. g8~
    g1
    ees4. ees8~ ees r r4
    \bar "||"
    \break

	  \markManualBox "A (Head again)"
	  \timestop "0:37"    
    ees2 b
    gis2 e4. g8~
    g2. r4
    gis4. fis8~ fis2
    \break

    b2 g
    e2 c4. ees8~
    ees2 r2
    e?2 d4. g8~
    \break
    
    g2. r4
    gis2 fis4. b8~
    b2 r
    c2 c4. ees8~
    \break
    
    ees1
    e?2 e4. g8~
    g2. r4
    bes,8 des f aes g4. f8
    \bar "||"
    \pageBreak
    
	  \markManualBox "B (Start solo)"
	  \timestop "0:37"
    ees8 c aes4 b8 cis dis fis
    e8 b gis \crossNote dis a' f e d
    c8 d e f g a b d
    cis8 a fis e dis c' b a
    \break
    
    gis8 b e gis b, d f? a
    c,8 d e g des f g bes
    g4 f8 ees~ ees4 r
    g8 fis f e d c b a
    \break

    g8 f' e b d c b d
    cis8 a fis cis e \crossNote cis! dis c'
    b8 a gis fis e fis? g b
    c8 bes aes g~ g ees f g
    \break

    aes8 bes c ees g fis f e
    d4 r e16 f \crossNote e8 d8 b
    c8 d \crossNote e g c4 g
    r4 g8 aes g4. ees8
    \bar "||"
    \break
    
    \repeat unfold 4 { \repeat unfold 4 s1 \break }
    
	}

	giant_steps_head_scale_degrees = \lyrics { \repeat unfold 32 { ""1 } }
	giant_steps_solo_scale_degrees = \lyrics {

	  \repeat unfold 15 { ""1 }

	  %% m48
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { f2 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  ""4

	}

	giant_steps_chordNames = \chordmode {
	  %% A
    aes2 b:7
    e2 g:7
    c1
    fis2:m7 b:7
    
    e2 g:7
    c2 ees:7
    aes1
    d2:m7 g:7
    
    c1
    fis2:m7 b:7
    e1
    bes2:m7 ees:7
    
    aes1
    d2:m7 g:7
    c1
    bes2:m7 ees:7
	}

	%% giant_steps_chordAnalysis= \new Lyrics \lyricmode { }

	\score {
	  <<
	    %% \giant_steps_chordAnalysis
	    \new ChordNames {
	      \repeat unfold 4 {\giant_steps_chordNames}
	    }
	    \new Staff {
	      \global
	      \giant_steps
	      %% \pageBreak
	    }
	    %% {
	    %%   \i_want_head_scale_degrees
	    %%   \i_want_solo_scale_degrees
	    %% }
	    %% \dimScaleDegrees
	  >>
	}

%%	\pageBreak
%%	\blankStaves
