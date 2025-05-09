Output run.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 5s
Type "fastfetch"
Sleep 1s
Enter
Sleep 2s
Type "podman image list --all"
Sleep 500ms
Enter
Sleep 2s
Type "podman run --rm -it localhost/bootc-test:latest /bin/bash"
Sleep 1.5s
Enter
Sleep 2s
Type "fastfetch"
Sleep 500ms
Enter
Sleep 5s
