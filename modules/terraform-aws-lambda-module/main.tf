#Defining lambda role

resource "aws_iam_role" "lambda_role" {
  name = "aws_lambda_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
})
}

#IAM Policy for logging from a lambda
resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
          ],
          "Resource": "arn:aws:logs:*:*:*"
      },
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "*"
      }
  ]
})
}


#Policy attachment on the role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role      = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}


#Generate an archive from content, a file, or a directory of file

locals {
  lambda_zip_location = "./modules/terraform-aws-lambda-module/lambdafuncation.zip"
}

data "archive_file" "lambda_zip"{
  type = "zip"
  source_file = "./modules/terraform-aws-lambda-module/lambdafuncation.py"
  output_path = "$(local.lambda_zip_location)"
  
}

#Create a lambda function


resource "aws_lambda_function" "lambda" {
  filename      = "$(local.lambda_zip_location)"
  function_name = "${var.aws_lambda_function_name}"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "lambdafuncation.lambda_handler"
  runtime       = "python3.8" 
  timeout       = 10  
  #source_code_hash = "${filebase64sha256(local.lambda_zip_location)}"
}

resource "aws_lambda_alias" "lambda" {
  name             = "lambda_alias"
  description      = ""
  function_name    = "${aws_lambda_function.lambda.function_name}"
  function_version = "$LATEST"
}

resource "aws_lambda_permission" "allow_alb_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = "${var.alb_target_group_arn}"
}

resource "aws_lb_target_group_attachment" "tg_attachment_test" {
    target_group_arn = "${var.alb_target_group_arn}"
    target_id        = "${aws_lambda_function.lambda.arn}"
    depends_on       = [aws_lambda_permission.allow_alb_to_invoke_lambda,aws_lambda_function.lambda]
}



