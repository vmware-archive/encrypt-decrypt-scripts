OPS_MGR_PASSWD=$1
sudo -u tempest-web mkdir -p decrypted 2>/dev/null
chown tempest-web -R decrypted
cd decrypted
if [ -f /home/tempest-web/tempest/web/scripts/encrypt ];
then
  sudo -u tempest-web RAILS_ENV=production /home/tempest-web/tempest/web/scripts/encrypt $OPS_MGR_PASSWD decrypted-installation.yml ../installation.yml
  sudo -u tempest-web RAILS_ENV=production /home/tempest-web/tempest/web/scripts/encrypt $OPS_MGR_PASSWD decrypted-actual-installation.yml ../actual-installation.yml
else
  ruby ../eos.rb encrypt $OPS_MGR_PASSWD decrypted-installation.yml ../installation.yml
  ruby ../eos.rb encrypt $OPS_MGR_PASSWD decrypted-actual-installation.yml ../actual-installation.yml
fi
cd ..
