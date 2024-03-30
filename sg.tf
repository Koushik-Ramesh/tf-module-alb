# Creates Public Security Group
resource "aws_security_group" "alb-public" {
    name            = "Roboshop-${var.ENV}-public-alb-sg"
    description     = "allow only public traffic"
    vpc_id          = data.terraform_remote_state.vpc.outputs.VPC_ID

 
    ingress {
        description     = "Allows External HTTP Traffic"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = ["::/0"]
    }

    tags = {
        Name = "roboshop-${var.ENV}-public-alb-sg"
    }
}

# Creates Private Security Group
resource "aws_security_group" "alb-private" {
    name            = "Roboshop-${var.ENV}-private-alb-sg"
    description     = "allow only private traffic"
    vpc_id          = data.terraform_remote_state.vpc.outputs.VPC_ID

 
    ingress {
        description     = "Allows External HTTP Traffic"
        from_port       = 80
        to_port         = 90
        protocol        = "tcp"
        cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = ["::/0"]
    }

    tags = {
        Name = "roboshop-${var.ENV}-private-alb-sg"
    }
}