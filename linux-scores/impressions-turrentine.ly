\version "2.24.0"

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
  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
  {
   \bar ".|-|"
   \mark \markup { \with-color #red \box "A" \with-color #red "0:10" }
   b1~
   b2 cis4. b8~
   b1~
   b4 cis-- d-. e-.
   \break

   \mark \markup { \with-color #red "0:14" }
   fis2-- a8-. cis,4 b8~
   b2 gis4. fis8~
   fis1~
   fis1
   \break

   \mark \markup { \with-color #red \box "A" \with-color #red "0:18" }
   b1~
   b2 cis8 e cis b~
   b1
   r8 cis8~ cis4-- d4-. e-.
   \break

   \mark \markup { \with-color #red "0:23" }
   fis2-- a8-. cis,4 b8~
   b2 gis4 b8 fis~
   fis1~
   fis2 r2
   \break

   % \bar ":|]"

   % \bar ".|-|"
   \mark \markup { \with-color #red \box "B" \with-color #red "0:28" }
   c'1~
   c2 d4. c8~
   c1
   r8 d8~ d4-- ees4-. f-.
   \break

   \mark \markup { \with-color #red "0:32" }
   g2-- bes8-. d,4 c8~
   c2 a4 c8 g~
   g1~
   g2 r2
   \bar "|." 
   \break

   \bar ".|-|"
   \mark \markup { \with-color #red \box "A" \with-color #red "0:37" }
   b1~
   b2 cis8 e cis b~
   b1
   r8 cis8~ cis4-- d4-. e-.
   \break

   \mark \markup { \with-color #red "0:42" }
   fis2-- a8-. cis,4 b8~
   b2 gis4 b8 fis~
   fis1~
   fis2 r2
   \bar "|." 
   \break
   \pageBreak
  }
 
}


turr_solo = \relative c'' {

   % 2ND TIME (begin solo)
          
   \mark \markup { \with-color #red \box "A" \with-color #red "0:46" }
   r1
   r4. b8 cis b cis d 
   cis4 b e2~ 
   e4-^ r4 \tuplet 3/2 {cis8 b a} gis8 a 
   \break

   \mark \markup { \with-color #red "0:50" }
   fis2 gis4 f8 fis
   % gis8 f fis 
   r8  gis8 fis8 a e' r8 \tuplet 3/2 {cis8 d cis}
   b8 cis a gis fis r r4
   r1
   \break

   \mark \markup { \with-color #red "0:55" }
   b4-^ fis'8-- e-. r2
   cis4-- e8-- d~ d4 r4
   r8 gis8-^ f-^ fis-^ d-^ r8 r4
   gis8 a~ a4 gis4 b8 gis~ 
   \break

   \mark \markup { \with-color #red "1:00" }
   gis4 e8 fis8~ fis4 d8 e8~ 
   e4 cis8 d~ d4 b8 cis8~
   \mark \markup { \with-color #red "wrong - figure this out" }
   cis4 a8 b8~ b4 gis8 e 
   fis8 r8 r4 r2
   \break

   \mark \markup { \with-color #red "1:05" }
   bes8 c d d bes r8 d4(
   f8) r8 f4( g8) r8 r4
   \repeat unfold 2 { s1 } \break

   \mark \markup { \with-color #red "1:09" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:13" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:18" }
   \repeat unfold 4 { s1 } \break

   \pageBreak


   % 3RD TIME

   \mark \markup { \with-color #red "1:22" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:27" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:32" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:37" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:45" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:46" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:51" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "1:55" }
   \repeat unfold 4 { s1 } \break
   \pageBreak

   % 4TH TIME

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:04" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break

   \mark \markup { \with-color #red "2:00" }
   \repeat unfold 4 { s1 } \break
   \pageBreak
}

\score {
  <<
    \new ChordNames { 
         \turr_chords 
         \turr_chords 
         \turr_chords 
         \turr_chords 
         }
    \new Staff {
         \eflat_global
         % \eflat_melody
         \turr_melody
         \turr_solo
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
