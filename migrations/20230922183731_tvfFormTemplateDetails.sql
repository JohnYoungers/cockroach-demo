CREATE FUNCTION "tvfFormTemplateDetails"(IN P_TemplateId uuid DEFAULT null, IN P_TemplateVersionId uuid DEFAULT null)
    RETURNS TABLE("FormTemplateId" UUID
				  ,"Name" TEXT
				  ,"Status" "FormTemplateStatus"
				  ,"CreatedBy" UUID
				  ,"CreatedTimestamp" TIMESTAMP
				  ,"LastModifiedBy" UUID
				  ,"LastModifiedTimestamp" TIMESTAMP
				  ,"CreatedByName" TEXT
				  ,"LastModifiedByName" TEXT				
				 )
    LANGUAGE SQL AS $$
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
	$$;
