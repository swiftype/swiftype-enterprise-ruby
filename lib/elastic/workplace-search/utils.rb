module Elastic
  module WorkplaceSearch
    module Utils
      extend self

      def stringify_keys(hash)
        output = {}
        hash.each do |key, value|
          output[key.to_s] = value
        end
        output
      end
    end
  end
end
