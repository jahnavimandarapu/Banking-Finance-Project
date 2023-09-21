resource "aws_instance" "test-server" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  key_name = "ubunkey"
  vpc_security_group_ids= ["sg-0e5437ac2307ed575"]
  connection {
  type       = "ssh"
  user       = "ubuntu"
  private_key = file("./ubunkey.pem")
  host      = self.public_ip
  }
  provisioner "remote-exec" {
     inline = [ "echo 'wait to start instance' "]
  }
  tags = {
  Name = "test-server"
  }
  provisioner "local-exec" {
    command = " echo $(aws_instance.test-server.public_ip) > inventory "
  }
  provisioner "local-exec" {
  command = " ansible-playbook /var/lib/jenkins/workspace/banking-finance-project/my-serverfiles/finance-playbook.yml "
  }
}  
  
  
