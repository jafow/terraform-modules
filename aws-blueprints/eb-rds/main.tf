data "template_file" "task_definition" {
  template = file("templates/task-definition.json")
  vars = {
    container_memory = var.container_memory
    container_cpu = var.container_cpu
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "task_exec_role_policy" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "task_exec_role" {
  name = "${var.task_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# main
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family = var.task_name

  container_definitions = data.template_file.task_definition.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  memory = var.container_memory
  cpu = var.container_cpu
  execution_role_arn       = aws_iam_role.task_exec_role.arn
}
