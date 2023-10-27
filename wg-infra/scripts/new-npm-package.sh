#!/usr/bin/env bash

set -e

# Colors
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables
PACKAGE_NAME=@electron/$1
PRETTY_PACKAGE=$CYAN\"$PACKAGE_NAME\"$NC

echo -e Creating or claiming the npm package $PRETTY_PACKAGE
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo OK, claiming now;;
	no ) echo Exiting...;
		exit;;
	* ) echo Invalid response;
		exit 1;;
esac

temp_dir=$(mktemp -d "$TMPDIR/claim.XXXXXX")
touch "$temp_dir/.npmrc"
touch "$temp_dir/package.json"

tee -a "$temp_dir/.npmrc" 1>/dev/null <<EOF
//registry.npmjs.org/:_authToken=\${NPM_TOKEN}
EOF
tee -a "$temp_dir/package.json" 1>/dev/null <<EOF
{
  "name": "$PACKAGE_NAME",
  "version": "0.0.0"
}
EOF

pushd $temp_dir 1>/dev/null

ELECTRON_CFA_ITEM=lgrko2iptbajfhqokwhu2amsea
ELECTRON_CFA_GENERATOR_ITEM_ID=rawdp5uvajeyfii46ixjyzrjse
ELECTRON_ITEM=uc5oyoj7vbcbpp6wevbr7sgrky
ELECTRON_GENERATOR_ITEM_ID=i4vqjwdlkva7nou4bwsilmorgu

# Switch to the "electron" npm account
export NPM_TOKEN=$(op item get $ELECTRON_ITEM --fields label="Auth Token")
if [[ "$NPM_TOKEN" == "" ]]; then
  echo 1Password CLI not configured correctly
  exit 1
fi

# If the package does not exist, publish the fake one
if npm show "$PACKAGE_NAME" > /dev/null; then
  echo -e The $PRETTY_PACKAGE package already exists
else
  NPM_TOKEN=$NPM_TOKEN npm publish --access=public --otp=$(op item get $ELECTRON_GENERATOR_ITEM_ID --otp)
fi

# If the package doesn't have electron-cfa as an owner, add them
echo -e '\n'✅ Granting CFA access to $PRETTY_PACKAGE
npm access grant read-write @electron:cfa "$PACKAGE_NAME"

echo -e '\n'✅ Revoking default access to $PRETTY_PACKAGE
npm access revoke @electron:developers "$PACKAGE_NAME"

# Switch to the CFA account to mess with this package
export NPM_TOKEN=$(op item get $ELECTRON_CFA_ITEM --fields label="Auth Token")

echo -e '\n'✅ Required 2FA for $PRETTY_PACKAGE
npm access set mfa=publish "$PACKAGE_NAME" --otp=$(op item get $ELECTRON_CFA_GENERATOR_ITEM_ID --otp)

export NPM_TOKEN=.
unset NPM_TOKEN

popd 1>/dev/null
