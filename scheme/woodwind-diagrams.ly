\version "2.18.2"

\header {
  lsrtags = "winds"

  texidoc="
the snippet below produces a list of all possible keys and key
settings for woodwind diagrams as defined in
@file{scm/define-woodwind-digrams.scm}. The list will be displayed
in the log file, but not in the music. If output to the console
is wanted, omit the @code{(current-error-port)} from the commands.
"

  doctitle = "Woodwind diagrams key lists"

}

% #(print-keys-verbose 'saxophone) 

#(with-output-to-port(current-error-port)
  (lambda ()
    (print-keys-verbose 'saxophone)))