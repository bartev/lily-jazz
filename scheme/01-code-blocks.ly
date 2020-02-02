\version "2.18.2"

% #{ LilyPond code #}

ritpp = #(define-event-function (parser location) ()
      #{ ^"rit." \pp #}
)

{ c'4 e'4\ritpp g'2 }