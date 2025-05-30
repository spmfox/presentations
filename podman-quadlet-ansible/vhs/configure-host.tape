Output configure-host.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2s
Type "sudo loginctl enable-linger containers"
Sleep 500ms
Enter
Sleep 2s
Type "echo 'net.ipv4.ip_unprivileged_port_start=80' | sudo tee -a /etc/sysctl.d/50-UnprivilegedPort.conf > /dev/null"
Sleep 500ms
Enter
Sleep 2s
Type "sudo sysctl -p /etc/sysctl.d/50-UnprivilegedPort.conf"
Sleep 500ms
Enter
Sleep 7s
