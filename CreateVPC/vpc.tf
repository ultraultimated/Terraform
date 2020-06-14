# Internet VPC
resource "aws_vpc" "main" {
	cidr_block 		= "10.0.0.0/16"
	instance_tenancy 	= "default"
	enable_dns_support	= "true"
	enable_dns_hostnames 	= "true"
	enable_classiclink 	= "false"
	tags = {
		Name = "main"
	}
}

#subnets
resource "aws_subnet" "main-public-us-east-1"{
	vpc_id 			= aws_vpc.main.id
	cidr_block 		= "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone 	= "us-east-1a"
	tags = {
	
		Name = "main-public-us-east-1a"
	}
	
}

resource "aws_subnet" "main-public-us-west-1"{
        vpc_id                  = aws_vpc.main.id
	cidr_block              = "10.0.2.0/24"
        map_public_ip_on_launch = "true"
        availability_zone       = "us-east-1b"
        tags = {

                Name = "main-public-us-east-1b"                                                                                  }

}

resource "aws_subnet" "main-public-us-east-2"{
        vpc_id                  = aws_vpc.main.id
	cidr_block              = "10.0.3.0/24"
        map_public_ip_on_launch = "true"
        availability_zone       = "us-east-1c"
        tags = {

                Name = "main-public-us-east-1c"                                                                                  }

}

resource "aws_subnet" "main-private-us-east-1"{
	vpc_id			= aws_vpc.main.id
	cidr_block 		= "10.0.4.0/24"
	map_public_ip_on_launch = "true"
	availability_zone 	= "us-east-1a"
	tags = {
		Name = "main-private-us-east-1a"
	}
}

resource "aws_subnet" "main-private-us-west-1"{
        vpc_id                  = aws_vpc.main.id
        cidr_block              = "10.0.5.0/24"
        map_public_ip_on_launch = "true"
	availability_zone       = "us-east-1b"
        tags = {
                Name = "main-private-us-east-1b"
        }
}

resource "aws_subnet" "main-private-us-east-2"{
        vpc_id                  = aws_vpc.main.id
        cidr_block              = "10.0.6.0/24"
        map_public_ip_on_launch = "true"
	availability_zone       = "us-east-1c"
        tags = {
                Name = "main-private-us-east-1c"
        }
}

#Internet Gateway
resource "aws_internet_gateway" "main-gateway" {

	vpc_id = aws_vpc.main.id
	tags = {
		Name = "Main-Internet-Gateway"
	}
}

#route Table

resource "aws_route_table" "main-public"{
	vpc_id = aws_vpc.main.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.main-gateway.id
	}
	tags = {
		Name = "main-route-table"
	}
	
}

#route associations public subnets
resource "aws_route_table_association" "main-public-us-east-1b" {
	subnet_id 		= aws_subnet.main-public-us-east-1.id
	route_table_id 		= aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-us-west-1b" {
        subnet_id               = aws_subnet.main-public-us-west-1.id
        route_table_id          = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-us-east-2b" {
        subnet_id               = aws_subnet.main-public-us-east-2.id
        route_table_id          = aws_route_table.main-public.id
}
