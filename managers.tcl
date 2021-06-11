lappend auto_path "C:\\Users\\j715c\\coding_projects\\tcl\\tcl_proj\\password_manager\\"
package require  FileHandler 


set width 300
set height 300

set x [expr { ( [winfo vrootwidth  .] - $width  ) / 2 }]
set y [expr { ( [winfo vrootheight .] - $height ) / 2 }]


#title gui and set geometry
wm title . "PassWordManager" 
wm geometry . ${width}x${height}+${x}+${y}

ttk::frame .fr -width $width -height $height

ttk::combobox .fr.kcase -textvariable kcase
.fr.kcase configure -values [list ]
bind .country <<ComboboxSelected>> { script }
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

wm resizable . 0 0



