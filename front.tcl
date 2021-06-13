lappend auto_path .
package require  FileHandler 
package require Tk

#set demensions of gui window

set width 300
set height 300

set x [expr { ( [winfo vrootwidth  .] - $width  ) / 2 }]
set y [expr { ( [winfo vrootheight .] - $height ) / 2 }]

set password ""

tk::toplevel .front
#title gui and set geometry
wm title .front "PassWordManager" 
wm geometry .front  ${width}x${height}+${x}+${y}

frame .front.
pack .front. -fill both -expand 1

ttk::label .front..tltlb -text PassWordManager
pack .front..tltlb -pady 5 -anchor center -side top

ttk::label .front..usrlb -text username
pack .front..usrlb -anchor center -side top

ttk::button .front..cb -text LOGIN -default active -command { [FileHandler::check_password_attempt $password ] }
pack .front..cb -padx 5 -pady 5 -side bottom -anchor se
bind .front. <Return> ".action invoke"


ttk::entry .front..usrnm -textvariable username 
pack .front..usrnm -anchor center -side top -pady 5


ttk::label .front..paslb -text password
pack .front..paslb -anchor center -side top


tk::entry .front..passwd -textvariable password -show "*"
pack .front..passwd -anchor center -side top 

ttk::button .front..rb -text RESET_PASSWORD
pack .front..rb -anchor center -side bottom -pady 5

###set up main manager window

wm title . "PassWordManager" 
wm geometry . ${width}x${height}+${x}+${y}

ttk::frame .fr -width $width -height $height

ttk::combobox .fr.kcase -textvariable kcase
.fr.kcase configure -values [list ]
bind .fr.kcase <<ComboboxSelected>> { script }
.fr.kcase state readonly

ttk::entry .fr.newcase -textvariable newcase

ttk::entry .fr.newpass -textvariable newpass -show "*"
ttk::entry .fr.kpass -textvariable knownpass -show "*"

ttk::button .fr.cb -text RAND_PASS
ttk::button .fr.del -text Delete

ttk::label .fr.kcaselb -text Website/Use
ttk::label .fr.passlb -text "Known PassWord"
ttk::label .fr.ncaselb -text "New PassWord Website/Use"
ttk::label .fr.npasslb -text "New PassWord"

ttk::label .fr.empty1 -text " " 
ttk::label .fr.empty2 -text  " " 
ttk::label .fr.empty3 -text " "


# binded functions

grid .fr -column 0 -row 0
grid .fr.cb -column 1 -row 6
grid .fr.newcase -column 0 -row 5 -pady 10 -padx 10
grid .fr.newpass -column 1 -row 5 -pady 10 -padx 10
grid .fr.ncaselb -column 0 -row 4
grid .fr.npasslb -column 1 -row 4
grid .fr.empty1 -column 0 -row 3 -pady 50
grid .fr.empty2 -column 1 -row 3 -pady 50
grid .fr.empty3 -column 0 -row 2
grid .fr.del -column 1 -row 2
grid .fr.kcase -column 0 -row 1
grid .fr.kpass -column 1 -row 1
grid .fr.kcaselb -column 0 -row 0 -pady 10 -padx 10
grid .fr.passlb -column 1 -row 0 -pady 10 -padx 10

grid columnconfigure .fr 0 -weight 1
grid columnconfigure .fr 0 -weight 1
grid columnconfigure .fr 1 -weight 1
grid rowconfigure .fr 0 -weight 10
grid rowconfigure .fr 1 -weight 1
grid rowconfigure .fr 2 -weight 10
grid rowconfigure .fr 3 -weight 1
grid rowconfigure .fr 4 -weight 10

wm geometry . 1x1+0+0
wm overrideredirect . 1
wm transient .