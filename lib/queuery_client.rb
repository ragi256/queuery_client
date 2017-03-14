require "redshift-connector/url_data_file_bundle"
require "queuery_client/version"
require "queuery_client/client"

module QueueryClient
  class << self
    def endpoint=(endpoint)
      @endpoint = endpoint
    end

    def endpoint
      @endpoint || 'http://localhost:3000'
    end

    def query(select_stmt)
      client = Client.new(endpoint)
      res = client.query_and_wait(select_stmt)
      RedshiftConnector::UrlDataFileBundle.new(res['data_objects'])
    end
  end

end
