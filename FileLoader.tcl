package require blowfish
 


proc load_file { action } {
    set fp [open "hashes.txt" r]
    set file_data [read $fp]
    close $fp
    set lines [split $file_data "\n"]
    puts $lines
    if { action == "del case"} {
        set fp [open "hashes.txt" w]
        set $lines [ del_entry ] 
        puts $fp lines
        
    }
    else {
        parse_entries $line
    }
}

proc parse_entries { line } {
    global passmap
    foreach entry $line {
        set passes [split [ lindex $lines $i] ":"]
        dict set passmap  [lindex $passes 0]  [lindex $passes 0]
    }

}

proc del_entry { lines case } {
    set foundIndex [lsearch $lines $case]
    # replace with nothing
    lreplace $lines foundIndex foundIndex
    return $lines

}

proc Load_keys {} {
    

}

proc encrypt {text} {
    set encryption [::blowfish::Init ecb key]
    set ciphertext [::blowfish::Encrypt key $text]
    set KeyAndText { $ciphertext $key}
    return KeyAndText
     
}

proc dencrypt {key ciphertext} {
    set text [::blowfish::Decrypt key ciphertext]
    return text

}

proc write_file {case pass} {
    set fp [open "hashes.txt" a]
    puts $fp $hashedcase
    puts $fp :
    puts $fp $hashedpass
    close $fp
}

}

load_file