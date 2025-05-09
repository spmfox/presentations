Output update.gif
Set Theme "Builtin Light"
Set Shell bash
Type "cat /etc/fedora-release"
Sleep 500ms
Enter
Sleep 2
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 2
Type "vi bootc-test.containerfile"
Sleep 500ms
Enter
Type "i"
Sleep 500ms
Type "FROM quay.io/fedora/fedora-bootc:42"
Enter 2
Type "RUN dnf -y install cowsay"
Sleep 500ms
Escape
Type ":wq"
Sleep 500ms
Enter
Sleep 500ms
Type "time ( sudo podman build -t localhost/bootc-test -f bootc-test.containerfile && sudo bootc update )"
Sleep 500ms
Enter
Sleep 5s
Hide
Sleep 125s
Show
Sleep 20s
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 5s
