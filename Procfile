web:    bundle exec rails s -p 9000 -e production
worker: RAILS_ENV=production bundle exec bin/delayed_job -n 2 run
worker: RAILS_ENV=production bundle exec bin/wordtree

# search: bundle exec rake sunspot:solr:run
# web: bundle exec unicorn_rails -p 9000 -c ./config/unicorn.rb -E RAILS_ENV
# worker: bundle exec rake jobs:work
