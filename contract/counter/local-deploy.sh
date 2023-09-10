if [ -z "${contract}" ];
then contract=artifacts/counter-aarch64.wasm
fi
if [ -z "${keyname}" ];
then keyname=admin
fi
if [ -z "${password}" ];
then password="12345678\n"
fi

seid=~/go/bin/seid

admin_addr=$(printf $password | $seid keys show $keyname | grep -A 1 "address" | sed -n 's/.*address: //p')
printf "%s addr: %s\n" $keyname $admin_addr

code=$(printf $password | $seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=10000000 --fees=10000000usei --broadcast-mode=block | grep -A 1 "code_id" | sed -n 's/.*value: "//p' | sed -n 's/"//p')
printf "Code id: %s\n" $code

addr=$(printf $password | $seid tx wasm instantiate $code '{"count": 0}' --from $keyname --broadcast-mode=block --label "counter-aarch64" --chain-id sei-chain --gas=30000000 --fees=3000000usei --admin=$admin_addr -y | grep -A 1 -m 1 "key: _contract_address" | sed -n 's/.*value: //p' | xargs)
printf "Deployed contract address: %s\n" $addr
