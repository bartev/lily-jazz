\version "2.20.0"

% http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers#default-layout-of-bookpart-and-score-titles

% Example showing 

% book title page
% score 1 with own title
% score 2 with own title

\header {
  title = "Book Header outside"
  tagline = "BV book example"
  copyright = "BV copyright"
}

mybook = \book {
  \paper {
    % print-all-headers = ##t
  }

  \header {
      % The following fields are centered
    dedication = "Dedication"
    title = "Book Title (in Book)"
    subtitle = "Subtitle (in Book)"
    subsubtitle = "Subsubtitle (in Book)"
      % The following fields are evenly spread on one line
      % the field "instrument" also appears on following pages
      % poet   --   instrument  --  composer
    poet = "Poet (in Book)"
    instrument = \markup \with-color #red "Instrument (in Book)"
    composer = "Composer (in Book)"
      % The following fields are placed at opposite ends of the same line
    meter = "Meter (in Book)"
    arranger = "Arranger (in Book)"
      % The following fields are centered at the bottom
    tagline = "tagline goes at the bottom of the last page (in Book)"
    copyright = "copyright goes at the bottom of the first page (in Book)"

  }

  % \pageBreak

  \score {
    \transpose ees c \new Staff {
      \new Voice {
        \key c \major
        \relative c'' { c8 d e f  g f e c  s1 }
      }
    }
    \header {
      title = "Score 1 header"
      subtitle = "Score 1 subtitle"
        % The following fields are placed at opposite ends of the same line
      piece = "Piece 1"
      opus = "Opus 1"
      breakbefore = ##t
    }
  }

  % \pageBreak

  \score {
    \new Staff {
      \new Voice {
        \clef "bass"
        \relative c { c8 d e f  g f e c }
      }
    }
    \header {
      % title = "Score 2 header"
      % opus = "Score 2 opus"
      subtitle = ##f
      breakbefore = ##t

      piece = \markup {
        % \larger "hello"
            \score {
            {
            % lower the text to be on in the staff
            \override TextScript.extra-offset = #'(0 . -4.5)
            s4
            % needs to be markup to something
            s^\markup {
            \fill-line {
            \fontsize #1 \lower #1 \rotate #7 \concat { " " \fromproperty #'header.meter }
            \fontsize #7
              % not sure what thie offset is doing
              \override #'(offset . 7)
              \override #'(thickness . 6)
              \underline \larger "Hello"
            \fontsize #7
              \underline \larger "Hello 2"
            }
            }
            }
    %           {
    %             \markup { \larger "My piece title" }
    %           }
              \layout {
                    \omit Staff.Clef
                    \omit Staff.TimeSignature
                    \omit Staff.KeySignature
                    ragged-right = ##f
              }
      }
    }
  }
}
}

% #(ly:book-header mybook)

% works
\mybook

% does not work
% #(mybook)