require 'elasticsearch'

module ES
  class Configuration
    ELASTICSEARCH_SETTING = YAML::load(File.open("#{Rails.root}/config/elasticsearch_settings.yml"))
    INDEX_NAME = "college"
    COMPANY_INDEX = "company"
    INDEX_TYPES = [CAMPUS_DETAILS = "campus_details",CAMPUS_DRIVES ="campus_drives"]
        
    def initialize
      @client_obj = get_client
    end

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

    def create_mapping
        campus_map = {
          college_name: {
            type: "text"
          },
          university_name: {
            type: "text"
          },
          city: {
            type: "keyword"
          },
          timestamp: {
            type: "date",
            format: "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
            },
          approved_by: {
            type: "keyword"
          },
          rank: {
            type: "integer"
          },
          description: {
            type: "text"
          },
          established_year: {
            type: "integer"
          },
          asia_rank: {
            type: "integer"
          }
        }

        drive_map = {
           address: {
            type: "text"
            },
            no_of_students: {
              type: "integer"
            },
            rating: {
              type: "float"
            },
            department: {
              type: "text",
              fields: {
                raw: { 
                  type: "keyword"
                }
              }
            },
            description: {
              type: "text"
            },
            location: {
              :type=> "object",
              :properties=>{
                :name=>{:type=>"text"},
                :geo_location=>{:type=>"geo_point"}
              }
            },
            date_of_drive: {
              type: "date",
              format: "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
            },
            contact_details:{
              type: "nested",
              properties:{
                hod_email: { type: "keyword" },
                email_1:   { type: "keyword" },
                email_2:   { type: "keyword" },
                phone_1:   { type: "keyword" },
                phone_2:   { type: "keyword" }  
              }
            }
         }

         @client_obj.indices.create index: INDEX_NAME,
          body: {
            settings:{
              "number_of_shards": 2,
              "number_of_replicas": 0
            },
            mappings: {
              campus_details: {
                properties: campus_map
              },
              campus_drives: {
                _parent: { type: "campus_details" },
                properties: drive_map
              }
            }
          }
    end

        def create_mapping_company

        companies_map = {
                :name=> { :type=> "text" },
                :company_logo=>{ :type=>"text"},
                :established=> { :type=> "integer"},
                :no_of_employess=> { :type=> "integer"},
                :headquarter=> {
                  :type=> "object",
                  :properties=>{
                    :name=>{ :type=> "text"},
                    :geo_location=>{ :type=>"geo_point"}
                  }
                },                
                :revenue=> { :type=> "integer"},
                :description=> { :type=> "text"},
                :business_nature=> { :type=> "text"},
                :achievement=> { :type=> "text"},
                :website_url=> { :type=> "text"},
                :funding=>{
                   :type=> "object",
                    :properties=>{
                      :funding_by=> { :type=> "text" },
                      :date=> { :type=> "text" },
                      :amount=> { :type=> "integer" }
                    }
                },
                :tech_stack=>{
                   :type=> "object",
                    :properties=>{
                      :name=> { :type=> "text" }                      
                    }
                },
                :ceo=>{
                   :type=> "object",
                    :properties=>{
                      :name=> { :type=> "text" },
                      :image=> { :type=> "text" }
                    }
                },
                :contact_details=>{
                   :type=> "nested",
                    :properties=>{
                      :email_1=> { :type=> "keyword" },
                      :email_2=> { :type=> "keyword" },
                      :phone_1=> { :type=> "keyword" },
                      :phone_2=> { :type=> "keyword" }  
                    }
                }
        }


       openings_map =  {
              :position=> {:type=> "text"},
              :department=> {:type=> "text"},
              :description=> {:type=> "text"},
              :no_of_openings=> {:type=> "integer"},
              :opening_type=> {:type=> "text"},
              :package_upper=> {:type=> "integer"},
              :package_lower=> {:type=> "integer"},
              :location=> {
                :type=> "object",
                :properties=>{
                  :name=>{:type=> "text"},
                  :geo_location=>{:type=>"geo_point"}
                }
              },
              :contact_details=>{
               :type=> "nested",
                 :properties=>{
                   :email_1=> { :type=> "keyword" },
                   :email_2=> { :type=> "keyword" },
                   :phone_1=> { :type=> "keyword" },
                   :phone_2=> { :type=> "keyword" }  
                 }
             }            
          }


        @client_obj.indices.create index: COMPANY_INDEX,
          body: {
            settings:{
              "number_of_shards": 2,
              "number_of_replicas": 0
            },
            mappings: {
              companies: {
                properties: companies_map
              },
              openings: {
                _parent: { type: "companies" },
                properties: openings_map
              }
            }
          } 
    end


    def create_mapping_company_old

        companies_map = {
                :name=> { :type=> "text" },
                :established=> { :type=> "integer"},
                :no_of_employess=> { :type=> "integer"},
                :headquarter=> {
                  :type=> "object",
                  :properties=>{
                    :name=>{ :type=> "text"},
                    :geo_location=>{ :type=>"geo_point"}
                  }
                },
                :description=> { :type=> "text"},
                :business_nature=> { :type=> "text"},
                :contact_details=>{
                   :type=> "nested",
                    :properties=>{
                      :email_1=> { :type=> "keyword" },
                      :email_2=> { :type=> "keyword" },
                      :phone_1=> { :type=> "keyword" },
                      :phone_2=> { :type=> "keyword" }  
                    }
                }
        }


       openings_map =  {
              :position=> {:type=> "text"},
              :department=> {:type=> "text"},
              :no_of_openings=> {:type=> "integer"},
              :opening_type=> {:type=> "text"},
              :package_upper=> {:type=> "integer"},
              :package_lower=> {:type=> "integer"},
              :location=> {
                :type=> "object",
                :properties=>{
                  :name=>{:type=> "text"},
                  :geo_location=>{:type=>"geo_point"}
                }
              },
              :contact_details=>{
               :type=> "nested",
                 :properties=>{
                   :email_1=> { :type=> "keyword" },
                   :email_2=> { :type=> "keyword" },
                   :phone_1=> { :type=> "keyword" },
                   :phone_2=> { :type=> "keyword" }  
                 }
             }            
          }


        @client_obj.indices.create index: COMPANY_INDEX,
          body: {
            settings:{
              "number_of_shards": 2,
              "number_of_replicas": 0
            },
            mappings: {
              companies: {
                properties: companies_map
              },
              openings: {
                _parent: { type: "companies" },
                properties: openings_map
              }
            }
          } 
    end

  end
end