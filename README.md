TwoCentsCryptoFrontend
======================

GNU/Linux cryptography frontend
Developed by Giovanni Santostefano <giovannisantostefano@email.it>
http://twocentssecurity.wordpress.com/

Two Cents Crypto Frontend provides easy to use guided wizards to many of GNU/Linux Cryptography resources like Cryptsetup, GnuPG and so on.

Actually implemented
* cryptsetup suite to create and manage devices and file storages protected by encryption
* gpg suite for symmetric encryption of files and directory trees
* gpg asymmetric encryption tools/key management/digital signing
* Device and file secure deletion (wiping)


WARNING

This suite is highly sperimental. Use it at your own risk!
Many of the programs requires root privileges.



Directory Tree Encryption Warning

With this new feature you can encrypt (and soon decrypt) each file, starting
from a directory through all the subdirectories. It's usable to make an encrypted
mirror to store on a DVD or other media that have to be read from systems that
does not support encrypted storages but runs an istance of gpg. WARNING: do not
use this feature on multiuser systems but only on your personal computer because
the passphrase must be passed as argument in clear form, so it's visible via top
or ps commands. Also, the clear form of files will be securely deleted, so prevent
data loss operating only on backup copies of files. IT'S IMPORTANT. Defintely, I'm 
not responsible for any data loss due to uncorrect usage or bugs of this function.


========================

USAGE
launch

$ bash tccf

CONTRIBUTORS: 
Lorenzo "EclipseSpark" Faletra <eclipse@frozenbox.org>
