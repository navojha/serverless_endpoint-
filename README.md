
# 

Serverless endpoint where we can query s3 object lists. 

Project contains two major parts - Lambda function and Terraform resource definition.

### Table of Contents

    1. Getting started
    2. create infrastructure using Terraform
    3. Testing

### Getting started

    
    extract the package.

    $tar xvzf serverlessendpoint.tar.gz  
    $ls
    serverlessendpoint
    serverlessendpoint.tar.gz

### create infrastructure using Terraform

    cd serverlessendpoint

    terraform init

    terraform plan
    
    terraform apply 

### Testing

        curl http://my-alb-893456526.us-east-1.elb.amazonaws.com/lambda/get-objects
