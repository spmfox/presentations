Output run.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2s
Type "cowsay"
Sleep 500ms
Enter
Sleep 2s
Type "sudo podman image list --all"
Sleep 500ms
Enter
Sleep 2s
Type "sudo podman run --rm -it localhost/bootc-test sh -c 'cowsay -f tux bootc-test |lolcat'
Sleep 500ms
Enter
Sleep 7s
