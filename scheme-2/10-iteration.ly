\version "2.20.0"

% map

% (map proc list)

% all-grob-descriptions

% uncomment to see this
% #(display (first all-grob-descriptions))

% (Accidental 
%   (after-line-breaking . #<primitive-procedure ly:accidental-interface::remove-tied>) 
%   (alteration . #<procedure accidental-interface::calc-alteration (grob)>) 
%   (avoid-slur . inside) 
%   (extra-spacing-width -0.2 . 0.0) 
%   (glyph-name . #<procedure accidental-interface::glyph-name (grob)>) 
%   (glyph-name-alist (0 . "accidentals.natural") 
%                     (-1/2 . "accidentals.flat") 
%                     (1/2 . "accidentals.sharp") 
%                     (1 . "accidentals.doublesharp") 
%                     (-1 . "accidentals.flatflat") 
%                     (3/4 . "accidentals.sharp.slashslash.stemstemstem") 
%                     (1/4 . "accidentals.sharp.slashslash.stem") 
%                     (-1/4 . "accidentals.mirroredflat") 
%                     (-3/4 . "accidentals.mirroredflat.flat")) 
%   (stencil . #<primitive-procedure ly:accidental-interface::print>) 
%   (horizontal-skylines . 
%                        #<unpure-pure-container 
%                        #<primitive-procedure 
%                        ly:accidental-interface::horizontal-skylines> >) 
%   (vertical-skylines . #<unpure-pure-container 
%                        #<primitive-procedure 
%                        ly:grob::vertical-skylines-from-stencil> 
%                        #<primitive-procedure 
%                        ly:grob::pure-simple-vertical-skylines-from-extents> >) 
%   (X-offset . #<primitive-procedure ly:grob::x-parent-positioning>) 
%   (Y-extent . #<unpure-pure-container #<primitive-procedure ly:accidental-interface::height> >) 
%   (meta (name . Accidental) 
%         (class . Item) 
%         (interfaces grob-interface 
%                     accidental-interface 
%                     font-interface 
%                     inline-accidental-interface 
%                     item-interface)))

% In order to extract a plain listing of all grob names we have to 
% retrieve the first element from each sub-list, which can 
% conveniently be achieved using car.

% use map to dissect nested lists

contextMod = \with {
           instrumentName = "Violin"
           shortInstrumentName = "VI." }

mods = #(ly:get-context-mods contextMod)

#(display mods)

options = #(list (cons 'instrumentName "Violin")
                 (cons 'shortInstrumentName "VI."))
#(newline)
#(write options)    % includes quotes
#(newline)
#(display options)  % no quotes


% (lambda (mod) (cons (second mod) (third mod)))

options_two = #(map (lambda (mod) (cons (second mod) (third mod))) mods)
#(newline)
#(write options_two)    % includes quotes
#(newline)
#(display options_two)  % no quotes
