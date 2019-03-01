# Knowledge Base

## Description

This application provides a knowledge base in a simple question-answer format. It is possible to create, read, edit and delete articles. Each article is automatically translated to German by the [Azure Translator Text API](https://azure.microsoft.com/en-us/services/cognitive-services/translator-text-api/).

For convenience the articles are searchable. By using the form in the navigation bar relevant questions will show up for the queried term. The number of articles per page is limited to 30 and further questions can be accessed with the pagination widget at the bottom of the page.

## Setup

This is a standard Rails application written in Ruby. To install Ruby please refer to the [documentation](https://www.ruby-lang.org/en/documentation/installation/).

For the translator service, an API key from [Azure Cognitive Services](https://azure.microsoft.com/en-us/services/cognitive-services/translator-text-api/) is required. Before starting the server, set the API key as an environment variable as `TRANSLATE_API_KEY`.

In production, PostgreSQL is used as the database. It can be configured by setting the `POSTGRES_USERNAME`, `POSTGRES_PASSWORD` and `POSTGRES_DATABASE` environment variables.
