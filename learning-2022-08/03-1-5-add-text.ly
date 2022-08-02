\version "2.20.0"

\relative { c''2^"espr" a_"legato" }

\relative {
  c''2^\markup { \bold espr }
  a2_\markup {
    \dynamic f \italic \small { 2nd } \hspace #0.1 \dynamic p }
}
