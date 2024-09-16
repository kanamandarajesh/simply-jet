resource "aws_route53_zone" "main" {
  name = var.domain_name
  
  tags = {
    Name = "main-route53-zone"
  }
}

resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.app_domain_name
  type    = "A"
  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}
