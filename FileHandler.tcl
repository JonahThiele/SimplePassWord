namespace eval ::FileHandler {
  
  namespace export check_password_attempt load_file check_null_file check_hash hash write_file parse_entries
  variable hashedpass ""
  variable passmap 

 
}
proc FileHandler::check_password_attempt { text } {
    set filetruth [check_null_file]
    if { $filetruth == "true"} {
        set hashtext [hash $text]
        write_file accountpass $hashtext
    } else {
        load_file placehodler
        set storedhash [dict get $FileHandler::passmap accountpass]
        set hashtext [hash $text]
        set hashtruth [check_hash $hashtext $storedhash]
        if { $filetruth == "true"} {
            
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
    global passmap
    for { set a 0}  {$a < [llength $lines]} {incr a} {
        set passes [split [ lindex $lines $a] ":"]
        dict set FileHandler::passmap  [lindex $passes 0]  [lindex $passes 0]
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
    return hash
     
}

proc FileHandler::check_hash {hash text} {
    if { [string equal $hash $text] == 1} {
        return "false"
    } else {
        return "true"
    }

}

proc FileHandler::write_file {case pass} {
    set fp [open "hashes.txt" a]
    puts $fp "$case:$pass"
    close $fp
}

# proc FileHandler::check_login {text} {
#     set fileValue [ check_null_file ]
#     if {$fileValue == "true"} {
#         set hashedtext [FileHandler::hash text]
#         FileHandler::write_file passlogin $hashedtext
#     }  
#     if {$fileValue == "false"} {
#         load_file null 
#         if { [dict exists $FileHandler::passmap passlogin] == 0} {
#             puts killyourself
#         } else {
#             puts nibber
#             set storedhash [dict get $FileHandler::passmap passlogin]
#             set $FileHandler::hashedpass [hash $text]
#             set checkPassVal [FileHandler::check_hash $storedhash $FileHandler::passmap]
#             if {checkPassVal == "true"} {
#                 puts "hi"
#         }
#         }
#     }

# }

namespace eval ::FileHandler { variable version 1.0 }

package provide FileHandler $FileHandler::version
package require Tcl 8.5-
package require sha256
