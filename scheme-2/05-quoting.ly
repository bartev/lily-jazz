\version "2.24.0"

% https://github.com/uliska/scheme-book/blob/master/scheme/quoting/README.md

% quote
% quasiquote
% unquote
% unquote-splicing
% ' (single quote)
% ` (backtick)
% , (comma)
% @ (at)


% quote a value to prevent it from being evaluated

myList = #'(red green blue)

% pairs
#(1 . 2)         ;; bad
#(cons 1 2)      ;; good
#(quote (1 . 2)) ;; good
#'(1 . 2)        ;; good