\version "2.20.0"

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
%  paper-height = 11\in
%  paper-width = 8.5\in
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"Tests"
composer = #"'Misc"
meter = #"allegro"
subtitle = "a subtitle"
subsubtitle = "(another subtitle called subsubtitle)."
arranger = "An Arranger"
poet = "A Poet"

%--------------------
% Defines Title on staff like in the Real Book
% uses previously defined params
%  - #meter
%  - #title
%  - #composer
% \fontsize #1 is small font. larger numbers give larger fonts
% \rotate #20 means rotate 20 degrees (from x-axis)
% \override #'(offset . 7) places some space betwen the title and underline
%   larger numbers give more space
%   if the offset gets too large, the entire staff is shifted down
% \override #'(thickness . 6) creates a thicker line 
%    (the default is too thin to see)
% \lower #1 (vs. \raise #1) lowers the text
%--------------------

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #20 \concat { " " #meter }
          \fontsize #5
            \override #'(offset . 7)
            \override #'(thickness . 6)
            \underline \larger \larger #title
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
  subtitle = \subtitle
  subsubtitle = \subsubtitle
  tagline = ##f
  arranger = \arranger
  poet = \poet
  % copyright = "Coltrane's Sound"
}

%--------------------
% \set countPercentRepeats = ##t
% puts numbers over repeats
% start dynamic (with text "mp")
%   \mp \<
% end dynamic
%   \!
% start repeated measure(s)
%   \repeat percent <how many> { measures to repeat }
% \ottava (raise/lower an octave)
% \set Staff.ottavation = "8a Alta"  (text for ottava)
%
%
% This \score has 
%  - a StaffGroup
%  - a header (with title, piece, opus)
%  - and a \layout which indicates that the last line should not be ragged
%--------------------
\score {
  \new StaffGroup <<
    %-------------------- top staff (treble clef)
    \new Staff
    \relative c' {
      \set countPercentRepeats = ##t
      \key bes \major
      \numericTimeSignature
      \tempo 4 = 60
      \repeat percent 7 {
        <f bes d>4
        <f bes d>4
        <g bes ees>4
        <g bes ees>4 |
      }
      \break
      \relative c''
      \repeat percent 2 {
        \ottava #1
        \set Staff.ottavation = "8a Alta - other text"
        <f bes d>4 \mp \< <f bes d>4 <g bes ees>4 <g bes ees>4 \! |
        <aes bes f>4 \mf \>
        \ottava #0
        <aes, bes f>4 <g bes ees>4 <g bes ees >4 \! |
      }
      s
    }
    %-------------------- bottom staff (bass clef)
    \new Staff {
      \set countPercentRepeats = ##t
      \clef F
      \numericTimeSignature
      \key bes \major
      \repeat percent 7 {
        <f bes d>4 <f bes d>4 <g bes ees>4 <g bes ees>4 |
      }
      \repeat percent 2 {
        <f bes d>4 <f bes d>4 <g
        bes ees>4 <g bes ees>4 |
        <aes bes f>4 <aes bes f>4 <g bes ees>4 <g bes ees >4|
      }
      s
    }
  >>
  \header {
    title = "2nd Title"
    piece = "A Piece to Play"
    opus = "Op.2"
  }
  \layout {
    ragged-last = ##f
    \context { 
      \Score
      % revert Real book options :
      % \revert Clef.break-visibility	
      % \revert KeySignature.break-visibility
      % \revert Score.BarNumber.stencil
    }
  }
}

%---------- Begin 2nd example
%--------------------
% \clef "G_8" adjusts the octave, try "G_16"!
% \mark \markup "(Bright Latin)"  -- add text
% \set fingeringOrientations = #'(left)  -- put fingerings on the left instead of above
% Slashes for improvization
%   \improvisationOn (slash instead of c quarter notes)
%   \override Voice.Stem.stencil = ##f (remove stem from quarter note)
% \revert Voice.Stem.stencil -- undo removing stems from notes
%--------------------
\score {
  <<
    \new ChordNames
    \chordmode {
      d1:7 s c:7/d s
    }
    \new Voice \with { \consists "Pitch_squash_engraver" }
    {
      \set Staff.instrumentName = "Guitar"
      \clef "G_8"
      \key d \major
      \mark \markup "(Bright Latin)"
      \numericTimeSignature
      \set fingeringOrientations = #'(left)
      \bar "[|:"
      \improvisationOn
      \override Voice.Stem.stencil = ##f
      \repeat volta 2 {
        \repeat unfold 12 { c4 } 
      }
      \alternative {
        { 
          c4 c
          \improvisationOff
          \revert Voice.Stem.stencil
          r8 <d'-1\3>4 <cis'-4\4>8 
          \bar ":|]" 
        }
        { 
          % v2.18 workaround => http://lilypond.1069038.n5.nabble.com/Reducing-the-second-VoltaBracketSpanner-length-tt161852.html
          %\once\override Score.VoltaBracket.shorten-pair = #'(1 . 0)
          d'1 
        }
      }
      \bar "|."
    }
  >>
  \header {
    piece = "C'Est What" 
  }
  \layout {
    ragged-right = ##t
    indent = 10
  }
}


%---------- Begin 3rd example -- Rests (number above the line)
%--------------------
% \time 2/2 (written as cut time unless use \numericTimeSignature)
% \override MultiMeasureRest #'expand-limit = #1  -- expand out the rest instead of using 
%   combinatins of breve rests
%   http://lilypond.org/doc/v2.18/Documentation/notation/writing-rests
%--------------------
\relative c'' {
  \time 2/2
  \compressFullBarRests
  R1*2 | R1*5 | R1*9 \break
  \override MultiMeasureRest #'expand-limit = #1
  R1*2 | R1*5 | R1*9
}


%---------- Begin 4th example -- Rests (number inline)
%--------------------
% \override Score.MultiMeasureRest.minimum-length = #20  -- set how long the rest must be
% \inlineMMR R1*4   -- inline rest of 4 measures
%--------------------
%=> http://lsr.di.unimi.it/LSR/Item?id=753
ExampleMusic = {
  \numericTimeSignature
  \time 2/2
  \override Score.MultiMeasureRest.minimum-length = #20 
  \inlineMMR R1*4 
  \inlineMMR R1*6 
  \inlineMMR R1*8 
  \inlineMMR R1*2 
}
{
  \set Score.skipBars = ##t
  \override Score.MultiMeasureRest.expand-limit = 1
  <>^"In-line Multi-Measure Rests"
  \ExampleMusic
}

%---------- Begin 5th example -- crazy chords
%--------------------
%--------------------
% Harm's test
%=> http://lilypond.1069038.n5.nabble.com/RE-Problems-with-LilyJAZZ-ily-td152000.html
<<
  %% "Text_engraver" is inserted for some comments only, delete it
  %% and \notemode { ... }
  \new ChordNames \with { \consists "Text_engraver" }
  \chordmode {
    c2:5- d:sus4.9+ e f g a
    \notemode { s^\markup \fontsize #-3 "Some crazy testing:" }
    b:m5-.6+.7.9-.11+.13+
  }
  \new Staff
  \relative c' {
    \key cis\major
    ces dis e f g a b b
  }
>>

%---------- Begin 6th example -- tempo 1, some improve mixed in
%--------------------
\new Staff
  \new Voice \with {
    \consists "Pitch_squash_engraver"
  }
  \relative c' {
    \numericTimeSignature
    \tempo "Tempo 1" 16 = 120-140
    e8 e g a a16( bes) a8 g
    \improvisationOn
    e8 ~
    \tempo "Tempo 2" 32 = 168
    e2 ~ e8 f4 f8 ~
    f1 ~
    f2
    \improvisationOff
    \tempo "Tempo 1" 32 = 180-200
    a16( bes) a8 g e
  }

%---------- Begin 7th example -- single whole note, tempo = slowly
%--------------------
\score {
   \new Staff {
     \tempo "Slowly" 2 = 60 
     c'1
   }
}

%---------- Begin 8th example -- medium swing, dynamics, D.S. staccato, legato, trumpet
%--------------------
% \fermata
% \bar "||"
% \mark \markup \musicglyph "scripts.segno"  -- D.S.
% geses,4_"Various Accidentals" -- Text below g double flat quarter note
%--------------------
  
% Torsten's test :
%=> http://lilypond.1069038.n5.nabble.com/Pseudo-handwritten-font-tt142117.html#a142689
\score {
  \relative c' {
    \set Staff.instrumentName = "Trumpet "
    \clef treble
    \key es \major
    \time 4/4
    \tempo "Medium Swing"
     r8 es4->\mf f8-. g--  as4-^ bes8-^_\sfz  |
     r4. b8\trill\fff ~ b2 |
     bes?16-> r as4\mp r8 g4( \tuplet 3/2 { es8 f e\pp ~ } |
     e1) \fermata |
     \bar "||"
     \mark \markup \musicglyph "scripts.segno" 
     \clef bass
     \time 5/4
     \key g \major
     geses,4_"Various Accidentals" ges g gis gisis |
  }
  \layout { indent = 10 }
}

%---------- Begin 9th example -- piano score, triplets, bass chords, 
%--------------------
% Name of piece in the header
%   piece = "Beginning of a Bill Evans Solo Transcription — “Time Remembered”"
%--------------------
\score {
  \new PianoStaff <<
    \new Staff \relative c'' {
      \clef treble
      \numericTimeSignature
      \time 4/4
      r8 a \tuplet 3/2 { r e' cis } a2 |
      r8 b \tuplet 3/2 { r a' fis } d2 |
      r8 e \tuplet 3/2 { r d' b } g2 |
      r4 \tuplet 3/2 { r8 b d } \tuplet 3/2 { a' fis d ~ } d4 |
      r4 \tuplet 3/2 { r8 e, g } \tuplet 3/2 { d' b c ~ } c4 |
      r4 r16 d, fis a c8 a bes bes, ~ |
      \tuplet 3/2 { bes8 fis' a } fis g ~ g g, ~ \tuplet 3/2 { g d' f } |
      d8 es ~ es16 es, g d' b?8 c4. | \bar "||"
    }
    \new Staff \relative c {
      \clef bass
      \numericTimeSignature
      \time 4/4
      <cis' d fis>1 |
      <b c e> |
      <g a c e> |
      r8 <fis g b> ~ q4 ~ q2 |
      r8_\markup { \sans "(Example taken from Frank Sikora’s “Neue Jazz-Harmonielehre”, p. 264)" }
      <b c e>4. <f a c e>2 |
      r8 <a bes d>4. ~ q <es g bes d>8 ~ |
      q1 |
      <g as c>1 | \bar "||"
    }
  >>
  \header { 
    piece = "Beginning of a Bill Evans Solo Transcription — “Time Remembered”" 
  }
  \layout {}
}

%---------- Begin 10th example -- Chord names, notes, and name in lilypond DSL
% Write name of chord above measure
%   \new ChordNames \testchords
% Write the notes in the chord (and the name written beneath it)
%   \new Staff\testchords
% \layout { indent = 30 }  -- indents first line
%--------------------
testchords = \chordmode {
  c1 _"c"			
  fis _"fis"
  bes _"bes"			
  c:6 _"c:6"
  c:6.9 _"c:6.9"		
  c:3.5.9 _"c:3.5.9"
  \break
  c:maj _"c:maj" 
  c:maj7.5- _"c:maj7.5-"	
  c:maj7.5+ _"c:maj7.5+" 
  c:maj9 _"c:maj9"		
  c:maj13 _"c:maj13" 
  c:7 _"c:7"			
  \break
  c:9 _"c:9"  
  c:11 _"c:11"			
  c:13 _"c:13" 
  c:m _"c:m" 
  c:m6 _"c:m6" 
  c:m6.9 _"cm:6.9"		
  \break
  c:m5.9 _"c:m5.9" 
  c:m7 _"c:m7" 			
  c:m7.11 _"c:m7.11" 
  c:m7.13 _"c:m7.13"            
  c:5- _ "c:5-" 
  c:m9 _"c:m9"			
  \break
  c:m11 _"c:m11" 
  c:m13 _"c:m13"		
  c:m7+ _"c:m7+" 
  c:m9.7+ _"c:m9.7+"   		
  c:m7.5- _"c:m7.5-" 
  c:m9.5- _"c:m9.5-"		
  \break
  c:m11.5- _"c:m11.5-"
  c:dim _"c:dim"		
  c:dim7 _"c:dim7"
  c:aug _"c:aug"	        
  c:sus2 _"c:sus2"  
  c:sus4 _"c:sus4"              
  \break
  c:sus4.7 _"c:sus4.7"
  c:sus4.7.9 _"c:sus4.7.9"      
  c:sus4.9+ _ "c:sus4.9+"
  c:7.5-_"c:7.5-"	        
  c:7.5+ _"c:7.5+"
  c:9- _"c:9-"			
  \break
  c:9-.5- _"c:9-.5-"
  c:9-.5+ _"c:9-.5+"		
  c:9+ _"c:9+"
  c:9+.5- _"c:9+.5-"		
  c:9+.5+ _"c:9+.5+"  
}

\score {
  <<
    \new ChordNames \testchords
    \new Staff\testchords
    \override Score.SystemStartBar #'collapse-height = #1   % allow a system bracket on a single staff
    \override Score.Clef #'break-visibility = #'#(#f #f #f)	 % just the first clef
    \override Score.KeySignature #'break-visibility = #'#(#f #f #f)	% just the first time signature
  >>
  \header {
    piece ="Jazz Chords Demo"
    opus = \markup {\override #'(font-name . "lilyjazzchord")
      "C<^ D0 E>@"  % juste pour voir la notation classique
    } 	
  }
  \layout { indent = 0 }
}