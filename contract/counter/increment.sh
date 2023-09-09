if [ -z "${keyname}" ];
then keyname=admin
fi
if [ -z "${password}" ];
then password="12345678\n"
fi

seid=~/go/bin/seid
contract='sei14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sh9m79m' # Fill in contract address from deployment step, ex. sei14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sh9m79m

$seid tx wasm execute $contract '{"increment":{}}' --from $keyname --broadcast-mode=block  --chain-id sei-chain --gas=30000000 --fees=3000000usei -y

new_count=$($seid q wasm contract-state smart $contract '{"get_count":{}}' | grep -A 1 "count:" | awk -F: '/count:/{getline; print $2}')
printf "New count: %s\n" "$new_count"
