table "User" {
  schema = schema.Platform
  column "UserId" {
    null = false
    type = uuid
  }
  column "InternalId" {
    null = false
    type = integer
  }
  column "DisplayName" {
    null = false
    type = text
  }
  column "FirstName" {
    null = false
    type = text
  }
  column "LastName" {
    null = false
    type = text
  }
  column "Email" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.UserId, column.InternalId]
  }
  index "uc_userid" {
    unique  = true
    columns = [column.UserId]
  }
}