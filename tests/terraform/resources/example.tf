resource "aws_athena_workgroup" "analytics" {
  name = "analytics"

  # no tags

  configuration {
    enforce_workgroup_configuration = true
  }
}

resource "aws_athena_workgroup" "processing" {
  name = "processing"

  tags = merge(module.mylabel.tags, {
    Group = "DataEngineering"
  })

  configuration {
    enforce_workgroup_configuration = false
  }
}