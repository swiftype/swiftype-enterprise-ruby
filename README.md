<p align="center"><img src="https://github.com/swiftype/swiftype-enterprise-ruby/blob/master/logo-enterprise-search.png?raw=true" alt="Elastic Enterprise Search Logo"></p>

<a href="https://github.com/swiftype/swiftype-enterprise-ruby/releases"><img src="https://img.shields.io/github/release/swiftype/swiftype-enterprise-ruby/all.svg?style=flat-square" alt="GitHub release" /></a></p>

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
gem install swiftype-enterprise
```

Or place `gem 'swiftype-enterprise', '~> 1.0.0` in your `Gemfile` and run `bundle install`.

## Usage

Create a new instance of the Swiftype Enterprise Client with your access token:

    SwiftypeEnterprise.access_token = '' # your access token
    swiftype = SwiftypeEnterprise::Client.new

### Indexing Documents

This example shows how to use the index_documents method:

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
      document_receipts = swiftype.index_documents(content_source_key, documents)
      # handle results
    rescue SwiftypeEnterprise::ClientException => e
      # handle error
    end

### Destroying Documents

    content_source_key = '' # your content source key
    document_ids = ['INscMGmhmX4', 'JNDFojsd02']

    begin
      destroy_document_results = swiftype.destroy_documents(content_source_key, document_ids)
      # handle destroy document results
    rescue SwiftypeEnterprise::ClientException => e
      # handle error
    end

## Running tests

Run tests via rspec:

```bash
$ ENDPOINT=http://localhost:3002/api/v1 bundle exec rspec
```

## FAQ 🔮

### Where do I report issues with the client?

If something is not working as expected, please open an [issue](https://github.com/swiftype/swiftype-enterprise-ruby/issues/new).

## Contribute 🚀

We welcome contributors to the project. Before you begin, a couple notes...

+ Before opening a pull request, please create an issue to [discuss the scope of your proposal](https://github.com/swiftype/swiftype-enterprise-ruby/issues).
+ Please write simple code and concise documentation, when appropriate.

## License 📗

[MIT](https://github.com/swiftype/swiftype-enterprise-ruby/blob/master/LICENSE) © [Elastic](https://github.com/elastic)

Thank you to all the [contributors](https://github.com/swiftype/swiftype-enterprise-ruby/graphs/contributors)!
