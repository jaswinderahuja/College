require 'elasticsearch'

module ES
  class ElasticsearchConfiguration
    ELASTICSEARCH_SETTING = YAML::load(File.open(File.dirname(__FILE__)+ '/../../config/elasticsearch_settings.yml'))
    
    def self.get_username
      ELASTICSEARCH_SETTING["es_auth_username"]
    end
         
    def self.get_password
      ELASTICSEARCH_SETTING["es_auth_password"]
    end

    def get_client
    	client = ::Elasticsearch::Client.new(
          :hosts=> [{
              :host=> "localhost",
              :port=> "9200",
              #:user=> ElasticsearchConfiguration.get_username,
              #:password=> ElasticsearchConfiguration.get_password
            }]
        )
    end
  end
end