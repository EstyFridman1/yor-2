resource "aws_instance" "many_instance_tags" {
  ami           = ""
  instance_type = ""
  tags = merge({ "Name" = "tag-for-instance", "Environment" = "prod" },
    { "Owner" = "bridgecrew"
    },
    { "yor_trace" = "4329587194",
      "git_org"   = "bana" }, {
      yor_name    = "many_instance_tags"
  })
}

resource "aws_alb" "alb_with_merged_tags" {
  tags = merge({ "Name" = "tag-for-alb", "Environment" = "prod" },
    { "yor_trace" = "4329587194",
      "git_org"   = "bana" }, {
      yor_name    = "alb_with_merged_tags"
  })
}

resource "aws_vpc" "vpc_tags_one_line" {
  cidr_block = ""
  tags = { "Name" = "tag-for-s3", "Environment" = "prod"
    yor_name  = "vpc_tags_one_line"
    yor_trace = "ca53fd1c-afc9-4f77-8443-c59e34ad0410"
  }
}

resource "aws_s3_bucket" "bucket_var_tags" {
  tags = merge(var.tags, {
    yor_name  = "bucket_var_tags"
    yor_trace = "0176e0a1-51c7-40c0-849d-713b81d713ea"
  })
}

variable "tags" {
  default = {
    "Name"        = "tag-for-s3"
    "Environment" = "prod"
  }
}

resource "aws_instance" "instance_merged_var" {
  ami           = ""
  instance_type = ""
  tags = merge(var.tags,
    { "yor_trace" = "4329587194",
      "git_org"   = "bana" }, {
      yor_name    = "instance_merged_var"
  })
}

variable "new_env_tag" {
  default = {
    "Environment" = "old_env"
  }
}

resource "aws_instance" "instance_merged_override" {
  ami           = ""
  instance_type = ""
  tags = merge(var.new_env_tag, { "Environment" = "new_env" }, {
    yor_name  = "instance_merged_override"
    yor_trace = "4753446f-01b0-46ad-85ff-4f44475550ae"
  })
}

resource "aws_instance" "instance_empty_tag" {
  ami           = ""
  instance_type = ""
  tags = {
    yor_name  = "instance_empty_tag"
    yor_trace = "ecfd7bad-f92f-48a1-aafd-a1fa1834e641"
  }
}

resource "aws_instance" "instance_no_tags" {
  ami           = ""
  instance_type = ""
  tags = {
    yor_name  = "instance_no_tags"
    yor_trace = "32998fa9-cb27-4f42-a576-c1b0fa4d9ad2"
  }
}

resource "aws_instance" "instance_null_tags" {
  ami           = ""
  instance_type = ""
  tags = {
    yor_name  = "instance_null_tags"
    yor_trace = "30dc13d0-2da4-423d-9008-ec8fcdd9ea0f"
  }
}

resource "aws_autoscaling_group" "autoscaling_group_tagged" {
  // This resource should not be tagged
  tag {
    key                 = "Name"
    propagate_at_launch = false
    value               = "Mine"
  }
  max_size = 0
  min_size = 0
}

resource "aws_autoscaling_group" "autoscaling_group" {
  // This resource should not be tagged as well
  max_size = 0
  min_size = 0
}
