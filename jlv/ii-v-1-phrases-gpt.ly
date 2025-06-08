\version "2.24.2" % Ensure compatibility with your version of LilyPond

% Basic formatting
\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  between-system-space = 2.\cm
  between-system-padding = #0

  %% set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f

}

\markup { "Exercise 3: Write 8th notes against the given bass line." }

\score {
  \new StaffGroup <<
    \new ChordNames {
      \chordmode {
        % Chord symbols for ii-V-I in C minor
        d1:m7  % D minor 7 (ii)
        g:7    % G7 (V)
        c1:m   % C minor (i)
      }
    }
    \new Staff {
      \relative c' {
        \key c \minor
        \time 4/4

        % Musical phrase
        d4 f a c   % D minor 7 arpeggio
        g4 b d g   % G7 arpeggio
        c,4 ees g c % C minor arpeggio
      }
    }
  >>
}


\markup { "Exercise 3: Write 8th notes against the given bass line." }

\score {
  \new StaffGroup <<
    \new ChordNames {
      \chordmode {
        % Chord symbols for ii-V-I in C minor
        d1:m7  % D minor 7 (ii)
        g:7    % G7 (V)
        c1:m   % C minor (i)
      }
    }
    \new Staff {
      \relative c' {
        \key c \minor
        \time 4/4

        % Musical phrase
        d4 f a c   % D minor 7 arpeggio
        g4 b d g   % G7 arpeggio
        c,4 ees g c % C minor arpeggio
      }
    }
  >>
}