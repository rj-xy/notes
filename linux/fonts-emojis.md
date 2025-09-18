Reload font cache:
`sudo fc-cache -f -v`

```bash
# Each of these lists the font used
fc-match emoji
fc-match monospace
fc-match sans-serif
```

NOTE: After install playwright dependencies, the emojis stopped working in Kate and Konsole

Creating this fixed this: `~/.config/fontconfig/fonts.conf`

```bash
mkdir ~/.config/fontconfig
touch ~/.config/fontconfig/fonts.conf
nano ~/.config/fontconfig/fonts.conf
```

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Sans</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
   </prefer> 
 </alias>

 <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Serif</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
   </prefer>
 </alias>

 <alias>
  <family>monospace</family>
  <prefer>
    <family>Noto Mono</family>
    <family>Noto Color Emoji</family>
    <family>Noto Emoji</family>
   </prefer>
 </alias>
</fontconfig>
```
