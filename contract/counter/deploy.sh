if [ -z "${contract}" ];
then contract=artifacts/counter-aarch64.wasm
fi
if [ -z "${keyname}" ];
then keyname=admin
fi
if [ -z "${password}" ];
then password="12345678\n"
fi

# seid=~/go/bin/seid
# # $seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=35000000 --fees=10000000usei --broadcast-mode=block

# raw=`$seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=35000000 --fees=10000000usei --broadcast-mode=block`
# echo $raw

# code=$(printf $password | $seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=35000000 --fees=10000000usei --broadcast-mode=block | grep -A 1 "code_id" | sed -n 's/.*value: "//p' | sed -n 's/"//p')
# printf "Code id is %s\n" $code

seid=~/go/bin/seid

code=$(printf $password | $seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=10000000 --fees=10000000usei --broadcast-mode=block | grep -A 1 "code_id" | sed -n 's/.*value: "//p' | sed -n 's/"//p')
printf "Code id is %s\n" $code

admin_addr=$(printf $password | $seid keys show $keyname | grep -A 1 "address" | sed -n 's/.*address: //p')
printf "Admin addr id is %s\n" $admin_addr

addr=$(printf $password | $seid tx wasm instantiate $code '{"count": 0}' --from $keyname --broadcast-mode=block --label "counter-aarch64" --chain-id sei-chain --gas=30000000 --fees=3000000usei --admin=$admin_addr -y | grep -A 1 -m 1 "key: _contract_address" | sed -n 's/.*value: //p' | xargs)
printf "Deployed counter address is %s\n" $addr
