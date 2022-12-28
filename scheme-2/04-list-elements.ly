\version "2.24.0"

#(define lst '(1 2 3 4))
mylist_ii = #'(1 2 3 4)

% should resolve to the same thing -- 4
#(list-ref lst 3)
#(fourth lst)


% Skip first 2 elements
#(list-tail lst 2)    ;; (3 4)
#(list-head lst 2)    ;; (1 2)

% Search for elements in a list - 3 equality modes
% (<function> <element> <list>)
% memq    - eq?
% memv    - eqv?
% member  - equal?

#(memv 3 '(1 2 3 4 5 6))
#(memq 3 '(1 2 3 4 5 6))
#(member 3 '(1 2 3 4 5 6))

% (filter <predicate> <list>)
% "true" value is anything that's not #f
#(filter number? '(1 2 "d" 'e 4 '(2 . 3) 5))

% replace predicate with equal?
% delete - equal?
% delq   - eq?
% delv   - eqv?
#(delete 3 '(1 2 3 4 5))

% Uses equal?
#(delete-duplicates '("a" 2 3 "a" b 3))

% Iterate over lists
% applies a procedure to each element
% map
% for-each