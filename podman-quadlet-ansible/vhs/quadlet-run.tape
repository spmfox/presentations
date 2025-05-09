Output quadlet-run.gif
Set Theme "Builtin Light"
Set Shell bash
Hide
Type "export XDG_RUNTIME_DIR=/run/user/1000"
Enter
Sleep 500ms
Type "export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
Enter
Sleep 500ms
Type "clear"
Enter
Sleep 500ms
Show
Sleep 2s
Type "podman stats --format 'table {{.ID}} {{.Name}} {{.UpTime}}' --no-stream"
Sleep 500ms
Enter 2
Sleep 4s
Type "ls"
Sleep 500ms
Enter 2
Sleep 4s
Type "mv wordpress* ~/.config/containers/systemd/"
Sleep 500ms
Enter
Sleep 2s
Type "/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun"
Sleep 500ms
Enter 2
Sleep 4s
Type "systemctl --user daemon-reload"
Sleep 500ms
Enter
Sleep 2s
Type "systemctl --user status wordpress-pod.service"
Sleep 500ms
Enter
Type "q"
Enter 2
Sleep 4s
Type "systemctl --user start wordpress-pod.service"
Sleep 500ms
Enter
Sleep 2s
Type "systemctl --user status wordpress-pod.service"
Sleep 500ms
Enter
Type "q"
Enter 2
Sleep 4s
Type "podman stats --format 'table {{.ID}} {{.Name}} {{.UpTime}}'"
Enter
Sleep 15s
