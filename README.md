## Introduction

Hoping this will be my first attempt to build and deploy a little app that I can use to track my reading! There's a chance I will commit to this repo once and then completely forget about it forever, but hopefully that won't happen

# Tech 
* Written using python 3.13


# To Do List:

## CICD Pipeline

* Build a cicd pipeline to deploy lambda
    * Linting - flake8, tflint
    * Tests - pytest & feature 
    * Terraform plan & apply
    * security scanning
    * front end end to end tests

* Create pre commit hooks
    * Ruff / black
    * Terraform linting
    * Only over changed files
    * Unit tests over changed files?

* Lambda function
    * Implement logging
    * Something to grab data from a data base
    * Front end to show data
    * Something to put data into data base
    * Front end to input data
