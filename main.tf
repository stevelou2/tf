 resource "aws_instance" "example" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.xhtml
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true
  tags={
    Name = "terraform-example"
  }
}
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}