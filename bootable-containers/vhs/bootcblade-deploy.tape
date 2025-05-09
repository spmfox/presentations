Output bootcblade-deploy.gif
Set Theme "Builtin Light"
Set Shell bash
Sleep 2s
Type "vim inventory.yml"
Sleep 500ms
Enter
Sleep 2s
Type "i"
Sleep 500ms
Type "all:"
Sleep 500ms
Enter
Type "hosts:"
Sleep 500ms
Enter
Type "10.0.110.178:"
Sleep 500ms
Enter
Type 'create_user_ssh_pub: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMn+GDSvdEP/rYBpeXMdGuVtTFXG1qXRcXNeC4l5GX4"'
Sleep 500ms
Escape
Type ":wq"
Sleep 500ms
Enter
Type "ansible-playbook deploy.yml -i inventory.yml"
Sleep 500ms
Enter
Sleep 10s
Hide
Sleep 104s
Show
Sleep 15s
