**Answers to short answer questions with queries**

## Part 1 (Models)

- What is our user repeat rate?

```sql
SELECT 
    CONCAT(ROUND(SUM(CASE WHEN num_orders > 1 THEN 1.0 ELSE 0 END) / COUNT(1), 2) * 100,'%') 
FROM (

    SELECT user_guid, COUNT(1) as num_orders
    FROM dbt_raj_k.stg_users
    JOIN dbt_raj_k.stg_orders
        USING (user_guid)
    GROUP BY  1
) base
```
**Answer**: 80%

- What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question

**Answer**: 
Good indicators that a user will purchase again: 
- Calculate purchase frequency rate which is the number of times an average customer makes a purchase in a given period and this can help us understand how those customers would come back to make another purchase.
- If the customer engages with your email marketing campaigns, there is a higher probability they will make the purchase again

What about indicators of users who are likely NOT to purchase again?
- Customer's who received their order later than the expected delivery time
- Customer's who are visiting the website and are not browsing pdp (product description pages)
- Customer's who creates an account with the greenery and never comes back on website

If you had more data, what features would you want to look into to answer this question
- I would like to look at marketing campaigns data and analyse further customer engagement to measure the campaign effectiveness as an indicator for a user to make a purchase


More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:

    - Core
    - Marketing
    - Product

Within each marts folder, create at least 1-2 intermediate models and 1-2 dimension/fact models.

Note: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data

Explain the marts models you added. Why did you organize the models in the way you did?

-  Core datasets includes 
    - **dim_products**: This datasets contain all greenery's product related information like product_id, name & quantity 
    - **dim_users**: This dataset captures all the user-level information
    - **fct_orders**: This captures order and user level informations which means there could be multiple rows with different order id's for the same user
    - **fct_user_orders**: This dataset would enable us answer business questions like user repeat rate 

- Marketing datasets includes
  - **fct_user_orders** - This dataset helps marketing team understand how many orders per user on an average kind of metrics.

  - **fct_user_sessions** - This dataset can be used by marketing stakeholders at greenery for sending marketing campaigns to customers who are interested in shopping ,buying and (shopping & buying). Also, helps understand active users, number of sessions per user, engagement rate (Number of key actions per session) 


- Product datasets includes
    - **fct_page_views** - This dataset would help stakeholders understand which page has more views ? or potentially looking at product funnel. How often does the user show up on the website? 

- Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
    - dbt docs generate
    - dbt docs serve --no-browser
    **Answer**: 

<p align="left">
   <img width="460" height="300" src="dbt-greenery/short-answers/wk_2/wk2_dag.png">
</p>


## Part 2 (Tests)

- We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

Run the following commmand to run dbt test and store results resulted in failure in audit schema

> dbt test --store-failures

    **Answer**: 
    - Added tests for uniqueness and not null on each column of datasets


- What assumptions are you making about each model? (i.e. why are you adding each test?)

    **Answer**: 
    - Delivery date is not before the order created at date 
    - One order id can only use one promo at a point
    - Users can register with only one email address i.e cannot have multiple email adrresses
    - order_guid is not unique in order_items


- Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

    **Answer**: 
- I found that order_guid is not unique in order_items and assumed that it is not unique in order_items by removing the test
  ```select * from "dbt"."dbt_raj_k_dbt_test__audit"."unique_stg_order_items_order_guid"```

- Assumed that for orders that are pending, their created date and delivery date can be NULL

```select * from "dbt"."dbt_raj_k_dbt_test__audit"."not_null_fct_orders_created_at_utc"```

- Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through

    **Answer**: 
- We can schedule these dbt test jobs via dbt airflow operator and that can help alert stakeholders at greenery whenever a test results in a failure, an email notification is being sent out.

- Alternative, to airflow is using dbt cloud to automate these test whenever there are changes in code in master branch. (something I would like to explore at a later point)