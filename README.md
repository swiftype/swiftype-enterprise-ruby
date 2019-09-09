<p align="center"><img src="https://github.com/elastic/enterprise-search-ruby/blob/master/logo-enterprise-search.png?raw=true" alt="Elastic Enterprise Search Logo"></p>

<p align="center"><a href="https://circleci.com/gh/elastic/enterprise-search-ruby"><img src="https://circleci.com/gh/elastic/enterprise-search-ruby.svg?style=svg" alt="CircleCI build"></a></p>

> A first-party Ruby client for [Elastic Enterprise Search](https://www.elastic.co/solutions/enterprise-search).

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
gem install elastic-enterprise-search
```

Or place `gem 'elastic-enterprise-search', '~> 0.2.0` in your `Gemfile` and run `bundle install`.

## Usage

Create a new instance of the Enterprise Search Client with your access token:

```ruby
Elastic::EnterpriseSearch.access_token = '' # your access token
client = Elastic::EnterpriseSearch::Client.new
```

### Change API endpoint

```ruby
client = Elastic::EnterpriseSearch::Client.new
Elastic::EnterpriseSearch.endpoint = 'https://your-server.example.com/api/v1'
```

### Specifying an HTTP Proxy

```ruby
client = Elastic::EnterpriseSearch::Client.new(:proxy => 'http://localhost:8888')
```

### Indexing Documents

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
rescue Elastic::EnterpriseSearch::ClientException => e
  # handle error
end
```

### Destroying Documents

```ruby
content_source_key = '' # your content source key
document_ids = ['INscMGmhmX4', 'JNDFojsd02']

begin
  destroy_document_results = client.destroy_documents(content_source_key, document_ids)
  # handle destroy document results
rescue Elastic::EnterpriseSearch::ClientException => e
  # handle error
end
```

## Running tests

Run tests via rspec:

```bash
$ ENDPOINT=http://localhost:3002/api/v1 bundle exec rspec
```

## FAQ 🔮

### Where do I report issues with the client?

If something is not working as expected, please open an [issue](https://github.com/elastic/enterprise-search-ruby/issues/new).

## Contribute 🚀

We welcome contributors to the project. Before you begin, a couple notes...

+ Before opening a pull request, please create an issue to [discuss the scope of your proposal](https://github.com/elastic/enterprise-search-ruby/issues).
+ Please write simple code and concise documentation, when appropriate.

## License 📗

[Apache 2.0](https://github.com/elastic/enterprise-search-ruby/blob/master/LICENSE.txt) © [Elastic](https://github.com/elastic)

Thank you to all the [contributors](https://github.com/elastic/enterprise-search-ruby/graphs/contributors)!
