const char* tests[] = {
  "SELECT 1",
  "[{\"RawStmt\": {\"stmt\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 1}}, \"location\": 7}}, \"location\": 7}}], \"op\": 0}}}}]",
  "select sum(unique1) FILTER (WHERE unique1 IN (SELECT unique1 FROM onek where unique1 < 100)) FROM tenk1",
  "[{\"RawStmt\": {\"stmt\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"FuncCall\": {\"funcname\": [{\"String\": {\"str\": \"sum\"}}], \"args\": [{\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 11}}], \"agg_filter\": {\"SubLink\": {\"subLinkType\": 2, \"testexpr\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 34}}, \"subselect\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 53}}, \"location\": 53}}], \"fromClause\": [{\"RangeVar\": {\"relname\": \"onek\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 66}}], \"whereClause\": {\"A_Expr\": {\"kind\": 0, \"name\": [{\"String\": {\"str\": \"<\"}}], \"lexpr\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 77}}, \"rexpr\": {\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 100}}, \"location\": 87}}, \"location\": 85}}, \"op\": 0}}, \"location\": 42}}, \"location\": 7}}, \"location\": 7}}], \"fromClause\": [{\"RangeVar\": {\"relname\": \"tenk1\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 98}}], \"op\": 0}}}}]",
  "select sum(unique1) FILTER (WHERE unique1 = ANY (SELECT unique1 FROM onek where unique1 < 100)) FROM tenk1",
  "[{\"RawStmt\": {\"stmt\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"FuncCall\": {\"funcname\": [{\"String\": {\"str\": \"sum\"}}], \"args\": [{\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 11}}], \"agg_filter\": {\"SubLink\": {\"subLinkType\": 2, \"testexpr\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 34}}, \"operName\": [{\"String\": {\"str\": \"=\"}}], \"subselect\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 56}}, \"location\": 56}}], \"fromClause\": [{\"RangeVar\": {\"relname\": \"onek\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 69}}], \"whereClause\": {\"A_Expr\": {\"kind\": 0, \"name\": [{\"String\": {\"str\": \"<\"}}], \"lexpr\": {\"ColumnRef\": {\"fields\": [{\"String\": {\"str\": \"unique1\"}}], \"location\": 80}}, \"rexpr\": {\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 100}}, \"location\": 90}}, \"location\": 88}}, \"op\": 0}}, \"location\": 42}}, \"location\": 7}}, \"location\": 7}}], \"fromClause\": [{\"RangeVar\": {\"relname\": \"tenk1\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 101}}], \"op\": 0}}}}]",
  "CREATE FOREIGN TABLE films (code char(5) NOT NULL, title varchar(40) NOT NULL, did integer NOT NULL, date_prod date, kind varchar(10), len interval hour to minute) SERVER film_server;",
  "[{\"RawStmt\": {\"stmt\": {\"CreateForeignTableStmt\": {\"base\": {\"CreateStmt\": {\"relation\": {\"RangeVar\": {\"relname\": \"films\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 21}}, \"tableElts\": [{\"ColumnDef\": {\"colname\": \"code\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"bpchar\"}}], \"typmods\": [{\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 5}}, \"location\": 38}}], \"typemod\": -1, \"location\": 33}}, \"is_local\": true, \"constraints\": [{\"Constraint\": {\"contype\": 1, \"location\": 41}}], \"location\": 28}}, {\"ColumnDef\": {\"colname\": \"title\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"varchar\"}}], \"typmods\": [{\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 40}}, \"location\": 65}}], \"typemod\": -1, \"location\": 57}}, \"is_local\": true, \"constraints\": [{\"Constraint\": {\"contype\": 1, \"location\": 69}}], \"location\": 51}}, {\"ColumnDef\": {\"colname\": \"did\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"int4\"}}], \"typemod\": -1, \"location\": 83}}, \"is_local\": true, \"constraints\": [{\"Constraint\": {\"contype\": 1, \"location\": 91}}], \"location\": 79}}, {\"ColumnDef\": {\"colname\": \"date_prod\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"date\"}}], \"typemod\": -1, \"location\": 111}}, \"is_local\": true, \"location\": 101}}, {\"ColumnDef\": {\"colname\": \"kind\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"varchar\"}}], \"typmods\": [{\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 10}}, \"location\": 130}}], \"typemod\": -1, \"location\": 122}}, \"is_local\": true, \"location\": 117}}, {\"ColumnDef\": {\"colname\": \"len\", \"typeName\": {\"TypeName\": {\"names\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"interval\"}}], \"typmods\": [{\"A_Const\": {\"val\": {\"Integer\": {\"ival\": 3072}}, \"location\": 148}}], \"typemod\": -1, \"location\": 139}}, \"is_local\": true, \"location\": 135}}], \"oncommit\": 0}}, \"servername\": \"film_server\"}}, \"stmt_len\": 182}}]",
  "CREATE FOREIGN TABLE ft1 () SERVER no_server",
  "[{\"RawStmt\": {\"stmt\": {\"CreateForeignTableStmt\": {\"base\": {\"CreateStmt\": {\"relation\": {\"RangeVar\": {\"relname\": \"ft1\", \"inh\": true, \"relpersistence\": \"p\", \"location\": 21}}, \"oncommit\": 0}}, \"servername\": \"no_server\"}}}}]",
  "SELECT parse_ident(E'\"c\".X XXXX\002XXXXXX')",
  "[{\"RawStmt\": {\"stmt\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"FuncCall\": {\"funcname\": [{\"String\": {\"str\": \"parse_ident\"}}], \"args\": [{\"A_Const\": {\"val\": {\"String\": {\"str\": \"\\\"c\\\".X XXXX\\u0002XXXXXX\"}}, \"location\": 19}}], \"location\": 7}}, \"location\": 7}}], \"op\": 0}}}}]",
  "ALTER ROLE postgres LOGIN SUPERUSER PASSWORD 'xyz'",
  "[{\"RawStmt\": {\"stmt\": {\"AlterRoleStmt\": {\"role\": {\"RoleSpec\": {\"roletype\": 0, \"rolename\": \"postgres\", \"location\": 11}}, \"options\": [{\"DefElem\": {\"defname\": \"canlogin\", \"arg\": {\"Integer\": {\"ival\": 1}}, \"defaction\": 0, \"location\": 20}}, {\"DefElem\": {\"defname\": \"superuser\", \"arg\": {\"Integer\": {\"ival\": 1}}, \"defaction\": 0, \"location\": 26}}, {\"DefElem\": {\"defname\": \"password\", \"arg\": {\"A_Const\": {\"val\": {\"String\": {\"str\": \"xyz\"}}, \"location\": 45}}, \"defaction\": 0, \"location\": 36}}], \"action\": 1}}}}]",
  "ALTER ROLE postgres LOGIN SUPERUSER PASSWORD ?",
  "[{\"RawStmt\": {\"stmt\": {\"AlterRoleStmt\": {\"role\": {\"RoleSpec\": {\"roletype\": 0, \"rolename\": \"postgres\", \"location\": 11}}, \"options\": [{\"DefElem\": {\"defname\": \"canlogin\", \"arg\": {\"Integer\": {\"ival\": 1}}, \"defaction\": 0, \"location\": 20}}, {\"DefElem\": {\"defname\": \"superuser\", \"arg\": {\"Integer\": {\"ival\": 1}}, \"defaction\": 0, \"location\": 26}}, {\"DefElem\": {\"defname\": \"password\", \"arg\": {\"ParamRef\": {\"location\": 45}}, \"defaction\": 0, \"location\": 36}}], \"action\": 1}}}}]",
  "SELECT extract($1 FROM $2)",
  "[{\"RawStmt\": {\"stmt\": {\"SelectStmt\": {\"targetList\": [{\"ResTarget\": {\"val\": {\"FuncCall\": {\"funcname\": [{\"String\": {\"str\": \"pg_catalog\"}}, {\"String\": {\"str\": \"date_part\"}}], \"args\": [{\"ParamRef\": {\"number\": 1, \"location\": 15}}, {\"ParamRef\": {\"number\": 2, \"location\": 23}}], \"location\": 7}}, \"location\": 7}}], \"op\": 0}}}}]"
};

size_t testsLength = __LINE__ - 4;
