Output rootless-container-run.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2s
Type "sudo machinectl shell containers@"
Sleep 500ms
Enter
Sleep 2s
Type "podman run --rm -d --name wordpress-app docker.io/library/wordpress"
Sleep 500ms
Enter
Sleep 2s
Type "podman container list --all"
Sleep 500ms
Enter
Sleep 2
Type "podman container stop wordpress-app"
Sleep 500ms
Enter
Sleep 2s
Type "podman container list --all"
Sleep 500ms
Enter
Sleep 7s
