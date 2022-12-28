\version "2.24.0"

% https://github.com/uliska/scheme-book/blob/master/scheme/data-types/lists-and-pairs/creating-pairs.md

% #{ LilyPond code #}

{ 
c'8 \p b \f a b
}
{
\override Beam.positions = #'(2 . 3) 

% place the dynamic to the left 2, and up 4 -- not sure what the units are
\once \override DynamicText.extra-offset = #'(-2 . 4)
\override DynamicText.color = #red
c'8 \p b \f a b
}
{
\override Beam.positions = #'(2 . 5) 
c'8 \p b \f a b
}
{
\override Beam.positions = #'(0 . 0) 
c'8 \p b \f a b
}


{ 
\override Beam.positions = #(cons (random 5.0) (random 5.0)) 
\once \override DynamicText.extra-offset = #(cons (random 5.0) (random 5.0)) 
c'8 \p b a b 
}


% symbol-list
mySym = #'(red green blue)

myOtherSym = this.is.one.symbol.list
mylastSym = red,green,blue

one = #'(this is a symbol-list) 
% failOne = this.is.a.symbol-list

\relative c''{
\override NoteHead.color = #red

c d e f 
}

\relative c''{
\override NoteHead.color = #(x11-color 'LimeGreen) 
c d e f 
}

