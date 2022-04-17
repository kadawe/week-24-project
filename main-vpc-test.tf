#### VPC ####

resource "aws_vpc" "vpc-test-jenkins" {
  cidr_block  = "10.181.130.0/24" # 업뎃 필요
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-test-jenkins"
  }
}

# resource "aws_vpc_ipv4_cidr_block_association" "vpc-test-secondary-cidr-1" { 
#   vpc_id     = aws_vpc.vpc-test.id
#   cidr_block = "100.64.0.0/16" 
# }