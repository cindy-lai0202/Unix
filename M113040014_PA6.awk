BEGIN {DE = "Database Entry: "}
/^End of/ {next}
/^Ship's Database - / {sub(/^Ship's Database - /, DE)}

/^Deep Space Hibernation:/ || /^Weapons System:/ {
    split($0, A, ": ")
    A[1] = DE A[1]
    DB[A[1]] = A[2]"\n"
}

/Log, Day/ {sub(/Log, Day/, "Log - Mission Day")}
/, Supplemental/ {sub(/, Supplemental/, " - Mission Day 113, Supplemental")}

/^Database/ || /^Captain's Log/ {
    K = $0
    DB[K] = ""
    getline
}

/^User/ { K ="" }

K !="" { DB[K] = DB[K] "\n" $0 }

END {
    for (entry in DB) {
        print entry ":"
        print DB[entry]
        print "------------------------"
    }
}
