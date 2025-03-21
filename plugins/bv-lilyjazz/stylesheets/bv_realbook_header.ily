%% 2025-01-20

%% Usage
%% \realBookHeader
%% #'((title . "Inner Urge")
%%    (composer . "Joe Henderson")
%%    (arranger . "Real Book v1, 5th ed")
%%    (instrument . "Alto Sax")
%%    (note . 4)
%%    (meter . "180")
%%    (tagline . "Bartev 2024-10")
%%    (copyright . "Bartev 2024"))

#(define (realBookHeader args)
  (let* ((title (assoc-get 'title args ""))
         (composer (assoc-get 'composer args ""))
         (arranger (assoc-get 'arranger args ""))
         (instrument (assoc-get 'instrument args ""))
         (note (assoc-get 'note args 4))
         (meter (assoc-get 'meter args ""))
         (tagline (assoc-get 'tagline args ""))
         (copyright (assoc-get 'copyright args "")))
   
   #{
   \markup {
   \score {
   {
   \override TextScript.extra-offset = #'(0 . -6) % Adjust vertical position (X . Y)
   s^\markup {
     \fill-line {
       %% Left side: Meter and instrument
       \vcenter {
         \column {
           %% Meter
           {\fontsize #2 \lower #2 \rotate #7 \concat { \note { #note } #1  " = " #meter }}
           {\fontsize #1 \instrument}
         }
       }
       %% Center: Title
       \vcenter {
         \fontsize #7
         \override #'(thickness . 6)
         { \override #'(offset . 18)
           \underline
           #title
         }
       }
       %% Right side: Composer and Arranger
       \vcenter {
         \right-column {
           \fontsize #3 \lower #1 \concat { #composer " " }
           \fontsize #0 \lower #1 \concat { #arranger " " } 
         }
       }
     }
   }
 }
   \layout {
     \omit Staff.Clef
     \omit Staff.TimeSignature
     \omit Staff.KeySignature
     ragged-right = ##f
     ragged-bottom = ##f
     ragged-last-bottom = ##t
     \override Score.BarLine.transparent = ##t
   }
 }
 }
   #}
)
)