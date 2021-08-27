# Common var
resourcegroup="RG-KR02-KRC-D-NONPRODSRV01-DEVOPS01"

# VM Var
vmname=$1

# Get Public ip
testprivateip=$(az vm list-ip-addresses --resource-group ${resourcegroup} --name ${vmname} --query "[].virtualMachine.network.privateIpAddresses[0]" --output tsv)
echo "Private IP : ${testprivateip}"

# SSH - Fingerprint
ssh-keyscan -t rsa ${testprivateip} >> ~/.ssh/known_hosts

# SCP .jar File to Target Server
scp target/*.jar azureuser@${testprivateip}:~/demo.jar
echo "SCP Success"

# Install Jdk on Target Server
ssh azureuser@${testprivateip} "java -jar ~/demo.jar & || echo Application_RUN"
echo "Java Application Start"