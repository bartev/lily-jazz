\version "2.7.40"
\header {
	crossRefNumber = "2"
	footnotes = ""
	tagline = "Lily was here (unknown version) -- automatically converted from ABC"
	title = "Tuplets and slurs"
}
voicedefault =  {
\set Score.defaultBarType = ""

\time 4/4 \key c \major   a''8    \times 2/3 {   g''8 (   a''8    b''8  -) }   
a''8    \times 2/3 {   g''8 (   a''8    b''8  -) }   
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
