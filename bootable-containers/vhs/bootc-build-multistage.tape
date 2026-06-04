Require podman
Output bootc-build-multistage.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 120s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f bootc-build-multistage.gif bootc-multistage.containerfile && sudo podman image prune -f && sudo podman pull docker.io/library/ubuntu && sudo podman pull quay.io/fedora/fedora-bootc:43"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "vim bootc-multistage.containerfile"
Sleep 500ms
Enter
Sleep 2s
Type "i"
Sleep 2s
Type "FROM docker.io/library/ubuntu AS build"
Sleep 500ms
Enter
Type "RUN apt-get update && apt-get install cbonsai"
Sleep 500ms
Enter
Sleep 500ms
Enter
Type "FROM quay.io/fedora/fedora-bootc:43"
Sleep 500ms
Enter
Type "COPY --from=build /usr/games/cbonsai /usr/local/bin/cbonsai"
Sleep 500ms
Enter
Escape
Sleep 2s
Type ":wq"
Sleep 500ms
Enter
Sleep 2s
Type "sudo podman build -t localhost/bootc-multistage -f bootc-multistage.containerfile"
Sleep 500ms
Sleep 2s
Enter
Wait
Sleep 5s
