module "Dev-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Dev-instance"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-025a0d6987e52cf20"] #replace your SG
  subnet_id = "subnet-00a0ff70891faf716" #replace your Subnet
  ami = data.aws_ami.ami_info.id
  user_data = file("dev-setup.sh")
  tags = {
    Name = "Dev-instance"
  }
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = data.aws_route53_zone.sainathdevops.name

  records = [
    {
      name    = "Dev-instance"
      type    = "A"
      ttl     = 1
      records = [
        module.Dev-instance.public_ip
      ]
      allow_overwrite = true
    }
  ]

}