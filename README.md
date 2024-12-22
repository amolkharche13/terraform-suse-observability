## Context
If you're looking to quickly deploy a SUSE Observability cluster, this repository provides a streamlined solution using Terraform. 
With the resources and configurations included, you can efficiently set up your SUSE Observability instance with minimal effort, whether it's for a small trial or a full-scale production environment.

Please ensure that you read the instructions thoroughly to understand the necessary prerequisites, configuration options, and deployment steps. 
## Usage

```bash
git clone https://github.com/amolkharche13/terraform-suse-observability.git
cd terraform-suse-observability
```

- Copy `terraform.tfvars.example` to `terraform.tfvars`
- Edit `terraform.tfvars`
  - Update the required variables:
- **`license`**: The SUSE Observability license key obtained from the SCC portal.
- **`baseurl`**: The external URL that users and agents will use to connect to SUSE Observability. If not specified, the default is `http://localhost:8080`.
- **`sizing`**: Choose one of the following profiles: `trial`, `10-nonha`, `20-nonha`, `50-nonha`, `100-nonha`, `150-ha`, `250-ha`, `500-ha`. Based on the selected profile, a `sizing_values.yaml` file is generated containing default resource sizes and configuration settings for deploying SUSE Observability in either High Availability (HA) or Non-High Availability (NonHa) mode. For example, selecting `10-nonha` will produce a `sizing_values.yaml` for deploying a Non-HA SUSE Observability instance to monitor a 10-node cluster in Non-HA mode. If not specified, the default value is `10-nonha`.


**NOTE** 
you may need to use ` terraform init -upgrade` to upgrade provider versions

Execute the below commands to start deployment.

```bash
terraform init
terraform plan
terraform apply
```

- Destroy the resources when cluster is no more needed.
```bash
terraform destroy
```
