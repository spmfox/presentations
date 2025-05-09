Output build.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 5s
Type "vim bootc-test.containerfile"
Sleep 500ms
Enter
Sleep 5s
Type "i"
Sleep 2s
Type "FROM quay.io/fedora/fedora-bootc:41"
Enter 2
Type "RUN dnf -y install fish fastfetch"
Sleep 1.5s
Escape
Sleep 500ms
Type ":wq"
Enter
Sleep 2.5s
Type "podman build -t localhost/bootc-test -f bootc-test.containerfile"
Sleep 500ms
Enter
Sleep 55s
