## Initial Setup
```shell
docker run --rm -d -p 26257:26257 --name aca-local-crdb cockroachdb/cockroach:v23.1.11 start-single-node --insecure
docker exec aca-local-crdb cockroach sql --insecure -e 'CREATE DATABASE crdbdemo'

docker run -e 'POSTGRES_PASSWORD=sa_password!123456' -p 5432:5432 --name aca-local-psql -d postgres:14.5
docker exec -it aca-local-psql psql -U postgres -d postgres -c 'CREATE DATABASE crdbdemo'
```

## Atlas setup
* Windows: 
  * download: https://release.ariga.io/atlas/atlas-windows-amd64-latest.exe
  * move file to `%USERPROFILE%\tools\atlas.exe`
  * ensure entry to user path: `%USERPROFILE%\tools`

## Apply schema
* Postgres:
  * `atlas schema apply --auto-approve -u 'postgres://postgres:sa_password!123456@127.0.0.1:5432/crdbdemo?sslmode=disable' -f file://schema --schema public,Platform`
* Cockroach:
  * `atlas schema apply --auto-approve -u 'postgres://root@127.0.0.1:26257/crdbdemo?sslmode=disable' -f file://schema --schema public,Platform`

## Apply migrations (TVFs)
* Initialization
  * First run `atlas migrate hash --dir file://migrations`
* Postgres:
  * `atlas migrate apply -u 'postgres://postgres:sa_password!123456@127.0.0.1:5432/crdbdemo?sslmode=disable' --dir file://migrations --allow-dirty`
* Cockroach:
  * `atlas migrate apply -u 'postgres://root@127.0.0.1:26257/crdbdemo?sslmode=disable' --dir file://migrations --allow-dirty`
    * crashes with `pq: at or near "table": syntax error: unimplemented: this syntax`

## EFCore Scaffolding
* Initialization
  * First run `dotnet restore` to restore the project
  * Then `dotnet tool restore` to install the cli tool
* Postgres:
  * `dotnet ef dbcontext scaffold "Host=127.0.0.1;Port=5432;Database=crdbdemo;Username=postgres;Password=sa_password!123456" Npgsql.EntityFrameworkCore.PostgreSQL --verbose --context EntityContext --context-dir Entities --output-dir Entities --data-annotations --force --no-onconfiguring --no-pluralize`
* Cockroach:
  * `dotnet ef dbcontext scaffold "Host=127.0.0.1;Port=26257;Database=crdbdemo;Username=root" Npgsql.EntityFrameworkCore.PostgreSQL --verbose --context EntityContext --context-dir Entities --output-dir Entities --data-annotations --force --no-onconfiguring --no-pluralize`
    * crashes with `42883: unknown function: pg_indexam_has_property(): function undefined`