# Content Source API - https://swiftype.com/documentation/enterprise-search/api/custom-sources
module Elastic
  module EnterpriseSearch
    class Client
      module Permissions

        def list_all_permissions(content_source_key, current: 1, size: 20)
          get("ent/sources/#{content_source_key}/permissions", "page[current]" => current, "page[size]" => size )
        end

        def get_user_permissions(content_source_key, user)
          get("ent/sources/#{content_source_key}/permissions/#{user}")
        end

        def update_user_permissions(content_source_key, user, permissions)
          post("ent/sources/#{content_source_key}/permissions/#{user}", :permissions => permissions)
        end

        def add_user_permissions(content_source_key, user, permissions)
          post("ent/sources/#{content_source_key}/permissions/#{user}/add", :permissions => permissions)
        end

        def remove_user_permissions(content_source_key, user, permissions)
          post("ent/sources/#{content_source_key}/permissions/#{user}/remove", :permissions => permissions)
        end

      end
    end
  end
end
