# allennlp-server
Serve allennlp services as separate routes, all in one port

# Setup
Just build the container with `./build.sh` and then `./start.sh` to get the start command, you should personalize it to your models and routes to serve those models. They are to be specified by parameter when launching the instance.

# Important
For this container to work you should have a `models/` directory in the root of
the repository with all the models to use. To download a finetuned model for
ner, run the `./start.sh` script.
