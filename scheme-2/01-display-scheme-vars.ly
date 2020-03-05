\version "2.20.0"

% #{ LilyPond code #}

% There are some notable differences between the commands:

% display can show any value while ly:message only processes strings (but this can be circumvented using the format procedure)
% display will not produce a newline, so that should always be done manually (through #(newline))
% ly:message will print immediately while display only acts after parsing has been finished.

myVariable = "This is a variable"
otherVar = "this is another var"

#(ly:message otherVar)

#(display myVariable)

#(display otherVar)
#(newline)
#(display myVariable)
