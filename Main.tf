provider "aws" {
  access_key = "myAccessKey"
  secret_key = "mySecretKey"
  region     = "us-west-2"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0ca77f0088718ec1f"
  instance_type = "t2.micro"
  key_name      = "TerraformYnov"
  security_groups = ["default"]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = filebase64("C:/Users/Noor/.ssh/TerraformYnov.pem")  # Use filebase64 to obtain Base64-encoded contents
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "C:\\Users\\Noor\\Desktop\\Terraform\\10_hello_files\\app.py"
    destination = "/home/ec2-user/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/app.py",
      "/home/ec2-user/app.py &",
    ]
  }
}
