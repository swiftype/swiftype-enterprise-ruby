# frozen_string_literal: true

module Elastic
  module WorkplaceSearch
    class Client
      # Module included in Elastic::WorkplaceSearch::Client for handling the Documents API
      #
      # @see https://www.elastic.co/guide/en/workplace-search/current/workplace-search-document-permissions-api.html
      module Permissions
        def list_all_permissions(content_source_key, current: 1, size: 25)
          get("sources/#{content_source_key}/permissions", 'page[current]' => current, 'page[size]' => size)
        end

        def get_user_permissions(content_source_key, user)
          get("sources/#{content_source_key}/permissions/#{user}")
        end

        def update_user_permissions(content_source_key, user, options)
          post("sources/#{content_source_key}/permissions/#{user}", options)
        end

        def add_user_permissions(content_source_key, user, options)
          post("sources/#{content_source_key}/permissions/#{user}/add", options)
        end

        def remove_user_permissions(content_source_key, user, options)
          post("sources/#{content_source_key}/permissions/#{user}/remove", options)
        end
      end
    end
  end
end
