\version "2.20.0"

startParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list (car par-list) point-stencil )))
}

endParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list point-stencil (cadr par-list))))
}


\score {
  \relative c''' {
    \override ParenthesesItem.font-size = #0.5
    \startParenthesis \parenthesize d4 \endParenthesis \parenthesize d8
    c b g f a |
  }
}