Require bootc
Require zfs
Output first-boot.gif
Set Theme "Builtin Light"
Set Shell bash
Set WaitTimeout 300s
Set TypingSpeed 75ms
Hide
Type@1ms "rm -f first-boot.gif"
Enter
Wait
Type@1ms "clear"
Enter
Show
Sleep 2s
Type "sudo bootc status"
Sleep 500ms
Enter
Sleep 5s
Type "sudo modprobe zfs; sudo zfs --version"
Sleep 500ms
Enter
Sleep 5s
Type "cat /etc/fedora-release"
Sleep 500ms
Enter
Sleep 5s
