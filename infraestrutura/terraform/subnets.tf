data "aws_availability_zones" "available" {
  state = "available"
}

# Primeira subnet pública
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "togglemaster-public-1"
    "kubernetes.io/role/elb" = "1"
  }
}

# Segunda subnet pública
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "togglemaster-public-2"
    "kubernetes.io/role/elb" = "1"
  }
}

# Primeira subnet privada
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                              = "togglemaster-private-1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Segunda subnet privada
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                              = "togglemaster-private-2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
