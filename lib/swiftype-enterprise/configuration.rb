require 'uri'
require 'swiftype-enterprise/version'

module SwiftypeEnterprise
  module Configuration
    DEFAULT_ENDPOINT = "http://localhost:3002/api/v1/"
    DEFAULT_USER_AGENT = "swiftype-enterprise-ruby/#{SwiftypeEnterprise::VERSION}"

    VALID_OPTIONS_KEYS = [
      :access_token,
      :user_agent,
      :endpoint
    ].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    # Reset configuration to default values.
    def reset
      self.access_token = nil
      self.endpoint = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self
    end

    # Yields the SwiftypeEnterprise::Configuration module which can be used to set configuration options.
    #
    # @return self
    def configure
      yield self
      self
    end

    # Return a hash of the configured options.
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{ |k| options[k] = send(k) }
      options
    end

    # setter for endpoint that ensures it always ends in '/'
    def endpoint=(endpoint)
      if endpoint.end_with?('/')
        @endpoint = endpoint
      else
        @endpoint = "#{endpoint}/"
      end
    end
  end
end
