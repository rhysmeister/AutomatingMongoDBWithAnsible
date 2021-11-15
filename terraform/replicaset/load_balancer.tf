resource "aws_lb" "lb" {
    name = "mongodb-replicaset-lb"
    load_balancer_type = "application"
    subnets = aws_subnet.jumphost_subnet.id
}

resource "aws_lb_target_group" "target_group" {
    name     = "target-group"
    port     = 80
    protocol = "http"
    vpc_id   = aws_vpc.mongodb_replicaset.id
}

resource "aws_lb_listener" "web_listener" {
    load_balancer_arn = aws_lb.lb.arn
    port              = 80
    protocol          = "http"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.target_group.arn
    }
}

resource "aws_lb_target_group_attachment" "attach" {
    count            = var.jumphost_instance_count
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id        = aws_instance.jumphost[count.index].id
    port             = 80
}