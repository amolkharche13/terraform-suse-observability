### Context
If you're looking to quickly deploy a SUSE Observability cluster, this repository provides a streamlined solution using Terraform. 
With the resources and configurations included, you can efficiently set up your SUSE Observability instance with minimal effort, whether it's for a small trial or a full-scale production environment.

Please ensure that you read the instructions thoroughly to understand the necessary prerequisites, configuration options, and deployment steps. 

⚠️ This repository is not designed for installing the SUSE Observability Cluster in air-gapped environments.

### Prerequisites

1. Ensure that `helm` is installed on your local machine. If it is not installed, you can install it using the following commands:
    ```bash
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    ```

2. Ensure that you have `kubectl` access to your Kubernetes cluster. If your `kubeconfig` is not set, run the following command to configure it:
    ```bash
     export KUBECONFIG=~/.kube/config
    ```
   **Notes**: If your kubeconfig is located at a different path, make sure to update the `config_path` in the `providers.tf` file under the `helm` section accordingly.

### Usage

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
- **`extra_values_file (OPTIONAL)`**: If you wish to provide any additional configuration files (e.g., for LDAP, email, authentication, OIDC, or other settings), you can do so by specifying the absolute path to the desired `values.yaml` file, such as `/abc/xyz/email.yaml`.


### Note
you may need to use ` terraform init -upgrade` to upgrade provider versions

Execute the below commands to start deployment.

```bash
terraform init
terraform plan
terraform apply
```
Print SUSE Observability URL and password by using following command
  ```bash
  cat ./suse-observability-values/templates/baseConfig_values.yaml | grep -E 'baseUrl|admin pa' | sed -nE 's/.*http/suse-observability URL: http/p; s/.*password is: /admin password: /p'
  ```
### Agent Installation
To install the SUSE Observability agent, go to the **SUSE Observability UI** --> **"Stackpacks"** section. Choose the Kubernetes distribution you're using. The command will be similar to the one shown below.
```bash
#NOTE: This is just a sample commands only.
helm upgrade --install \
--namespace suse-observability \
--create-namespace \
--set-string 'stackstate.apiKey'='lgksjljlgdjlkkjdssUCYtZORO' \
--set-string 'stackstate.cluster.name'='digital-ocean' \
--set-string 'stackstate.url'='https://stackstate.example.com:8080/receiver/stsAgent' \
suse-observability-agent suse-observability/suse-observability-agent
```

#### Destroy the SUSE Observability cluster when is no more needed.
```bash
terraform destroy
```
