resource "aws_instance" "webserver2" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
}
