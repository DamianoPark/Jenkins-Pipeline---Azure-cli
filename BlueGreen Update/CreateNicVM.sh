# Common var
subscription="KR02"
resourcegroup="RG-KR02-KRC-D-NONPRODSRV01-DEVOPS01"
vnet="vnet-KR02-krc-n-nonprodsrv01"
subnet="subnet-d-nonprod-ap01-10.232.142.0-24"
location="koreacentral"
tagsIaaS="BusinessUnit[=KR]"

# VM Var
vmname=$1
VMsize="Standard_DS1_v2"
imageid=" ####### Located in Server #######"

# NIC Var
nicname=$vmname"-nic01"
nicip="  ########  "

# LB Var
lbname="ilb-KR02-krc-d-nonprodsrv01-devops"
lbsubnet="BackEndSubnet"
lbaddresspool="bepool-test01"
lbfrontendipname="fe-test01"
lbprivateip="  ########  "
lbsku="Standard"

# Probe Var
probename="probe-http8080"

# LBrule Var
rulename="lbrule-http"


# 전역 변수 자동화 추가 
# az tenant login - 임시로 매뉴얼 로그인 진행

az network nic create \
    --subscription ${subscription} \
    --resource-group ${resourcegroup} \
    --name ${nicname} \
    --vnet-name ${vnet} \
    --subnet ${lbsubnet} \
    --lb-name ${lbname} \
    --lb-address-pools ${lbaddresspool}\
    --tags ${tagsIaaS} \
    --private-ip-address ${nicip}\
    --location ${location} 
echo "NIC for LB Create Done"

# Create VM - nic
az vm create \
    --subscription ${subscription} \
    --resource-group ${resourcegroup} \
    --name ${vmname}${vmversion} \
    --size ${VMsize} \
    --nics ${nicname} \
    --image ${imageid} \
    --specialized \
    --admin-username azure-admin \
    --generate-ssh-keys \
    --custom-data cloud-config.yml ### FIX directory + Fix SSH pubkey in yml file
echo "VM Create Done"
