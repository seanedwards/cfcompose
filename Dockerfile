FROM seanedwards/cfer

COPY cfer_env.rb /usr/src/app/cfer_env.rb

CMD ["cfer", "generate", "/usr/src/app/cfer_env.rb", "--region", "us-east-1"]
