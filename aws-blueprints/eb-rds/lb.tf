# application load balancer 

resource "aws_lb" "alb" {
  name = "${var.cluster_name}-${var.task_name}-lb"
  load_balancer_type = "application"
  subnets = tolist(module.network.public_subnet_ids)
}
