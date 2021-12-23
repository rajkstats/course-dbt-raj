# Analytics engineering with dbt

## Welcome to greenery's dbt project!
This repo is part of course work for *Analytics engineering with dbt course* by [co-rise](https://corise.com/).


### Using the project
- Run ```dbt run``` from git folder
- Re-built all views and tables in schema ```"dbt_rajk_stg"``` in Postgres

### How dbt works?
- **Easily explained:** dbt orchestrates transformations jobs from and into SQL databases.
- To reference a source table in the database it's most efficient to add it in ```/models/schema.yml``` and create a reference view (see ```models/stg/week_one/stg_events.sql```).
- Models in ```models/stg``` are created as views and should be prefixed with **stg_NAME.sql**
- Final models should be saved in ```models/final``` and are by default generated as tables.

### ERD 
![ERD](https://github.com/rajkstats/course-dbt-raj/blob/main/dbt-greenery/raw_erd.png)

### Coding Conventions
[dbt coding conventions](https://github.com/fishtown-analytics/corp/blob/master/dbt_coding_conventions.md)

### SQL Style Guides
- [Matt Mazur](https://github.com/mattm/sql-style-guide/blob/3eaef3519ca5cc7f21feac6581b257638f9b1564/README.md)
- [Brooklyn Data co](https://github.com/brooklyn-data/co/blob/main/sql_style_guide.md)
- [Git lab](https://about.gitlab.com/handbook/business-technology/data-team/platform/sql-style-guide/)
- [dbt labs](https://github.com/dbt-labs/corp/blob/master/dbt_style_guide.md)
