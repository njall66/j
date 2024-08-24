
coclass 'NOTEFORM'

NOTE =: ''

create =: {{)v

''
}}

NOTENTRY =: {{)n
pc noteentry closeok closebutton  minbutton maxbutton ;
minwh 1000 400; cc edittext editm;
cc OK button;
cc Cancel button;
pas 6 6; pcenter; pshow; ptop;
}}

noteentry =: {{)v

wd NOTENTRY
wd 'set edittext text *',NOTE
wd 'pshow'
   
}}

noteentry_Cancel_button =: wd bind 'pclose'

noteentry_OK_button =: {{)v

NOTE =: edittext 
wd 'pclose'

NOTE
}}

noteentry_sctrl_fkey =: {{)v

NOTE =: edittext
wd 'pclose' 

}}



coclass 'base' 