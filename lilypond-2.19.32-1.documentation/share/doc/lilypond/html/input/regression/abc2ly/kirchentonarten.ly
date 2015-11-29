\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here (unknown version) -- automatically converted from ABC"
	title = "Church mode (E Dorian)"
}
voicedefault =  {
\set Score.defaultBarType = ""

 \override Staff.TimeSignature #'style = #'C
 \time 4/4 \key e \dorian \clef "bass"
   e'16    b'8.    b'8.    a'16    b'8.    a'16    b'16    d''8.  \bar "|"   
fis'16    d'8.    a'8.    d'16    b'8.    d'16    a'8.    fis'16  \bar "|"   
e''8.    cis''16    e''16    g''8.    e''8.    b'16    e''16    g''8.  \bar "|" 
  
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
