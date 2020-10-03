% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefilename "/home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-stable-2.20/input/regression/accidental-cautionary.ly"
\sourcefileline 0
\version "2.20.0"
\header {

texidoc = "Cautionary accidentals may be indicated using either
parentheses (default) or smaller accidentals.

"

}

\layout { ragged-right = ##t }

{
    c''4
    cis''?4
    \once \override Staff.AccidentalCautionary.parenthesized = ##f
    \once \override Staff.AccidentalCautionary.font-size = #-2
    cis''?4
    \once \override Staff.AccidentalCautionary.parenthesized = ##t
    cis''?4
    c''?
}




% ****************************************************************
% end ly snippet
% ****************************************************************