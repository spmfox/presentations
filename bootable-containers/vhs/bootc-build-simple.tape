Require podman
Output bootc-build-simple.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 120s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f bootc-build-simple.gif bootc-simple.containerfile && sudo podman image prune -f && sudo podman pull quay.io/fedora/fedora-bootc:43"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "vim bootc-simple.containerfile"
Sleep 500ms
Enter
Sleep 2s
Type "i"
Sleep 2s
Type "FROM quay.io/fedora/fedora-bootc:43"
Sleep 500ms
Enter
Type "RUN dnf -y install cbonsai"
Sleep 500ms
Enter
Escape
Sleep 2s
Type ":wq"
Sleep 500ms
Enter
Sleep 2s
Type "sudo podman build -t localhost/bootc-simple -f bootc-simple.containerfile"
Sleep 500ms
Sleep 2s
Enter
Wait
Sleep 5s
