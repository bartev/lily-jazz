\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\include "impressions-rb.ly"

title = "Impressions"
composer = "Cotrane"
meter = \markup{UP}
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #7
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
    }
  }
}

\header {
  title = \realBookTitle
  copyright = \copyright
  % Remove default LilyPond tagline
  % tagline = ##f
  tagline = "Turrentine"
}

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

eflat_chords = \transpose ees c { \rbChordNames }
eflat_global = \transpose ees c { \rbGlobal }
eflat_melody = \transpose ees c { \rbMelody }

turr_chords = \transpose ees c \chordmode {
  % A
  \repeat unfold 8 { d1:min7 }

  % A
  \repeat unfold 8 { d1:min7 }

  % B
  \repeat unfold 8 { es1:min7 }

  % A
  \repeat unfold 8 { d1:min7 }
}


turr_melody =  \relative c'' {
  \set Score.markFormatter = #format-mark-box-alphabet
  {
   % \bar "[|:"
   \mark \markup { \with-color #red \box "A" }
   b1~
   b2 cis8 e cis b~
   b1~
   b4. cis8 d4 e
   \break

   fis4 a4~ a8 cis,4 b8~
   b2 gis4 b8 fis~
   fis1~
   fis1
   \break

   \mark \markup { \with-color #red \box "A" }
   b1~
   b2 cis8 e cis b~
   b1~
   b4. cis8 d4 e
   \break

   fis4 a4~ a8 cis,4 b8~
   b2 gis4 b8 fis~
   fis1~
   fis1
   \break

   % \bar ":|]"

   % \bar ".|"
   \mark \markup { \with-color #red \box "B" }
   c'1~
   c4. bes8 ees4 d8 c~
   c1~
   c4. d8 ees4 f
   \break

   g4 bes4~ bes8 d,4 c8~
   c2 a4 c8 g~
   g1~
   g1
   \bar "|." 
   \break

   \bar ".|"
   \mark \markup { \with-color #red \box "A" }
   b1~
   b2 cis8 e cis b~
   b1~
   b4. cis8 d4 e
   \break

   fis4 a4~ a8 cis,4 b8~
   b2 gis4 b8 fis~
   fis1~
   fis1
   \bar "|." 
  }
 
}

\score {
  <<
    \new ChordNames { \turr_chords }
    \new Staff {
         \eflat_global
         % \eflat_melody
         \turr_melody
    }
  >>
}

% \score {
%   <<
%     \new ChordNames { \rbChordNames }
%     \new Staff {
%          \rbGlobal
%          \rbMelody
%          }
%   >>
% }
