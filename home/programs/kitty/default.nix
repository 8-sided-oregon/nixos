{
  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_size = 11;
    font_family = "AnonymicePro Nerd Font Mono";
    scrollback_pager_history_size = 20; # 20 MB
    enable_audio_bell = false;
    window_padding_width = 2;
    background_opacity = "0.9";
  };
  programs.kitty.extraConfig = ''
    #special
    foreground    #7ea2b4
    background    #161b1d
    cursorColor   #7ea2b4
    
    #black
    color0        #161b1d
    color8        #5a7b8c
    
    #red
    color1        #d22d72
    color9        #d22d72
    
    #green
    color2        #568c3b
    color10       #568c3b
    
    #yellow
    color3        #8a8a0f
    color11       #8a8a0f
    
    #blue
    color4        #257fad
    color12       #257fad
    
    #magenta
    color5        #5d5db1
    color13       #5d5db1
    
    #cyan
    color6        #2d8f6f
    color14       #2d8f6f
    
    #white
    color7        #7ea2b4
    color15       #ebf8ff
  '';
}
