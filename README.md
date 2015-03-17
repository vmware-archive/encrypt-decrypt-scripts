# encrypt-decrypt-scripts

1. Login to the Ops Manager VM
2. Change directories to `/var/tempest/workspaces/default`
3. Run `sudo su`
4. Clone the repo `git clone https://github.com/mreider/encrypt-decrypt-scripts.git`
5. Run `mv encrypt-decrypt-scripts/* .` to put the scripts in the same directory
6. Run `sh decrypt.sh {ops manager password}`
7. Back up the files `actual-installation.yml` and `installation.yml` to a different directory (Ops Manager will attempt to read them if they are in this directory - resulting in an exception error).
8. Change directories to `/var/tempest/workspaces/default/t1`
9. Modify the files as instructed by support
Run `sh encrypt.sh {ops manager password}` - this replaces the existing files with your edited ones.
10. Make sure Ops Manager loads in a browser. If it doesn't you should revert to your backups and try again.
