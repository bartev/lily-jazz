\version "2.20.0"

\header {
  title = "Scales for Jazz"
  composer = "Bartev"
}

c_maj = \relative c' { c8_\markup { Major (Ionian) } d e f g a b c }
c_dom = \relative c' { c8_\markup { Dominant (Mixolydian) } d e f g a bes c }
c_min_dorian = \relative c' { c8_\markup { Minor (Dorian) } d ees f g a b c }
c_min_melodic = \relative c' { c8_\markup { Minor (Melodic) } d ees f g a b c }
c_min_aeolian = \relative c' { c8_\markup { Minor (Aeolian) } d ees f g aes bes c }
c_locrian = \relative c' { c8_\markup { Locrian } des ees f ges aes bes c }
c_locrian_nat_two = \relative c' { c8_\markup { Locrian nat 2 } d ees f ges aes bes c }
c_wh_dim = \relative c' { c8_\markup { Whole/Half Diminished} d ees f fis gis a b }
c_lydian = \relative c' { c8_\markup { Lydian } d e fis g a b c }
c_lydian_aug = \relative c' { c8_\markup { Lydian Augmented } d e fis gis a b c }
c_hw_dim = \relative c' { c8_\markup { Half/Whole Diminished} cis dis e fis g a bes }
c_mixolydian_f_six = \relative c' { c8_\markup { Mixolydian \flat 6} d e f g aes bes c }
c_alt_dim_whole = \relative c' { c8_\markup { Altered Scale - Diminished Whole Tone} des ees e fis gis bes c }
c_phrygian_dominant = \relative c' { c8_\markup { Phrygian Dominant } des e f g aes bes c }
c_lydian_dominant = \relative c' { c8_\markup { Lydian Dominant} d e fis g a bes c }
c_whole_tone = \relative c' { c8_\markup { Whole Tone Scale} d e fis gis ais c4 }
c_phrygian = \relative c' { c8_\markup { Phrygian } des ees f g aes bes c }
c_dorian_f_two = \relative c' { c8_\markup { Dorian \flat 2} des ees f g a bes c }

{
  \c_maj
  \c_dom
  \break
  \c_min_dorian
  \c_min_melodic
  \c_min_aeolian
  \break
  \c_locrian
  \c_locrian_nat_two
  \c_wh_dim
  \break
  \c_lydian
  \c_lydian_aug
  \break
  \c_hw_dim
  \c_mixolydian_f_six
  \break
  \c_alt_dim_whole
  \c_phrygian_dominant
  \break
  \c_lydian_dominant
  \c_whole_tone
  \break
  \c_phrygian
  \c_dorian_f_two
}