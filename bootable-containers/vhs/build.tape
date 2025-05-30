Output build.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2s
Type "vim bootc-test.containerfile"
Sleep 500ms
Enter
Sleep 2s
Type "i"
Sleep 2s
Type "FROM quay.io/fedora/fedora-bootc:41"
Sleep 500ms
Enter
Type "RUN dnf -y install cowsay lolcat"
Sleep 500ms
Enter
Escape
Sleep 2s
Type ":wq"
Sleep 500ms
Enter
Sleep 2
Type "sudo podman build -t localhost/bootc-test -f bootc-test.containerfile"
Sleep 500ms
Enter
Sleep 43s
