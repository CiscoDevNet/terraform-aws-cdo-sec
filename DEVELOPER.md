A mirror of this repo is maintained in https://wwwin-github.cisco.com/siwarrie/cdo-sec-terraform-module/.

# Running Tests

We use Terraform-Compliance (https://terraform-compliance.com/) to test our Terraform code. To install Terraform compliance, add this to your `~/.zshrc`. You will need Docker running.

```
function terraform-compliance { docker run --rm -v $(pwd):/target -i -t eerkunt/terraform-compliance "$@"; }
```

Then, run:
```
. ~/.zshrc
```
to make sure the Docker container with `terraform-compliance` is available.