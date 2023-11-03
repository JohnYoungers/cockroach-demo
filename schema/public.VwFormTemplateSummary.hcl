view "VwFormTemplateSummary" {
  schema = schema.public
  comment = ""
  column "FormTemplateId" {
    null = true
    type = uuid
  }
  column "Name" {
    null = true
    type = text
  }
  column "Status" {
    null = true
    type = enum.FormTemplateStatus
  }
  column "CreatedBy" {
    null = true
    type = uuid
  }
  column "CreatedTimestamp" {
    null = true
    type = timestamptz
  }
  column "LastModifiedBy" {
    null = true
    type = uuid
  }
  column "LastModifiedTimestamp" {
    null = true
    type = timestamptz
  }
  column "CreatedByName" {
    null = true
    type = text
  }
  column "LastModifiedByName" {
    null = true
    type = text
  }
  as         = <<-SQL
   SELECT ft."Id" AS "FormTemplateId",
      ft."Name",
      ft."Status",
      ft."CreatedBy",
      ft."CreatedTimestamp",
      ft."LastModifiedBy",
      ft."LastModifiedTimestamp",
      pu_created."DisplayName" AS "CreatedByName",
      pu_modified."DisplayName" AS "LastModifiedByName"
     FROM "FormTemplate" ft
     LEFT JOIN "Platform"."User" pu_created ON (pu_created."UserId" = ft."CreatedBy")
     LEFT JOIN "Platform"."User" pu_modified ON (pu_modified."UserId" = ft."LastModifiedBy");
  SQL
  depends_on = [table.User, table.FormTemplate]
}