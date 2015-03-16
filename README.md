# encrypt-decrypt-scripts

1. Login to the Ops Manager VM
2. Change directories to `/var/tempest/workspaces/default`
3. Run `sudo su`
4. Clone the repo `git clone https://github.com/mreider/encrypt-decrypt-scripts.git` .
5. Run `sh decrypt.sh {ops manager password}`
6. Back up the files `actual-installation.yml` and `installation.yml` to a different directory (Ops Manager will attempt to read them if they are in this directory - resulting in an exception error).
7. Change directories to `/var/tempest/workspaces/default/t1`
8. Modify the files as instructed by support
Run `sh encrypt.sh {ops manager password}` - this replaces the existing files with your edited ones.
9. Make sure Ops Manager loads in a browser. If it doesn't you should revert to your backups and try again.
