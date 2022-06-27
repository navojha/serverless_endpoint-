# Generate Objects

# resource "null_resource" "execfile" { 
#     provisioner "local-exec" { 
#     command = "python ./modules/terraform-aws-s3-module/generateobjects.py"
#   }
# }

# Create Bucket

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.aws_s3_bucket_name}"

}

#Upload objects

resource "aws_s3_object" "object1" {
  for_each = fileset("./modules/terraform-aws-s3-module/objects/","*")
  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  #source = "./modules/terraform-aws-s3-module/objects/${each.value}"
  #etag = filemd5("./modules/terraform-aws-s3-module/objects/${each.value}")
}
