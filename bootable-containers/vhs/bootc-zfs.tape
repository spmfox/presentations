Require system-reinstall-bootc
Output bootc-zfs.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 300s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f bootc-zfs.gif"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "sudo system-reinstall-bootc localhost/bootc-zfs"
Sleep 500ms
Enter
Wait+Screen /root/
Sleep 2s
Space 1
Sleep 500ms
Enter
Wait /continue?/
Sleep 2s
Type y
Sleep 500ms
Enter
Sleep 4
Hide
Sleep 75
Show
Wait
