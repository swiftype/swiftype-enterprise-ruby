module Elastic
  module WorkplaceSearch
    class ClientException < StandardError; end
    class NonExistentRecord < ClientException; end
    class InvalidCredentials < ClientException; end
    class BadRequest < ClientException; end
    class Forbidden < ClientException; end
    class UnexpectedHTTPException < ClientException; end
    class InvalidDocument < ClientException; end
  end
end
