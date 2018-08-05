\version "2.19.80"

% https://vdocuments.site/branford-marsalis-englishman-in-new-york-solo-transcription.html

#(set-global-staff-size 24)
\include "../../stylesheets/jazzchords.ily"
\include "../../stylesheets/lilyjazz.ily"
\include "../../stylesheets/jazzextras.ily"

title = #"Englishman in New York"
subtitle = #"Branford Marsalis Solo"
composer = #""
meter = #""
copyright-enginny = #"Sting"

realBookTitle-enginny = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #8
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger \larger #title
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


theNotes = \relative c''' {
  \key e \major
  \time 4/4
  \set Staff.midiInstrument = "soprano sax"

  gis1~ | gis~ | gis~ |
  gis4.. gis16 \tuplet 3/2 {gis8( fis e)} dis8 e | \break

  gis,8 cis4.( cis2 |
  cis2 cis4 ) a4~ |
  a4.. fis16 gis2~ |
  \tuplet 3/2 4 { gis8 a b fis gis a b fis gis~ gis fis e~ } | \break

  e2 r2 |
  r1 |
  r1 |
  r2 fis'16 dis b a gis8 dis'~ | \break

  dis2 r2 |
  r1 |
  r1 |
  r4 r16 b'16 gis dis r16 fis cis b r16 b gis a~ | \break

  a4 r4 r2 |
  r1 |
  r1 |
  r8 r16 e'16 fis gis a gis a8 gis16 fis e8 fis16 eis | \break
  
  dis8 e16 dis cis 8 dis16 e fis e dis4 r8 |
  r1
  r1
  cis4~ \tuplet 3/2 { cis8 cis dis } bis8. cis16 dis8. e16 | \break

  fis4 r2 gis8. fis16~ 
  fis2 r2 |
  gis,16 b8.~ b4 r4 \tuplet 3/2 { r8 fis' e } |
  gis,2~ gis4 r4 | \break
}

bop-eng-in-ny = \bookpart {
  \tocItem \markup "Englishman in New York"
  \header {
    title = \realBookTitle-enginny
    tagline = ##f
    copyright = \copyright-enginny
  }
  \score {
    <<
      \new Voice = soloist \theNotes
    >>
    \layout {
      \override Score.Clef #'break-visibility = #'#(#f #f #f)  % make only the first clef visible
      \override Score.KeySignature #'break-visibility = #'#(#f #f #f)  % make only the first time signature visible
      \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
    }
    \midi {
      
      \tempo 2 = 60
    }

  }
}

\bop-eng-in-ny