 <p align="center"><a href="https://circleci.com/gh/elastic/workplace-search-ruby"><img src="https://circleci.com/gh/elastic/workplace-search-ruby.svg?style=svg" alt="CircleCI build"></a></p>

> A first-party Ruby client for [Elastic Workplace Search](https://www.elastic.co/workplace-search).

## Contents

+ [Getting started](#getting-started-)
+ [Usage](#usage)
+ [FAQ](#faq-)
+ [Contribute](#contribute-)
+ [License](#license-)

***

## Getting started 🐣

To install the gem, execute:

```bash
gem install elastic-workplace-search
```

Or place `gem 'elastic-workplace-search', '~> 0.3.0` in your `Gemfile` and run `bundle install`.

## Usage

Create a new instance of the Elastic Workplace Search client with your access token:

```ruby
Elastic::WorkplaceSearch.access_token = '' # your access token
client = Elastic::WorkplaceSearch::Client.new
```

### Change API endpoint

```ruby
client = Elastic::WorkplaceSearch::Client.new
Elastic::WorkplaceSearch.endpoint = 'https://your-server.example.com/api/ws/v1'
```

### Specifying an HTTP Proxy

```ruby
client = Elastic::WorkplaceSearch::Client.new(:proxy => 'http://localhost:8888')
```

### Documents

#### Indexing Documents

This example shows how to use the index_documents method:

```ruby
content_source_key = '' # your content source key
documents = [
  {
    'id' => 'INscMGmhmX4',
    'url' => 'http://www.youtube.com/watch?v=v1uyQZNg2vE',
    'title' => 'The Original Grumpy Cat',
    'body' => 'this is a test'
  },
  {
    'id' => 'JNDFojsd02',
    'url' => 'http://www.youtube.com/watch?v=tsdfhk2j',
    'title' => 'Another Grumpy Cat',
    'body' => 'this is also a test'
  }
]

begin
  document_receipts = client.index_documents(content_source_key, documents)
  # handle results
rescue Elastic::WorkplaceSearch::ClientException => e
  # handle error
end
```

#### Destroying Documents

```ruby
content_source_key = '' # your content source key
document_ids = ['INscMGmhmX4', 'JNDFojsd02']

begin
  destroy_document_results = client.destroy_documents(content_source_key, document_ids)
  # handle destroy document results
rescue Elastic::WorkplaceSearch::ClientException => e
  # handle error
end
```

### Permissions

#### Listing all permissions

```ruby
content_source_key = '' # your content source key

client.list_all_permissions(content_source_key)
```

#### Listing all permissions with paging

```ruby
content_source_key = '' # your content source key

client.list_all_permissions(content_source_key, :current => 2, :size => 20)
```

#### Retrieve a User's permissions

```ruby
content_source_key = '' # your content source key
user = 'enterprise_search'

client.get_user_permissions(content_source_key, user)
```

#### Add permissions to a User
```ruby
content_source_key = '' # your content source key
user = 'enterprise_search'
permissions = ['permission1']

client.add_user_permissions(content_source_key, user, :permissions => permissions)
```

#### Update a User's permissions
```ruby
content_source_key = '' # your content source key
user = 'enterprise_search'
permissions = ['permission2']

client.update_user_permissions(content_source_key, user, :permissions => permissions)
```

#### Remove permissions from a User
```ruby
content_source_key = '' # your content source key
user = 'enterprise_search'
permissions = ['permission2']

client.remove_user_permissions(content_source_key, user, :permissions => permissions)
```

## Running tests

Run tests via rspec:

```bash
$ ENDPOINT=http://localhost:3002/api/ws/v1 bundle exec rspec
```

## FAQ 🔮

### Where do I report issues with the client?

If something is not working as expected, please open an [issue](https://github.com/elastic/workplace-search-ruby/issues/new).

## Contribute 🚀

We welcome contributors to the project. Before you begin, a couple notes...

+ Before opening a pull request, please create an issue to [discuss the scope of your proposal](https://github.com/elastic/workplace-search-ruby/issues).
+ Please write simple code and concise documentation, when appropriate.

## License 📗

[Apache 2.0](https://github.com/elastic/workplace-search-ruby/blob/master/LICENSE.txt) © [Elastic](https://github.com/elastic)

Thank you to all the [contributors](https://github.com/elastic/workplace-search-ruby/graphs/contributors)!
