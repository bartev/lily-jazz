\version "2.20.0"

% #{ LilyPond code #}

ritpp = #(define-event-function () ()
      #{ ^"rit." \pp #}
)

{ c'4 e'4\ritpp g'2 }