# AWS config for Learn Kubernetes the Hard Way

## Usage

Add this to the `./main.tf`

```
module "k8s-the-hard-way-setup" {
  source = "./modules/high-level/k8s-hard-way"
  key_pair = module.master_key_pairs.key_pair_names[0]
}
```