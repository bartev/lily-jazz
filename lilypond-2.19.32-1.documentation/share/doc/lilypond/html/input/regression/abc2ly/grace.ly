\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here (unknown version) -- automatically converted from ABC"
	title = "abc2ly grace note bug (missing square bracket, duration of grace notes)"
}
voicedefault =  {
\set Score.defaultBarType = ""

 \override Staff.TimeSignature #'style = #'C
 \time 4/4 \key e \dorian   \grace {    g''8    a''8  }   g''8    d''8    g''8  
  b''8  \grace {    a''8  }   g''8.    d''16    g''16    a''8.  \bar "|"   
}

\score{
    <<

	\context Staff="default"
	{
	    \voicedefault 
	}

    >>
	\layout {
	}
	\midi {}
}
