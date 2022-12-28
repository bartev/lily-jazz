\version "2.24.0"

% https://github.com/uliska/scheme-book/blob/master/scheme/alists/retrieving.md


% if I use symbols as keys in alists, I should use the "q" variants of the procedures
% assq     ;; returns (key . value)
% assq-ref ;; returns the value

% assv
% assoc

% Note: order of parameters is reversed
% (assq key alist)
% (assq-ref alist key)

#(define my-alist
 '((color1 . red)
   (color2 . green)
   (color3 . blue)))

#(define my-new-alist
`((color1 . ,red)
  (color2 . ,green)
  (color3 . ,blue)))

#(define bool-alist
       '((subdivide . #t)
         (use-color . #f)))

% Adding elements to an alist
#(acons 'debug #f bool-alist
#(set! bool-alist (acons 'debug #f bool-alist))

% replace value if key exists, else add key-value pair
#(assq-set! bool-alist 'debug #t)

% Remove elements
% assq-remove! <alist> <key>