schema "public" {
  comment = ""
}
enum "FormTemplateStatus" {
  schema = schema.public
  values = ["Draft", "Published", "Inactive"]
}