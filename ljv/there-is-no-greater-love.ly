\version "2.20.0"

%% See transcription at https://www.youtube.com/watch?v=X3qb_JO4Al8

#(set-global-staff-size 22)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

%% set up title, compser, meter, copyright
title = #"There Is No Greater Love"
composer = #"Jymes/Jones"
%% meter = \markup{meter?}
meter = #"130"
copyright = #"Bartev 2021-10"
tagline = "Awesome transcription by Bartev - There is no Greater Love"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
	  \fontsize #1 \lower #1 \rotate #7 \concat { \note #"4" #1 " = " #meter }
          %% \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #7
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
    }
  }
}

\header {
  title = \realBookTitle
  copyright = \copyright
  tagline = \tagline
}

\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  between-system-space = 2.5\cm
  between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))

  oddHeaderMarkup = \markup
  \fill-line {
    %% If not using the realBookTitle, can use
    %% \fromproperty #'header:title " "
    \title
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string " "
    \title
  }
}

global = {
  \numericTimeSignature
  \time 4/4
  %% \tempo 4=130 % this would be over the clef on the first line

  %% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible

  %% \override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
  \override Score.SystemStartBar #'collapse-height = #1 % allow single-staff system bars
  \override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
  \override Score.MultiMeasureRest.expand-limit = 1

  \override Score.RehearsalMark.color = #darkred
  \override Score.RehearsalMark.font-size = 6

  %% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
  \compressFullBarRests

  \set Score.markFormatter = #format-mark-box-alphabet
}

%%%%%%%%%%%%%%%%%%%% Functions

timestop = #(define-music-function
	     (parser location string)
	     (string?)
	     "colored markup (for timestamps)"
	     #{ <>\mark \markup \small \with-color #red #string #})

markManualBox = #(define-music-function
		  (parser location string)
		  (string?)
		  "manually set a box mark that matches current color/size"
		  #{ <>\mark \markup \box #string #})

markBlue = #(define-music-function
	     (parser location string)
	     (string?)
	     "blue markup string"
	     #{ <>\mark \markup \fontsize #-6 \with-color #blue #string #})


%%%%%%%%%%%%%%%%%%%% Begin music

chords_tingl_partial = \chordmode { s1*8 }

chords_tingl = \chordmode {
  bes1:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c:7 | c:m7 | f:7 |
  \break
  bes:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c2:m7 f:7 | bes1:6 | bes:6 |
  \break
  a2:m7.5- d:7.9 | g1:m6 | a2:m7.5- d:7.9 | g1:m6 |
  \break
  a2:m7.5- d:7.9 | g1:m7 |  c:7 | f:7 |
  \break
  bes:maj7 | ees:7 | aes:7 | g:7 |
  \break
  c:7 | c2:m7 f:7 | bes1:6 | c2:m7 f:7 |

}

head_tingl_partial = \relative c'' {
  \global
  \key bes \major
  \inlineMMR R1*7
  r4 a4 bes c |
}


head_tingl = \relative c'' {
				% measure 1
  \bar ".|"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

				% measure 5
  g1 ~ |
  g4 g d' des |
  c1 |
  r4 a bes c |
  \bar "||"
  \break

				% measure 9
  \bar "||"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

				% measure 13
  g4 g d' c |
  bes2 c |
  bes1 ~ |
  bes2. r4 |
  \bar "||"
  \break

				% measure 17
  \bar "||"
  d,4 fis a c |
  bes1 |
  fis4 a c ees |
  d1 |
  \break

				% measure 21
  d,4 fis a c |
  bes4 a g d |
  c1 |
  r4 a' bes c
  \bar "||"
  \break

				% measure 25
  \bar "||"
  bes4 a g4. d8 |
  f4 fes ees bes |
  d1 ~ |
  d4 d a' aes |
  \break

				% measure 29
  g4 g d' c |
  bes2 c |
  bes1 |
  r1
  \bar "|."
}

tingl_stitt_music_partial = \relative c'' {
  \global
  \key g \major
  \inlineMMR R1*7
  r4 r8 fis g a r g~
}

tingl_stitt_music = \relative c''' {
  %% \global
  %% measure 1

  \bar ".|"
  \timestop "14 sec"
  g4  fis e b
  d4 des c g8 b~
  b1~
  b4~ b8 bes16 b fis'4 f4

  \timestop "21 sec"
  e2~ e4 r4
  e8-> fis16-> e dis8 e-. b'4->~ b8 a8
  fis2 r2
  r8 b16 a g e c a d8   fis,8-> g-> a-. \break

  
  \timestop "28 sec"
  r8 g8~ g fis e4 r8 b8 
  d4 r8 cis c8 d e c
  b8 b r b~ b2
  \markBlue "check notes Bb B?" \tuplet 3/2 {r4 b d} fis4 d8 f

  \timestop "35 sec"
  e2 \markBlue "check notes D# E?" \tuplet 3/2 {r4 e fis}
  b4. a8 \tuplet 3/2 {g8 a g} fis8 a 
  g4 \markBlue "too low for alto"
  \set Staff.ottavation = #"8vb" fis'8 g e c \tuplet 3/2 {b16 c b} a8
  d8 g,~ g4 r4 \unset Staff.ottavation c8 b~

  \timestop "42 sec"
  b4 dis-. fis-. a8 gis16 g
  fis8 g~ g4 r2
  r8 dis fis a~ a c~ c b~
  b2 r2

  \timestop "49 sec"
  b,4-> dis8 fis~ fis4 a8 g~
  g4 fis8 e~ e4 b8 a~
  a1
  r8 b~ b4~ b4. d,8

  \timestop "57 sec"
  \tuplet 3/2 {g4 g g} e4. b8
  d4. cis8 c d e c
  b8 b~ b b~ b4 r4
  r8 \markBlue "check notes C B?" d16 c \markBlue "check notes  Bb B?" b8 d f4 f8 e~

  \timestop "1:04"
  e2 r8 e f4
  b2 g4 r4
  b8 b \tuplet 3/2 {g8 e g} b8 b \tuplet 3/2 {g8 e g}
  b8 b \tuplet 3/2 {g8 e g} b8 d c b
  \pageBreak
  
  
  \markManualBox "A"
  g4
  \timestop "1:11"
  e-. b' \tuplet 3/2 {g8 e \markBlue "B?" d}
  c4-. r8 g' a b c d
  b4 r8 f a c \tuplet 3/2 {b16 c b} a8
  gis8 b, d e f \tuplet 3/2 {e16 f e} d8 c
  \break

  \timestop "1:19"
  cis8  a'~ a4 r2
  r8 e16 fis g8. b16 fis'16 e \tuplet 3/2 {d16 e d} b16 a g e
  f16 e d cis  c b' \tuplet 3/2 {r16 g e}  a16 e g e  fis a c e~
  e8 b16 d c a gis b a e g e fis e d c
  \break
  
  \markManualBox "A"
  b16
  \timestop "1:26"
  d e g r e g8 r2
  r8 \tuplet 3/2 {d16 e g} bes16 g r bes r2
  r8 b~ b4~ b8 a f g
  a8 b a g gis f \tuplet 3/2 {e16 f e} d8
  \break
  
  \timestop "1:33"
  cis8 b'~ b4 r2
  d8 cis16 c b4 g8 d fis g~
  g4 \markBlue "too low for alto"
  \set Staff.ottavation = #"8vb" fis'8 g e c \tuplet 3/2 {b16 c b} a8
  d8 g, r4 r r8 b
  \break

  \markManualBox "B"
  a8 \timestop "1:40"
  b c d dis fis a fis
  g4 \unset Staff.ottavation r r8 b,,~ b g'
  fis4 cis8 e dis b'~ b16 c b a
  g8 e~ e4 r b'8 g'
  \break
  
  \timestop "1:47"
  fis4 cis8 e \tuplet 3/2 {dis16 e dis} c8 b a
  g8 b, fis' e~ e b \tuplet 3/2 {d16 e d} b8
  cis8 a'~ a4 r e8 g
  fis8 a c e \tuplet 3/2 {d16 e d} g,8 b4
  \break
  
  \markManualBox "A"
  g4 \timestop "1:54"
  r g'4. bes,8
  a4 r r8 e16 g e'4~
  e2 s2
  s1
  \break

  \timestop "2:01"
  s1 s s s
}

tingl_stitt_score = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_tingl_partial
      \repeat unfold 2 {\chords_tingl}
    }
    \new Staff \with {
      instrumentName = "Alto"
    } {
      \tingl_stitt_music_partial
      \tingl_stitt_music
    }
  >>
}

\tingl_stitt_score

				% C instruments

				% rb = \score {
				%   <<
				%     \new ChordNames {
				%       \chords_tingl_partial
				%       \chords_tingl
				%     }
				% 
				%     \new Staff \with {
				%       instrumentName = "piano"
				%       midiInstrument = "piano"
				%     } {
				%       \head_tingl_partial
				%       \head_tingl
				%     }
				%   >>
				%   \layout {}
				%   \midi {}
				% }
				% 
				% \rb
				% \pageBreak
				% 
				% rb_chords = \score {
				%   <<
				%     \new ChordNames {
				%       \chords_tingl_partial
				%       \chords_tingl
				%     }
				%     \new Staff \with {
				%       instrumentName = "piano"
				%     } {
				%       \chords_tingl_partial
				%       \chords_tingl
				%     }
				%   >>
				% }

				% E flat instruments

eflat_rb = \score {
  <<
    \new ChordNames \transpose ees, c {
      \chords_tingl_partial
      \chords_tingl
    }
    \new Staff \with {
      instrumentName = "Alto"
      midiInstrument = "alto sax"
    } \transpose ees, c {
      \head_tingl_partial
      \head_tingl
    }
  >>
  \layout {}
				% \midi {}
}

eflat_chords = \score {
  <<
    \new ChordNames \transpose ees, c \chords_tingl
    \new Staff \with {
      instrumentName = "Eb\ninstr"
    } \transpose ees c \chords_tingl
  >>
}

				% Just choose 1 style to print

				% % piano
				% \rb
				% \pageBreak
				% \rb_chords

				% alto
				% \eflat_rb
				% \pageBreak
				% \eflat_chords
				% \pageBreak
