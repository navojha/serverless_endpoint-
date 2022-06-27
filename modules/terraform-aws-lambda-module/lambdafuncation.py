import json
import boto3

def lambda_handler(event, context):
                    
    # Create a client
    client = boto3.client('s3')

    # Create a reusable Paginator
    paginator = client.get_paginator('list_objects_v2')

    # Create a PageIterator from the Paginator
    page_iterator = paginator.paginate(Bucket='my-0434523-bucket')

    objects = []
    for page in page_iterator:
        objects.extend(page['Contents'])
    return {
        "statusCode": 200,
        "headers": {
                "Content-Type":"application/json",
                },

        "body": json.dumps(objects, default=str)
               }