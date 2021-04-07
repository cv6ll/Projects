# README #

This is a repository to set up Prometheus-Grafana stack on EC2 instance in AWS.

### How do you get it set up? ###

* Clone this repo to your local machine.
* Configure your AWS CLI. You will need your AWS Access key and Secret key for this.   (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
For this: Use AWS web console -> My Security Credentials -> Access keys(acces key id and secret access key)
Create New Access Key. Save file.
* Then Generate keypair in AWS web console: EC2 Dashboard -> Network & Security -> Key Pairs
* When example.ppk is generated, insert name ("example" in this case) to main.tf row 24 (Under GrafanaProm module key_name = "example")
* After installing AWS CLI navigate to root directory.
* Run command "AWS configure" and enter both (Acces key and secret access key) keys that you created. Region and json default.
* Once in root directory, run "terraform init", "terraform plan" , "terraform apply" 
* Takes about 5minutes to spin up EC2 instance and run grafana and prometheus stack.

You can access web ui via Public IPV4 DNS displayed in AWS console.
Port 3000 for grafana and 9090 for prometheus.
