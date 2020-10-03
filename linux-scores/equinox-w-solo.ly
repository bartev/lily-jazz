\version "2.20.0"

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-paper-size "letter")
  %  paper-height = 11\in
  %  paper-width = 8.5\in
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

title = #"Equinox"
composer = #"'Trane"
meter = \markup{Alto Sax - Coltrane key}
copyright = #"Coltrane's Sound"

realBookTitle = \markup {
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


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

headNotesOnly = \relative c' {
  ees'4. c8 ~ c2 ~ |
  c2. ~c8 g8 |
  ees'8 c8 ~ c2 ~ c8 g8 | \break

  c8 ees8 r4 r4 r8 ees8 |
  f4. c8 ~ c2 ~ |
  c2.. f8 | \break

  ees4. c8 ~ c4. g8 |
  c8 ees8 r4 r2 |
  r8 d8 r4 d4. c8 | \break

  d4. c8 ees c ees4 |
  c1 ~ |
  c2.. g8 | \break
}

theNotes = \relative c'' {
  \key c \major
  \partial 8 g8 |
  \showStartRepeatBar \bar "[|:"
  \mark \default
  \headNotesOnly
}

theBassLine = \relative c {
  \clef bass
  \key c \major
  \partial 8 r8 |
  \showStartRepeatBar \bar "[|:"
  c4. c8 ~ c4 c4 ~ |
  c2 g4 bes4 |
  c4. c8 ~ c4 c4 ~ | \break

  c2 c4 ees4 |
  f4. f8 ~ f4 f4 ~ |
  f2 g,4 bes4 | \break

  c4. c8 ~ c4 c4 ~ |
  c1 |
  aes1 | \break

  g1 |
  c4. c8 ~ c4 c4 ~ |
  c2 g4 bes | \break
}

% look at PercentRepeat, SlashRepeat, Percent_repeat_engraver, Slash_repeat_engraver

theChords = \chordmode {
  c1:m7 |
  c1:m7 |
  c1:m7 | \break
  c1:m7 |
  f1:m7 |
  f1:m7 | \break
  c1:m7 |
  c1:m7 |
  aes:7 | \break
  g1:7  |
  c1:m7 |
  c1:m7 | \break
}

theChordsPlusEighth = \chordmode{
  \partial 8 s8 |
  \theChords
}

transHeadNotes = \transpose c bes, \headNotesOnly
transNotes = \transpose c bes, \theNotes
transChords = \transpose c bes, \theChords
transChordsPlusEighth = \transpose c bes, \theChordsPlusEighth
transBassLine = \transpose c es \transpose c bes,  \theBassLine


firstTime = \relative c' {
  \key bes \major
  \partial 8 f8 |
  \showStartRepeatBar \bar "[|:"

  \mark \markup { A 0:28 }
  des'8 bes4. ~ bes2 ~ |
  bes2 r4 r8 f8 |
  des'4. bes8 ~ bes2 ~ | \break

  bes2 r4 r8 des8 |
  es8 bes4. ~ bes2 ~ |
  bes2 r4 r8 f8 | \break

  des'8 bes4. ~ bes2 ~ |
  bes4 r4 bes16 des r8 r4 |
  r8 c8 ~ c4 c4 c | \break

  c4. bes8 des bes des4 |
  bes4. bes8 ~ bes4 bes4 ~ |
  bes2 r4 r8 g8 \bar ":|]" \break
}
secondTime = \relative c'' {
  \mark \markup { B 0:52 }
  des4. bes8 r2 |
  r2 r4 r8 f16 f |
  des'8 bes8 ~ bes2 bes16 c r8 | \break

  r2 r4 r8 des8 |
  es8 bes4. ~ bes2 ~ |
  bes2 c8 g8 r8 f8 | \break

  des'8 bes4. ~ bes4. r8 |
  bes8 f r4 r2 |
  r8 c'8 ~ c4 c4 c | \break

  c4. bes8 des bes des4 |
  bes4. bes8 ~ bes4 bes4 |
  r4 f'8 aes8 ~ aes4 \tuplet 3/2 { f8 es8 des8 }  | \break
}
thirdTime = \relative c'' {
  \mark \markup { C 1:16 }
  bes4 ~ bes8 bes8 ~ bes4 r4 |
  r4 f16 bes bes4. bes4 |
  bes8 r8 r4 r4 r8 f' | \break

  \tuplet 3/2 { bes8 aes bes ~ } bes4 r2 |
  \repeat unfold 8 { s1 }
}

emptyLines = {
  \repeat unfold 12 { s1 }
}

\book {
  \score {
    <<
      \new ChordNames \transChordsPlusEighth
      \new Voice = soloist \firstTime
      \new ChordNames \transpose c es \transChordsPlusEighth
      \new Voice = soloist \transBassLine
    >>
    \layout {
      \override Score.Clef #'break-visibility = #'#(#f #f #f)  % make only the first clef visible
      \override Score.KeySignature #'break-visibility = #'#(#f #f #f)  % make only the first time signature visible
      \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
    }
  }
  \pageBreak
  \score {
    <<
      \new ChordNames \transChords
      \secondTime
    >>
  }
  \markup { \draw-hline }
  \score {
    <<
      \new ChordNames \transChords
      \thirdTime
    >>
  }
  \pageBreak
  \score {
    <<
      \new ChordNames \transChords
      \emptyLines
    >>
  }
  \markup { \draw-hline }
  \score {
    <<
      \new ChordNames \transChords
      \emptyLines
    >>
  }

}