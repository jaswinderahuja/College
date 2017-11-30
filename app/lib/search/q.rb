{
  
  "query": {
    "bool": {
      "filter": {
        "bool" : {
              "must" : [
                 { "terms" : {"location.name" : ["bangalore","mumbai"]}},
                 { "terms" : {"position" : ["engineer"]}}
              ]
           }
      }, 
      "should": [
        {
          "multi_match": {
            "query": "pramata ge",
            "fields": ["department","opening_type","position","location.name"]
          }
        },
        {
          "has_parent":{
            "parent_type": "companies",
            "query": {
              "multi_match": {
                "query": "pramata ge",
                "fields": ["name","business_nature","description"]
              }  
            }
            
          }
          
        }
      ],
      "minimum_should_match": 1
    }
  },
  "sort": [
    {
      "package_upper": {
        "order": "desc"
      }
    }
  ]
}
