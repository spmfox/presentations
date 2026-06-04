Require bootc
Output switching-images.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 300s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f switching-images.gif"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "sudo bootc switch --transport containers-storage localhost/bootc-zfs-tools"
Sleep 500ms
Enter
Wait
Sleep 2s
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 5s
