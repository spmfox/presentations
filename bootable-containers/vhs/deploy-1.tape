Output deploy-1.gif
Set Theme "Builtin Light"
Set Shell bash
Type "sudo podman run --rm --privileged \"
Enter
Type "--pid=host --security-opt label=type:unconfined_t \"
Enter
Type "--volume /dev:/dev \"
Enter
Type "--volume /var/lib/containers:/var/lib/containers \"
Enter
Type "--volume /:/target \"
Enter
Type "--entrypoint bootc \"
Enter
Type "localhost/bootc-test:latest \"
Enter
Type "install to-filesystem --skip-fetch-check --replace=alongside /target \"
Enter
Type "--root-ssh-authorized-keys /target/root/.ssh/authorized_keys \"
Enter
Type "--target-transport=containers-storage --acknowledge-destructive"
Sleep 500ms
Enter
Sleep 5s
Hide
Sleep 110s
Show
Sleep 15s
