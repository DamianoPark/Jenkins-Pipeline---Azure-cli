# Common var
resourcegroup="RG-KR02-KRC-D-NONPRODSRV01-DEVOPS01"

# NIC Var
nicname=${vmname}"-nic01"

# LB Var
lbname="ilb-KR02-krc-d-nonprodsrv01-devops"
lbaddresspool="bepool-test01"

# 기존 VM NIC 로드밸런서 할당 해제
az network nic ip-config address-pool remove \
    --address-pool ${lbaddresspool} \
    --ip-config-name ipconfig1 \
    --nic-name  ${nicname} \
    --resource-group ${resourcegroup} \
    --lb-name ${lbname}
echo "NIC Removed from LB"