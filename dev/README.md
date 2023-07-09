Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices



pytorch workflow:
    - vectorize_table(your_columns)
    - pytorch_test_train(vectorized_table)
    - pytorch_evaluate()
        - huggingface  


gpt workflow:
    - ask_asistant
        - enrich input dataset 
        - chromatize input dataset 
        - workflow:
            - gpt - enrich input question
            - chroma search dataset 
            - gpt - answer 




objects 
    - udf__pytorch_evaluate(array)  # evaluates input row 
    - sp__pytorch_train(table)      # trains pytorch model 
    - normalize_table()             # normalizes table into logits 



# how tos: 

1. generate docs:
    $ dbt docs generate                 # generate docs 
    $ dbt docs serve [ --port 8080]     # show docs on localhost:8080

2. train pytorch model
    2.1 $ dbt seed --select seed_demo_automobiles   # creates table on SF used for demo 