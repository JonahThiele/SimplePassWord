package provide FileHandler $FileHandler::version
package require Tcl 8.5
package require sha256

namespace eval ::FileHandler {
 
  
  namespace export check_password_attempt load_file check_null_file check_hash hash write_file parse_entries
  set version 1.0
  set hashedpass ""

 
}
proc check_password_attempt { text } {
    if { check_null_file == "true"} {
        write_file accountpass text
        return 
    }
    else {
        load_file placehodler
        set storedhash [dict get $passmap $accountpass]
        set hashtext [hash $text]
        check_hash hashtext $storedhash $
    }

}

proc FileHandler::load_file { action } {
    set fp [open "hashes.txt" r]
    set file_data [read $fp]
    close $fp
    set lines [split $file_data "\n"]
    puts $lines
    if { action == "del case"} {
        set fp [open "hashes.txt" w]
        set $lines [ del_entry ] 
        puts $fp lines
        close $fp
        
    }
    else {
        parse_entries $line
    }
}


proc FileHandler::check_null_file {} {
    set fp [open "hashes.txt" r]
    set file_data [read $fp]
    close $fp
    if { file_data == " " } {
        return true
    }
    else {
        return false
    }
}

proc FileHandler::parse_entries { line } {
    global passmap
    foreach entry $line {
        set passes [split [ lindex $lines $i] ":"]
        dict set passmap  [lindex $passes 0]  [lindex $passes 0]
    }

}

proc FileHandelr::del_entry { lines case } {
    set foundIndex [lsearch $lines $case]
    # replace with nothing
    lreplace $lines foundIndex foundIndex
    return $lines

}

proc FileHandler::hash {text} {
    set hash [sha2::sha256 $text]
    return hash
     
}

proc FileHandler::check_hash {hash text} {
    if { [string equal $hash $text] == 1} {
        return "false"
    }
    else {
        return "true"
    }

}

proc FileHandler::write_file {case pass} {
    set fp [open "hashes.txt" a]
    set hashedpass [hash pass]
    puts $fp $case
    puts $fp :
    puts $fp $hashedpass
    close $fp
}

package provide FileHandler $FileHandler::version
package require Tcl 8.5
package require sha256