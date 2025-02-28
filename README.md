## DBT Code For APD


## Getting Started

1. clone and pull repo
2. Install dbt normally (make sure to install with dbt-postgres) in virtual env
3. ```dbt --version``` to check dbt-core and postgres adapter are installed and working
4. add profiles.yml in ~/.dbt/ and complete the login creds for dev


```

  dbt_apd:
   outputs:

    dev:
      type: postgres
      threads: 4
      host: [host]
      port: [port]
      user: [dev_username]
      pass: [dev_password]
      dbname: [dbname]
      schema: [dev_schema]


    prod:
      type: postgres
      threads: [1 or more]
      host: [host]
      port: [port]
      user: [prod_username]
      pass: [prod_password]
      dbname: [dbname]
      schema: [prod_schema]

  target: dev


```


5. enter repo folder

6. ```dbt deps``` - installs dbt_utils package

7. ```dbt run``` - should run as long as schema and table specified in input model - extract_forms_params model exists

8. ```dbt test``` - run tests

9. Model viewer dbt docs - browser based viewer to see details of models and compiled column list of each table/view 
```
dbt docs generate
dbt docs serve
```
