OPS_MGR_PASSWD=$1
mkdir -p decrypted 2>/dev/null
cd decrypted
ruby ../eos.rb decrypt $OPS_MGR_PASSWD ../installation.yml decrypted-installation.yml
ruby ../eos.rb decrypt $OPS_MGR_PASSWD ../actual-installation.yml decrypted-actual-installation.yml
cd ..
