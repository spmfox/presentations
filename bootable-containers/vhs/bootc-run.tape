Output bootc-run.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 120s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f bootc-run.gif"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "sudo podman run --rm -it localhost/bootc-multistage cbonsai -l -p -b 0 -k 1,0,1,0 -L 20 -s 50"
Sleep 500ms
Enter
Wait
Sleep 5s
