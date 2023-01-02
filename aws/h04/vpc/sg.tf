resource "aws_security_group" "example" {
    name = ""
    description = ""
    vpc_id = ""

    ingress = [ {
      cidr_blocks = [ "value" ]
      description = "value"
      from_port = 1
      ipv6_cidr_blocks = [ "value" ]
      prefix_list_ids = [ "value" ]
      protocol = "value"
      security_groups = [ "value" ]
      self = false
      to_port = 1
    } ]

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "value"
  }

}