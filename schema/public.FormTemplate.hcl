table "FormTemplate" {
  schema = schema.public
  column "Id" {
    null = false
    type = uuid
  }
  column "Name" {
    null = false
    type = text
  }
  column "Status" {
    null = false
    type = enum.FormTemplateStatus
  }
  column "CreatedBy" {
    null = false
    type = uuid
  }
  column "CreatedTimestamp" {
    null = false
    type = timestamptz
  }
  column "LastModifiedBy" {
    null = false
    type = uuid
  }
  column "LastModifiedTimestamp" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.Id]
  }
  foreign_key "fk_createdby" {
    columns     = [column.CreatedBy]
    ref_columns = [table.User.column.UserId]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "fk_lastmodifiedby" {
    columns     = [column.LastModifiedBy]
    ref_columns = [table.User.column.UserId]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}