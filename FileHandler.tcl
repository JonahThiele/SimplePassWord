namespace eval ::FileHandler {
  
  namespace export check_password_attempt load_file check_null_file check_hash hash write_file parse_entries fill_dic_list parse_cipher encrypt decrypt
  variable hashedpass ""
  variable passmap [dic create null "create_null"]
  variable accountmap [dict create null "create_null"]
  variable dic_list {}

 
}
proc FileHandler::check_password_attempt { text } {
    set filetruth [check_null_file]
    if { $filetruth == "true"} {
        set hashtext [hash $text]
        puts $hashtext
        write_file accountpass $hashtext
        return true
    } 
    if { $filetruth == "false"} {
        load_file placeholder
        FileHandler::fill_dic_list
        set storedhash [dict get $FileHandler::accountmap accountpass]
        set hashtext [hash $text]
        puts "$storedhash\n$hashtext"
        set hashtruth [check_hash $hashtext $storedhash]
        if { $hashtruth == "true"} {
            return true 
        } else {
            return false
        }
    }

}

proc FileHandler::load_file { action } {
    set fp [open "hashes.txt" r]
    set file_data [read $fp]
    close $fp
    set lines [split $file_data "\n"]
    if { $action == "del case"} {
        set fp [open "hashes.txt" w]
        set $lines [ del_entry ] 
        puts $fp lines
        close $fp
        
    } else {
        parse_entries $lines
    }
}


proc FileHandler::check_null_file {} {
    set fp [open "hashes.txt" r]
    set file_data [read $fp]
    close $fp
    if { $file_data == "" } {
        return true
    } else {
        return false
    }
}

proc FileHandler::parse_entries { lines } {
    variable accountmap
    for { set a 0}  {$a < [llength $lines]} {incr a} {
        set currentline [lindex $lines $a]
        set passes [split $currentline ":"]
        set case [lindex $passes 0]
        set pass [string trimright [lindex $passes 1]]
        dict set accountmap $case $pass
    }

}

proc FileHandler::dict_append { dict newkey newval } {

    foreach key dict {
        
    }
}

proc FileHandler::del_entry { lines case } {
    set foundIndex [lsearch $lines $case]
    # replace with nothing
    lreplace $lines foundIndex foundIndex
    return $lines

}

proc FileHandler::hash {text} {
    set hash [sha2::sha256 $text]
    return $hash
     
}

proc FileHandler::check_hash {hash text} {
    if { $hash == $text} {
        return "true"
    } else {
        return "false"
    }

}

proc FileHandler::write_file {case pass} {
    set fp [open "hashes.txt" a]
    puts $fp "$case:$pass"
    close $fp
}

proc FileHandler::fill_dic_list { } {
    variable dic_list
    load_file placeholder
    set dic_list {}
    foreach theKey [dict keys $FileHandler::passmap] {
        if {$theKey == "null"} {

        } else {
            lappend dic_list $theKey
        }
    }
    puts $FileHandler::dic_list

}

proc FileHandler::parse_cipher {} {

}

proc FileHandler::encrypt {} {

}

proc FileHandler::decrypt {} {

}
namespace eval ::FileHandler { variable version 1.0 }

package provide FileHandler $FileHandler::version
package require Tcl 8.5-
package require sha256
