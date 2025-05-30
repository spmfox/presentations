Output quadlet-run.gif
Set Theme "Builtin Light"
Set Shell bash
Hide
Type "export XDG_RUNTIME_DIR=/run/user/1000"
Sleep 500ms
Enter
Type "export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
Sleep 500ms
Enter
Type "sudo machinectl shell containers@"
Sleep 500ms
Enter
Sleep 500ms
Type "clear"
Sleep 500ms
Enter
Show
Sleep 2s
Type "podman container list --all"
Sleep 500ms
Enter
Sleep 2s
Type "tree"
Sleep 500ms
Enter
Sleep 2s 
Type "mkdir -p ~/.config/containers/systemd"
Sleep 500ms
Enter
Sleep 2s
Type "cp quadlet/wordpress* ~/.config/containers/systemd/"
Sleep 500ms
Enter
Sleep 2s
Type "/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun"
Sleep 500ms
Enter
Sleep 4s
Type "systemctl --user daemon-reload"
Sleep 500ms
Enter
Sleep 2s
Type "systemctl --user status wordpress-pod.service"
Sleep 500ms
Enter
Type "q"
Enter
Sleep 4s
Type "systemctl --user start wordpress-pod.service"
Sleep 500ms
Enter
Sleep 2s
Type "systemctl --user status wordpress-pod.service"
Sleep 500ms
Enter
Type "q"
Enter
Sleep 4s
Type "podman container list --all"
Enter
Sleep 7s
