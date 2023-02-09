# # Bastion SG
# # Web SG
# # DB SG
# # ALB SG

# resource "aws_security_group" "bastion-sg" {
#   name        = "bastion-sg"
#   description = "Bastion host's security group"
#   vpc_id      = aws_vpc.kogoon-vpc.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = [aws_vpc.kogoon-vpc.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }

# resource "aws_security_group" "example" {
#     name = "test"
#     description = "test"
#     vpc_id = aws_vpc.kogoon-vpc.id

#     ingress = [ {
#       protocol = "tcp"
#       cidr_blocks = [ "aws_vpc.kogoon-vpc.cidr_block" ]
#       description = "value"
#       from_port = 22
#       to_port = 22
#     } ]

#     egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "value"
#   }

# }