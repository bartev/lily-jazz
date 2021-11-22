\version "2.20.0"

%% These settings give 2 pages of 12 staves each
%% size = 28 -> 10 staves
#(set-global-staff-size 28)

%% Create blank staves
%% http://lilypond.org/doc/v2.19/Documentation/snippets/staff-notation#staff-notation-creating-blank-staves

\paper {
  #(set-paper-size "letter")
  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 1\in
  bottom-margin = 0.75\in
  ragged-last-bottom = ##f
  print-page-number = ##f
}

\header {
  %% tagline= "Staff paper by Bartev"
  copyright = ##f
  tagline = ##f
}

emptymusic = \repeat unfold 12 { s1 \break }

\score {
  \layout {
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
  {
    %% put a pageBreak after each 12 staves to force them all to be on one page
    
    \emptymusic
    \pageBreak
    \emptymusic
  }
  
}

