# Running a WordPress Website for Free on Google Cloud Platform: A Comprehensive Guide

# Introduction:

In today's digital age, having an online presence is essential, whether you're a business, blogger, or hobbyist. However, hosting a website can often come with significant costs, especially for those just starting. In my quest to find a cost-effective solution, I conducted extensive research and found that many tutorials either involved manual processes, expensive managed services, or complex setups with multiple servers. I set out to combine these approaches into a single solution using Google Cloud Platform's (GCP) free tier, leveraging open-source tools and automation.

Combining Solutions: 

I integrated insights from various blogs and tutorials, notably utilizing the guide by Kslifer for setting up the database and leveraging Spacelift's Terraform guide for automating the deployment of WordPress on GCP. By combining these resources, I created a streamlined process that makes hosting a WordPress website on GCP's free tier accessible to everyone.

https://github.com/kslifer/wordpress-on-gcp-free-tier/blob/master/INSTALL.md

https://spacelift.io/blog/getting-started-with-terraform-on-gcp

Getting Started: 

The first step is to sign up for a GCP free account, which can be easily done using your existing Google email account. GCP offers a free tier with a generous credit, allowing users to experiment and host small-scale applications without incurring charges.

https://k21academy.com/google-cloud/create-google-cloud-free-tier-account/

Setting up Terraform: 

Next, you'll need to set up Terraform on your local machine. Terraform is an open-source infrastructure as code tool that automates the deployment of cloud resources. Follow the instructions provided by Terraform's official documentation to install it on your system.

https://spacelift.io/blog/how-to-install-terraform

Cloning the GitHub Repository: 

Clone my GitHub repository, which contains the Terraform configuration files needed to deploy a WordPress website on GCP's free tier. This repository simplifies the setup process by providing pre-configured Terraform scripts. Below is a quick tutorial to install and use git.

Installing Git:
Windows:

Download the Git installer for Windows from the official Git website (https://git-scm.com/download/win).Run the installer and follow the installation wizard. Ensure that Git is added to your system PATH during installation.

Configuring Git:

After installing Git, you need to configure it with your name and email address. Open a terminal or command prompt and run the following commands:

git config --global user.name "Your Name" 
git config --global user.email "your.email@example.com"
You can also configure additional settings such as default text editor and line endings using Git configuration commands.

Using Git:

Initializing a Repository:
Cloning a Repository:

To clone an existing Git repository from a remote server (e.g., GitHub), use the following command:

git clone https://github.com/wvandergryp/wordpress-gcp-free-one-vm.git
cd wordpress-gcp-free-one-vm
Running Terraform: 

Once you've cloned the repository, navigate to the directory containing the Terraform files and run the Terraform commands to deploy the WordPress infrastructure on GCP. Terraform will automatically provision the necessary resources, including virtual machines, databases, and networking components.

Edit the file terraform.tfvars.template with your favorite editor. The only entry you have to worry about is the project_id. Change that to your project id.

# This value MUST be configured
project_id    = "<project id>"
You can find this in your Google console here after you have logged in. Click on the Project button.

One more thing, you will need to activate the compte API. By activating the Compute Engine API, you gain access to a wide range of virtual machine instances and other compute resources that you can deploy and manage within your Google Cloud Platform projects.

Activating the Compute Engine API:

1. Access the Google Cloud Console:

Open your web browser and navigate to the Google Cloud Console - http://console.cloud/google.com

2. Navigate to the APIs & Services Dashboard:

Click on the navigation menu (☰) located at the top left corner of the console.

Under the "APIs & Services" section, select "Dashboard" from the dropdown menu.

3. Find and Select the Compute Engine API:

In the "Dashboard," locate the "Enable APIs and Services" section.

Click on the "+ ENABLE APIS AND SERVICES" button.

4. Search for the Compute Engine API:

In the search bar, type "Compute Engine API" or simply "Compute Engine."

The Compute Engine API should appear in the search results.

5. Enable the Compute Engine API:

Click on the "Compute Engine API" from the search results to access its page.

On the Compute Engine API page, click on the "Enable" button to enable the API for your project.

6. Wait for Activation:

Google Cloud Platform will now activate the Compute Engine API for your project. This process may take a few moments.

7. Confirmation:

Once the Compute Engine API is activated, you will receive a confirmation message indicating that the API is enabled and ready for use.

8. Verify API Status:

You can verify that the Compute Engine API is enabled by navigating to the "APIs & Services" > "Library" section in the Google Cloud Console. The Compute Engine API should now appear in the list of enabled APIs.

In summary, activating the Compute Engine API is a fundamental step in leveraging the full capabilities of Google Cloud Platform's compute services. It enables automation, integration, development, testing, and efficient management of infrastructure resources, enhancing productivity and scalability for various use cases.

Now run the following commands:

terraform init
terraform plan -var-file=terraform.tfvars.template
terraform apply -var-file=terraform.tfvars.template
(this will deploy the VM with WordPress and MariaDB)

If you want more info on Terraform for GCP see Terraform Deploy Help 

Confirm VM deployment:

Login to your Google account here http://console.cloud.google.com and got to VM's. 

You should see your VM.


Logging into WordPress:

Now copy the public IP and copy and paste it into a new browser tab or window. There you have it. Your WordPress is ready to go.

Log in with the default credentials to begin customizing your website and adding content.

Set a title, enter your user ID you want to use and copy the password, add an email address and click install.

Now you will be prompt to use the credentials you just created.

Click here to see your example Wordpress page created for you automatically.

Summary: 

In summary, hosting a WordPress website on Google Cloud Platform's free tier is now more accessible than ever. By leveraging Terraform automation and combining insights from various resources, I've created a streamlined solution that allows anyone to launch a WordPress website on GCP without incurring any costs. With this guide, you can embark on your online journey with confidence, knowing that your website is hosted on a reliable and cost-effective platform.


Disclaimer and Caution:

Before proceeding with the deployment of resources on the cloud, it's crucial to acknowledge and understand potential risks and costs associated with cloud services. While this guide aims to facilitate the setup of a WordPress website on the Google Cloud Platform (GCP) free tier, it's essential to exercise caution and responsibility.

Cost Considerations: Using cloud services, even within the free tier, may incur charges if certain limits are exceeded or additional resources are utilized. Always be mindful of the resources you provision and regularly monitor your usage to avoid unexpected costs. I, as the author of this guide, cannot be held responsible for any unforeseen expenses incurred during the usage of GCP services.

Cleanup and Resource Management: After completing the setup, it's crucial to perform cleanup actions to avoid ongoing charges. You can destroy the virtual machine instance and associated resources by running the following command:

terraform destroy
Ensure that you run this command from the same directory where you initially installed WordPress using Terraform. Terraform maintains a state file in that directory to track the current state of your infrastructure.

Budget Monitoring: To further mitigate the risk of unexpected costs, consider setting up a budget alert within the Google Cloud Console. This feature allows you to define a budget threshold and receive email notifications if your expenditure approaches or exceeds the specified limit. Setting a budget alert, for example, at $5, provides an additional layer of financial oversight and helps prevent inadvertent overspending.

By exercising diligence, regularly monitoring resource usage, and implementing appropriate budget controls, you can enjoy the benefits of cloud services while minimizing financial risks. Remember, responsible cloud usage is key to maximizing the value of cloud computing resources.

Setting Up a Budget in Google Cloud Platform:

Monitoring your spending on Google Cloud Platform (GCP) is essential to avoid unexpected costs and ensure efficient resource management. Setting up a budget allows you to establish spending limits and receive alerts when your expenses approach or exceed the defined threshold. Follow these steps to set up a budget in Google Cloud:

1. Access the Google Cloud Console:

Open your web browser and navigate to the Google Cloud Console.

2. Navigate to Billing:

Click on the navigation menu (☰) located at the top left corner of the console.

Under the "Billing" section, select "Billing" from the dropdown menu.

3. View Your Billing Account:

If you have multiple billing accounts, select the billing account associated with the project you want to monitor.

4. Access the Billing Overview:

Click on the "Billing overview" tab in the left sidebar menu.

5. Create a Budget:

Scroll down to the "Budgets & alerts" section and click on the "Create budget" button.

6. Configure Budget Details:

Provide a name for your budget to easily identify it.

Set the amount for your budget. You can specify the amount in your desired currency and choose whether it's a monthly or custom budget.

Define the budget period, which can be monthly, quarterly, or annually.

Optionally, set up budget filters to monitor specific projects, services, or labels.

Specify the alert threshold percentage. This is the percentage of your budget at which you want to receive an alert.

Choose the type of alert notification, such as email or Pub/Sub notification.

7. Review and Confirm:

Review your budget configuration to ensure accuracy.

Click on the "Save" or "Create" button to create your budget.

8. Receive Budget Alerts:

Once your budget is created, you will start receiving alerts when your spending approaches or exceeds the defined threshold.

You can view and manage your budgets under the "Budgets & alerts" section in the Billing overview.

By setting up a budget in Google Cloud Platform, you gain better visibility and control over your spending, helping you manage costs effectively and avoid unexpected charges. Regularly review your budgets and adjust them as needed to align with your usage and financial objectives.
