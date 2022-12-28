\version "2.24.0"

startParenthesis = {
  \once \override Parentheses.stencils = #(lambda (grob)
        (let ((par-list (parentheses-interface::calc-parenthesis-stencils grob)))
          (list (car par-list) point-stencil )))
}

endParenthesis = {
  \once \override Parentheses.stencils = #(lambda (grob)
        (let ((par-list (parentheses-interface::calc-parenthesis-stencils grob)))
          (list point-stencil (cadr par-list))))
}


\score {
  \relative c''' {
    \override Parentheses.font-size = #0.5
    \startParenthesis \parenthesize d4 \endParenthesis \parenthesize d8
    c b g f a |
  }
}