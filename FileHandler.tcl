namespace eval ::FileHandler {
  
  namespace export check_password_attempt load_file check_null_file check_hash hash write_file parse_entries fill_dic_list parse_cipher encrypt decrypt add_passwords
  variable Key ""
  variable passmap [dict create null "create_null"]
  variable accountmap [dict create null "create_null"]
  variable dic_list {}

 
}
proc FileHandler::check_password_attempt { text } {
    variable Key
    set filetruth [check_null_file]
    if { $filetruth == "true"} {
        set hashtext [hash $text]
        puts $hashtext
        write_file accountpass $hashtext
        return true
    } 
    if { $filetruth == "false"} {
        load_file hashLoad
        FileHandler::fill_dic_list
        set storedhash [dict get $FileHandler::accountmap accountpass]
        set hashtext [hash $text]
        puts "$storedhash\n$hashtext"
        set hashtruth [check_hash $hashtext $storedhash]
        if { $hashtruth == "true"} {
            set Key [blowfish::Init ecb $text 00000000]
            return true 
        } else {
            return false
        }
    }

}

proc FileHandler::load_file { action } {
    if {$action == "hashLoad"} {
        set fp [open "hashes.txt" r]
        set file_data [read $fp]
        close $fp
        set lines [split $file_data "\n"]
        parse_entries $lines accountmap
    }
    if { $action == "del case"} {
        set fp [open "encryption.txt" w]
        set $lines [ del_entry ] 
        puts $fp lines
        close $fp
        
    } 
    if { $action == "encryptionLoad"} { 
        set fp [open "encryption.txt" r]
        set file_data [read $fp]
        close $fp
        set lines [split $file_data "\n"]
        parse_entries $lines passmap
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

proc FileHandler::parse_entries { lines dict} {
    variable $dict
    for { set a 0}  {$a < [llength $lines]} {incr a} {
        set currentline [lindex $lines $a]
        set passes [split $currentline ":"]
        set case [lindex $passes 0]
        set pass [string trimright [lindex $passes 1]]
        dict set $dict $case $pass
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

proc FileHandler::write_file {case pass file} {
    set fp [open $file a]
    puts $fp "$case:$pass"
    close $fp
}

proc FileHandler::fill_dic_list { } {
    load_file encryptionLoad
    variable dic_list
    set dic_list {}
    foreach theKey [dict keys $FileHandler::passmap] {
        if {$theKey == "null"} {

        } else {
            set decryptedtext [FileHandler::decrypt $theKey]
            lappend dic_list $decryptedtext
        }
    }
    puts $FileHandler::dic_list

}

proc FileHandler::add_passwords {case text} {
    variable passmap
    set pass [FileHandler::encrypt text]
    puts $pass
    dict set passmap $case $pass
    FileHandler::write_file $case $pass "encryption.txt"
}

proc FileHandler::encrypt { text } {
    set listext [split $text]
    return blowfish::Encrypt $FileHandler::Key $listtext
}

proc FileHandler::decrypt { listtext } {
    variable text
    set plainlisttext [blowfish::Decrypt $FileHandler::Key $listtext]
    foreach char $plainlisttext {
        lappend $text $char
    }
    return text

}
namespace eval ::FileHandler { variable version 1.0 }

package provide FileHandler $FileHandler::version
package require Tcl 8.5-
package require sha256
package require blowfish