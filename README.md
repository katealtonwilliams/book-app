## Introduction

Hoping this will be my first attempt to build and deploy a little app that I can use to track my reading! There's a chance I will commit to this repo once and then completely forget about it forever, but hopefully that won't happen

# Tech
* python 3.13
* terraform 1.11.3
* AWS
* Github actions


# Formatting / Linting
* Ruff 0.11.3
* tflint 0.56.0
* to add flake 8 / other terraform stuff

# Security scanning
* tfsec 1.28.13
* to add swyft and grype


# To Do List:

## CICD Pipeline


* Terraform
    * Change deprecated things
    * Make names better
    * use more env variables where needed
    * Find out how best to save the back end terraform stuff

* Build a cicd pipeline to deploy lambda
    
    * write a tidy up pipeline
    * Only run over directories with changes
    * Linting - flake8, tflint (chekov, tflint? look at cs stuff)
    * Tests - pytest & feature 
    * Terraform plan & apply
    * security scanning
    * front end end to end tests

* Create pre commit hooks
    * Ruff / pep8
    * Terraform linting & terraform fmt
    * Only over changed files
    * Unit tests over changed files?

* Lambda function
    * Implement logging
    * Something to grab data from a data base
    * Front end to show data
    * Something to put data into data base
    * Front end to input data

* Other 
    * pinning versions of terraform, tflint, tfsec


