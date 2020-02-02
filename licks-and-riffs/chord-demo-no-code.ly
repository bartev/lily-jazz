\version "2.18.2"

% Part of tests-0-multiple.ly

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
  c:5.9 _"c:5.9"
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

testchords_no_code = \chordmode {
  c1
  fis
  bes
  c:6
  c:6.9
  c:5.9
  \break
  c:maj
  c:maj7.5-
  c:maj7.5+
  c:maj9
  c:maj13
  c:7
  \break
  c:9
  c:11
  c:13
  c:m
  c:m6
  c:m6.9
  \break
  c:m5.9
  c:m7
  c:m7.11
  c:m7.13
  c:5-
  c:m9
  \break
  c:m11
  c:m13
  c:m7+
  c:m9.7+
  c:m7.5-
  c:m9.5-
  \break
  c:m11.5-
  c:dim
  c:dim7
  c:aug
  c:sus2
  c:sus4
  \break
  c:sus4.7
  c:sus4.7.9
  c:sus4.9+
  c:7.5
  c:7.5+
  c:9-
  \break
  c:9-.5-
  c:9-.5+
  c:9+
  c:9+.5-
  c:9+.5+
}

\score {
  <<
    \new ChordNames \testchords_no_code
    \new Staff\testchords_no_code
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