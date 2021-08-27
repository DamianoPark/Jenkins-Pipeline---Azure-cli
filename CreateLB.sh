# Common var
subscription="KR02"
resourcegroup="RG-KR02-KRC-D-NONPRODSRV01-DEVOPS01"
vnet="vnet-KR02-krc-n-nonprodsrv01"
subnet="subnet-d-nonprod-ap01-10.232.142.0-24"
location="koreacentral"
tagsIaaS="BusinessUnit[=KR]"

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

# Create LB
az network lb create \
    --subscription ${subscription} \
    --resource-group ${resourcegroup} \
    --name ${lbname} \
    --sku ${lbsku} \
    --vnet-name ${vnet} \
    --subnet ${subnet} \
    --frontend-ip-name ${lbfrontendipname} \
    --backend-pool-name ${lbaddresspool} \
    --location ${location} \
    --private-ip-address ${lbprivateip} \
    --tags ${tagsIaaS}

# Create Probe
az network lb probe create \
    --subscription ${subscription} \
    --resource-group ${resourcegroup} \
    --lb-name ${lbname} \
    --name ${probename} \
    --protocol Http \
    --port 8080 

# create LB rule
az network lb rule create \
    --subscription ${subscription}
    --resource-group ${resourcegroup} \
    --lb-name ${lbname} \
    --name ${rulename} \
    --protocol tcp \
    --frontend-port 8080 \
    --backend-port 8080 \
    --frontend-ip-name ${lbfrontendipname} \
    --backend-pool-name ${lbaddresspool} \
    --probe-name ${probename} \
    --idle-timeout 15 \
    --enable-tcp-reset true