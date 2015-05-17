Searchkick.client = Elasticsearch::Client.new(hosts: ["localhost:9200", "localhost:9201"], retry_on_failure: true)
Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['BONSAI_URL']