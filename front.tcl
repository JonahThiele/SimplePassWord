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

ttk::button .front..cb -text LOGIN -default active -command { check_login $password }
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
tk::toplevel .manager

wm title .manager "PassWordManager" 
wm geometry .manager ${width}x${height}+${x}+${y}

ttk::frame .manager.fr -width $width -height $height

ttk::combobox .manager.fr.kcase -textvariable kcase
bind .manager.fr.kcase <<ComboboxSelected>> { set knownpass [dict get $FileHandler::passmap $kcase] }
.manager.fr.kcase state readonly

ttk::entry .manager.fr.newcase -textvariable newcase

ttk::entry .manager.fr.newpass -textvariable newpass -show "*"
ttk::entry .manager.fr.kpass -textvariable knownpass -show "*"

ttk::button .manager.fr.cb -text RAND_PASS
ttk::button .manager.fr.del -text Delete

ttk::label .manager.fr.kcaselb -text Website/Use
ttk::label .manager.fr.passlb -text "Known PassWord"
ttk::label .manager.fr.ncaselb -text "New PassWord Website/Use"
ttk::label .manager.fr.npasslb -text "New PassWord"

ttk::label .manager.fr.empty1 -text " " 
ttk::label .manager.fr.empty2 -text  " " 
ttk::label .manager.fr.empty3 -text " "


# binded functions

grid .manager.fr -column 0 -row 0
grid .manager.fr.cb -column 1 -row 6
grid .manager.fr.newcase -column 0 -row 5 -pady 10 -padx 10
grid .manager.fr.newpass -column 1 -row 5 -pady 10 -padx 10
grid .manager.fr.ncaselb -column 0 -row 4
grid .manager.fr.npasslb -column 1 -row 4
grid .manager.fr.empty1 -column 0 -row 3 -pady 50
grid .manager.fr.empty2 -column 1 -row 3 -pady 50
grid .manager.fr.empty3 -column 0 -row 2
grid .manager.fr.del -column 1 -row 2
grid .manager.fr.kcase -column 0 -row 1
grid .manager.fr.kpass -column 1 -row 1
grid .manager.fr.kcaselb -column 0 -row 0 -pady 10 -padx 10
grid .manager.fr.passlb -column 1 -row 0 -pady 10 -padx 10

grid columnconfigure .manager.fr 0 -weight 1
grid columnconfigure .manager.fr 0 -weight 1
grid columnconfigure .manager.fr 1 -weight 1
grid rowconfigure .manager.fr 0 -weight 10
grid rowconfigure .manager.fr 1 -weight 1
grid rowconfigure .manager.fr 2 -weight 10
grid rowconfigure .manager.fr 3 -weight 1
grid rowconfigure .manager.fr 4 -weight 10

wm withdraw .manager
wm geometry . 1x1+0+0
wm overrideredirect . 1
wm transient .


##function wrappers for file handling bindings
proc show_pass {} {
    
}
proc check_login { password} {
    set logintruth [FileHandler::check_password_attempt $password ]
    if { $logintruth == "true"} {
        wm deiconify .manager
        wm withdraw .front
        .manager.fr.kcase configure -values $FileHandler::dic_list
    } 
    if { $logintruth == "false"} {
        tk_messageBox -message "incorrect login" -type ok -icon error
        
    }
}