module Elastic
  module WorkplaceSearch
    class Client
      module Permissions

        def list_all_permissions(content_source_key, current: 1, size: 25)
          get("sources/#{content_source_key}/permissions", "page[current]" => current, "page[size]" => size )
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
