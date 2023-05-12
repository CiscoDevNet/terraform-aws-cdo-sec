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


# Commit messages and versioning

This repository automatically (in a Github Action) tags the Github repository with a version using semantic versioning. The kind of version we will release is determined by the commit message, which must follow the [Angular Commit Message conventions](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format). You can generate commits following the Angular Commit Message Conventions using [Commitizen](https://github.com/commitizen/cz-cli).

Please *do not* commit or merge to this branch without using the Angular Commit conventions.

To understand how automatic versioning works, please look at the [Semantic Release repository](https://github.com/semantic-release/semantic-release).
