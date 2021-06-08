#set demensions of gui window

set width 300
set height 300

set x [expr { ( [winfo vrootwidth  .] - $width  ) / 2 }]
set y [expr { ( [winfo vrootheight .] - $height ) / 2 }]

#title gui and set geometry
wm title . "PassWordManager" 
wm geometry . ${width}x${height}+${x}+${y}


frame .fr
pack .fr -fill both -expand 1

ttk::label .fr.tltlb -text PassWordManager
pack .fr.tltlb -pady 5 -anchor center -side top

ttk::label .fr.usrlb -text username
pack .fr.usrlb -anchor center -side top

ttk::button .fr.cb -text LOGIN
pack .fr.cb -padx 5 -pady 5 -side bottom -anchor se


ttk::entry .fr.usrnm -textvariable username 
pack .fr.usrnm -anchor center -side top -pady 5


ttk::label .fr.paslb -text password
pack .fr.paslb -anchor center -side top


tk::entry .fr.passwd -textvariable password -show "*"
pack .fr.passwd -anchor center -side top 

ttk::button .fr.rb -text RESET_PASSWORD
pack .fr.rb -anchor center -side bottom -pady 5

