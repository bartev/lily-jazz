%{
Welcome to LilyPond
===================

Congratulations, LilyPond has been installed successfully.

Now to take it for the first test run.

  1. Save this file

  2. Select

       Compile > Typeset file

  from the menu.

  The file is processed, and

  3.  The PDF viewer will pop up. Click one of the noteheads.


That's it.  For more information, visit http://lilypond.org .

%}

\header{
  title = "A scale in LilyPond"
}

\relative {
  c'1 d e f g a b c
}


\version "2.24.0"  % necessary for upgrading to future LilyPond versions.
