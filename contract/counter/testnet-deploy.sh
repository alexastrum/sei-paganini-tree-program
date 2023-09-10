
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

# $seid keys show $keyname
admin_addr=$(printf $password | $seid keys show $keyname | grep -A 1 "address" | sed -n 's/.*address: //p')
printf "%s addr: %s\n" $keyname $admin_addr
$seid q bank balances $admin_addr --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2

# $seid tx wasm store $contract -y --from=$keyname --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2 --gas=1100000 --fees=1100000usei --broadcast-mode=block
code=2814
# code=$(printf $password | $seid tx wasm store $contract -y --from=$keyname --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2 --gas=30000000 --fees=1000000usei --broadcast-mode=block | grep -A 1 "code_id" | sed -n 's/.*value: "//p' | sed -n 's/"//p')
# $seid q bank balances $admin_addr --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2
printf "Code id: %s\n" $code

# $seid tx wasm instantiate $code '{"count": 0}' --from $keyname --broadcast-mode=block --label "counter-aarch64" --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2 --gas=200000 --fees=200000usei --admin=$admin_addr -y
addr=sei17h76djf3xymwtstccmr8lz9l4p3e5nj5nezwzylya6fuww4dt3fse853ak
# addr=$(printf $password | $seid tx wasm instantiate $code '{"count": 0}' --from $keyname --broadcast-mode=block --label "counter-aarch64" --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2 --gas=30000000 --fees=1000000usei --admin=$admin_addr -y | grep -A 1 -m 1 "key: _contract_address" | sed -n 's/.*value: //p' | xargs)
printf "Deployed contract address: %s\n" $addr
# $seid q bank balances $admin_addr --node https://rpc.atlantic-2.seinetwork.io --chain-id atlantic-2
