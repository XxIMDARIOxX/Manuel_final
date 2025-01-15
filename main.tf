provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test_instance" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2
  instance_type = "t2.large"

  key_name      = var.key_name
  security_groups = [aws_security_group.instance_sg.name]

  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo yum install git -y
git clone https://github.com/XxIMDARIOxX/Manuel_final /home/ec2-user
cd /home/ec2-user/Manuel_final
sudo docker-compose up -d --build
EOF
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance-sg-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "key_name" {
  description = "Nombre de la clave SSH"
}

output "public_ip" {
  value = aws_instance.test_instance.public_ip
  description = "Dirección IP pública de la instancia EC2"
}

resource "null_resource" "test_services" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.test_instance.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
    }

    inline = [
      "sleep 30",
      "curl -f http://${aws_instance.test_instance.public_ip},                # Verificar que Nginx responde en el puerto 80
      "docker ps | grep nginx",                 # Comprobar que el contenedor de Nginx está en ejecución
      "docker ps | grep node",                  # Comprobar que el contenedor de Node.js está en ejecución
      "docker exec $(docker ps -qf 'name=mariadb') mysql -u root -e 'SHOW DATABASES;'" # Verificar conexión a MariaDB
    ]
  }
}
