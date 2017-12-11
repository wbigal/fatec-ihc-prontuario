Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['BONSAI_URL'] || 'http://localhost:9200',
  logs: true
)
