# Jenkins-Pipeline_Ansible-cli_Template

Build jenkins pipeline by deployment plan using Azure CLI 


## Scenario  
Two VM Connected to LoadBalncer already, newer version of application must be deployed.  
- Blue Green Deployment
- Rolling Update

### Pipeline Flow
1. Source Clone from Repo  
2. Maven Build  
3. Make new Network Interface under existing Load Balancer's Backend Pool  
4. Make new VM connected to Network Interface  
5. Send Build File (JAR) to new VM using ssh copy  
6. Disallocate Old VM's Network interface from Backend Pool  
  
  
