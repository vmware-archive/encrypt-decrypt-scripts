OPS_MGR_PASSWD=$1
mkdir -p decrypted 2>/dev/null
cd t1
ruby ../eos.rb encrypt $OPS_MGR_PASSWD decrypted-installation.yml ../installation.yml
ruby ../eos.rb encrypt $OPS_MGR_PASSWD decrypted-actual-installation.yml ../actual-installation.yml
cd ..
