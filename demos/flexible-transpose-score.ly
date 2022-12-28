\version "2.24.0"
%% http://lsr.di.unimi.it/LSR/Item?id=787
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/changing-multiple-pitches#transpose

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
#(set! paper-alist (cons '("snippet" . (cons (* 90 mm) (* 90 mm))) paper-alist))
\paper {
  #(set-paper-size "snippet")
  indent = 15
  tagline = ##f
}

\markup\vspace #.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%here starts the snippet:

global = {
  \time 4/4
}

MyTranspose = 
#(define-music-function (m)
  (ly:music?)
  #{ \transpose f d $m #})
% In the previous line the transposition of the whole score is defined
% (in this case from f major down to d major).
\markup "Transposed from F to D"

% To deactivate the transposition remove the comment sign from the
% following line:
% MyTranspose = {}

Basekey = {
  \key f \major
}

FltPitches = \relative c'' { c d bes c }
TrpPitches = \relative c'' { c d bes c }

Flt = \new Voice {
  \set Staff.instrumentName = #"Flute" 
  \MyTranspose { \Basekey \FltPitches }
}
Trp = \new Voice \transpose bes c' { 
  \set Staff.instrumentName = #"Trumpet" 
  \MyTranspose { \Basekey \TrpPitches }
}
\score {
  \new StaffGroup {
    << 
      \new Staff { << \global \Flt >> }
      \new Staff { << \global \Trp >> }
    >> }
  \layout {}
}

% End of the example
% =============================================================
% The remainder is just for visualisation the deactivation of the
% transposition in a single snippet. You don't need this code in
% normal use...

\markup "The same without transposition:"
MyTranspose = {}

% The remainder is just a copy of the corresponding lines above:
Flt = \new Voice {
  \set Staff.instrumentName = #"Flute" 
  \MyTranspose { \Basekey \FltPitches }
}
Trp = \new Voice \transpose bes c' { 
  \set Staff.instrumentName = #"Trumpet" 
  \MyTranspose { \Basekey \TrpPitches }
}
\score {
  \new StaffGroup {
    << 
      \new Staff { << \global \Flt >> }
      \new Staff { << \global \Trp >> }
    >> }
  \layout {}
}