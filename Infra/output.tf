# output "instance_ip_addr1" {
#   value = aws_instance.proxy1.private_ip
# }
# output "instance_ip_addr2" {
#   value = aws_instance.proxy2.private_ip
# }
# output "instance_ip_addr3" {
#   value = aws_instance.backend1.private_ip
# }
# output "instance_ip_addr4" {
#   value = aws_instance.backend2.private_ip
# }

# output "eip_address" {
#   description = "The public IP address of the EIP"
#   value       = aws_eip.eip1.public_ip
# }

# output "eip_address2" {
#   description = "The public IP address of the EIP"
#   value       = aws_eip.eip2.public_ip
# }

# output "eip_address3" {
#   description = "The public IP address of the EIP"
#   value       = aws_eip.eip3.public_ip
# }

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
  description = "The DNS name of the application load balancer"
}
