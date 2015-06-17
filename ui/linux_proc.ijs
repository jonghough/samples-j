
NB. edith demo

coclass 'procui'



Text =: spawn_jtask_ 'cat /proc/net/sockstat'


PROCUI=: 0 : 0
pc procui closeok escclose;pn "Edith Demo";
menupop "&File";
menu open "&Open" "Ctrl+O" "" "";
menu edit "&Edit" "Ctrl+E" "" "";
menu print "&Print" "Ctrl+P" "" "";
menusep;
menu quit "&Quit" "Ctrl+Q" "" "";
menupopz;
cc ted edith flush;
)

NB. =========================================================
procui_run=: 3 : 0
wd PROCUI
if. UNAME -: 'Linux' do. fnt=: 'font: 12pt "DejaVu Serif"' else. fnt=: 'font: 12pt "Georgia";' end.
if. UNAME -: 'Linux' do. fnte=: 'font: 12pt "DejaVu Mono"' else. fnte=: 'font: 12pt "Courier New";' end.
wd 'set ted stylesheet *QTextEdit {color:#00007f;background-color:#ffffee;',fnt,'}'
wd 'set ted text *',Text
wd 'pmove 100 10 700 500'
wd 'pshow'
NB. call these after the pshow:
wd 'set ted select 1580 1763'
wd 'set ted scroll 15'
)

NB. =========================================================
procui_close=: 3 : 0
wd 'pclose'
)

procui_close_button=: procui_quit_button=: procui_close




procui_print_button=: 3 : 0
wd'cmd ted print'
)

NB. =========================================================
procui_run''
