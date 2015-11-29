\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here (unknown version) -- automatically converted from ABC"
	title = "Various different clefs"
}
wordsdefaultVA = \lyricmode {
none _  _  _  | treble _  _  _  | bass _  _  _  | 
baritone _  _  _  | tenor _  _  _  | alto _  _  _  |  
mezzosoprano _ _ _ | soprano _ _ _ | treble- "8" _ _ |   
treble- "8va" _ _ | "treble+8" _ _ _ | "treble8" _ _ _ |   
}
voicedefault =  {
\set Score.defaultBarType = ""

  c'4    e'4    g'4    c''4    \bar "|" \key c \major \clef "treble"
 c'4    e'4    g'4    c''4    \bar "|" \key c \minor \clef "bass"
 c'4    ees'4    g'4    c''4    \bar "|"   \key c \major \clef "varbaritone"
 c'4    e'4    g'4    c''4    \bar "|" \key c \minor \clef "tenor"
 c'4    ees'4    g'4    c''4  \bar "|" \key c \major \clef "alto"
 c'4    e'4    g'4    c''4    \bar "|"   \key c \minor \clef "mezzosoprano"
 c'4    ees'4    g'4    c''4    \bar "|" \key c \major \clef "soprano"
 c'4    e'4    g'4    c''4    \bar "|" \key c \minor \clef "treble_8"
 c4    ees4    g4    c'4    \bar "|"   \key c \major \clef "treble_8"
 c4    e4    g4    c'4    \bar "|" \key c \minor \clef "treble^8"
 c''4    ees''4    g''4    c'''4    \bar "|" \key c \major \clef "treble_8"
 c4    e4    g4    c'4    \bar "|."   
}

\score{
    <<

	\context Staff="default"
	{
	    \voicedefault 
	}

	\addlyrics {
 \wordsdefaultVA } 
    >>
	\layout {
	}
	\midi {}
}
