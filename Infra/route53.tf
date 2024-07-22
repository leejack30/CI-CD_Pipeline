data "aws_route53_zone" "domainname" {
  name         = "smileredchantravel.com"  
}

data "aws_lb" "alb" {
  name = aws_lb.alb.name
}

resource "aws_route53_record" "alb_dns" {
  zone_id = data.aws_route53_zone.domainname.zone_id
  name    = "www.smileredchantravel.com"  
  type    = "A"
  alias {
    name                   = data.aws_lb.alb.dns_name
    zone_id                = data.aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
