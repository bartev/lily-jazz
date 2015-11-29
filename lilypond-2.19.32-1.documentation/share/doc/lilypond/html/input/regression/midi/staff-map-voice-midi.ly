% Lily was here -- automatically converted by /home/gub/NewGub/gub/target/linux-x86/src/lilypond-git.sv.gnu.org--lilypond.git-release-unstable/scripts/midi2ly.py from out-www/staff-map-voice.midi
\version "2.14.0"

\layout {
  \context {
    \Voice
    \remove "Note_heads_engraver"
    \consists "Completion_heads_engraver"
    \remove "Rest_engraver"
    \consists "Completion_rest_engraver"
  }
}

% included from ./out-www/staff-map-voice.header
\header {
texidoc="Midi2ly remaps voices correctly to staves in MIDI-files that use voice<->channel mapping when combined with staff<->track mapping.  TODO: pianostaff"
options=""
}
% end

trackAchannelA = {


  \key c \minor
    
  % [TEXT_EVENT] creator: 
  
  % [TEXT_EVENT] GNU LilyPond 2.19.32          
  
  \time 4/4 
  
  \tempo 4 = 60 
  
}

trackA = <<
  \context Voice = voiceA \trackAchannelA
>>


trackBchannelA = {
  

  \key c \minor
  
  \set Staff.instrumentName = "treble:one"
  
}

trackBchannelB = \relative c {
  \voiceOne
  f''8 ees16 d c bes aes g f8 aes' g f 
  | % 2
  f,16 g aes4 g16 f e2 
  | % 3
  
}

trackBchannelC = \relative c {
  \voiceTwo
  c''4 r4. f8 ees d 
  | % 2
  <b, d >8 r8 <b d >8 r8 <g c >2 
  | % 3
  
}

trackB = <<
  \context Voice = voiceA \trackBchannelA
  \context Voice = voiceB \trackBchannelB
  \context Voice = voiceC \trackBchannelC
>>


trackCchannelA = {
  
  \set Staff.instrumentName = "bass:three"
  

  \key c \minor
  
}

trackCchannelB = \relative c {
  r8 c'16 b c8 g aes c16 b c8 d 
  | % 2
  <c,, c' >1 
  | % 3
  
}

trackC = <<

  \clef bass
  
  \context Voice = voiceA \trackCchannelA
  \context Voice = voiceB \trackCchannelB
>>


\score {
  <<
    \context Staff=trackB \trackA
    \context Staff=trackB \trackB
    \context Staff=trackC \trackA
    \context Staff=trackC \trackC
  >>
  \layout {}
  \midi {}
}
