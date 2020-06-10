resource "aws_instance" "instance" {
	ami		= var.AMIS[var.AWS_REGION]
	instance_type	= "t2.micro"
	provisioner "local-exec" {
		command = "echo ${aws_instance.instance.private_ip} >> private_ips.txt"
	} 
}

output "ip" {
	value = aws_instance.instance.public_ip
}
