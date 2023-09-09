brew install go docker jq git cmake gcc rustup make

rustup-init

rustc --version
cargo --version
rustup target list --installed

# if wasm32 is not listed above, run this
rustup target add wasm32-unknown-unknown

cargo generate --git https://github.com/CosmWasm/cw-template.git --name counter -d minimal=false


# git clone https://github.com/sei-protocol/sei-chain
# cd sei-chain
# git checkout $RELEASE
# make install

# seid version

# seid keys add admin -i
