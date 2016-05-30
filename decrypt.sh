OPS_MGR_PASSWD=$1
sudo -u tempest-web mkdir -p decrypted 2>/dev/null
chown tempest-web -R decrypted
cd decrypted
if [ -f /home/tempest-web/tempest/web/scripts/decrypt ];
then
  sudo -u tempest-web RAILS_ENV=production /home/tempest-web/tempest/web/scripts/decrypt $OPS_MGR_PASSWD ../installation.yml decrypted-installation.yml
  sudo -u tempest-web RAILS_ENV=production /home/tempest-web/tempest/web/scripts/decrypt $OPS_MGR_PASSWD ../actual-installation.yml decrypted-actual-installation.yml
else 
  ruby ../eos.rb decrypt $OPS_MGR_PASSWD ../installation.yml decrypted-installation.yml
  ruby ../eos.rb decrypt $OPS_MGR_PASSWD ../actual-installation.yml decrypted-actual-installation.yml
fi
cd ..
