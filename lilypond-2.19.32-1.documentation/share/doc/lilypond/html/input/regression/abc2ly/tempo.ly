\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here (unknown version) -- automatically converted from ABC"
	title = "Tempo marks"
}
voicedefault =  {
\set Score.defaultBarType = ""

\key c \major \clef "bass"
 \tempo  4=120
   c'4    e'4    g'4    c''4    \bar "|" \tempo Andante  2=66
 c'4    e'4    g'4    c''4    \bar "|."   
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
