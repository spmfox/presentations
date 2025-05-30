Output ansible-containers.gif
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
Type "pwd"
Sleep 500ms
Enter
Sleep 2s
Type "tree"
Sleep 500ms
Enter
Sleep 2s
Enter
Type "cat wordpress.yml"
Sleep 500ms
Enter
Sleep 4s
Type "git clone -b dev https://github.com/spmfox/PodPlaybook.git"
Sleep 500ms
Enter
Sleep 5s
Type "ansible-playbook -i wordpress.yml PodPlaybook/containers-local.yml"
Sleep 500ms
Enter
Sleep 12s
Type "podman container list --all"
Sleep 500ms
Enter
Sleep 2s
Type "ls ~/.config/containers/systemd"
Sleep 500ms
Enter
Sleep 2s
Type "ansible-playbook -i wordpress.yml PodPlaybook/containers-local.yml --tags stop,remove"
Sleep 500ms
Enter
Sleep 12s
Type "podman container list --all"
Sleep 500ms
Enter
Type "ls ~/.config/containers/systemd"
Sleep 500ms
Enter
Sleep 7s
