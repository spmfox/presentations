Output update.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 2
Type "vim bootc-test.containerfile"
Sleep 500ms
Enter
Type "i"
Sleep 500ms
Type "FROM quay.io/fedora/fedora-bootc:42"
Sleep 500ms
Enter
Type "RUN dnf -y install cowsay lolcat"
Sleep 500ms
Enter
Escape
Type ":wq"
Sleep 500ms
Enter
Sleep 2s
Type "time ( sudo podman build -t localhost/bootc-test -f bootc-test.containerfile && sudo bootc update )"
Sleep 500ms
Enter
Sleep 5s
Hide
Sleep 115s
Show
Sleep 20s
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 7s
