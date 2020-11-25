# Shipments Tracking

The objective of this project is the implementation of a microservice that allows tracking shipments made by logistics companies such as FedEx.

For the implementation I used the ruby on rails framework configured only as an API.

The API consists of an endpoint for creating shipments and a task for synchronization.

The idea is that microservice clients who want to get the status of a shipment make a POST request to the shipments creation endpoint. Then, every certain period of time, the microservice must execute the synchronization task which is responsible for:

1) Search shipments with pending notifications.
2) Obtain the status of shipments by consulting an external service.
3) Update the status of shipments in the microservice database.
4) Notify the status of shipments to a notification topic.

### AWS services

The communication of notifications about the status of shipments is done in an asynchronous manner. For this I used a pub/sub pattern supported in the cloud by AWS.

- [Fanout to Amazon SQS queues](https://docs.aws.amazon.com/sns/latest/dg/sns-sqs-as-subscriber.html)

I used SNS, SQS and Cognito.

- [Amazon Simple Notification Service](https://aws.amazon.com/sns/)
- [Amazon Simple Queue Service](https://aws.amazon.com/sqs/)
- [Amazon Cognito](https://aws.amazon.com/cognito/)

### Prerequisites

- Ruby 2.7.0
- Rails 6.0.3
- PostgreSQL

### Check out the repository

```bash
$ git clone https://github.com/anmacagno/shipments-tracking.git
```

### Install the dependencies

```bash
$ bundle install
```

### Create and setup the database

Important: postgres will use the default role. This is the same name as the operating system user that initialized the database.

```bash
$ rails db:create
$ rails db:setup
```

### Run the test suite

```bash
$ bundle exec rspec
```

### Run the server

The project includes seed data, but if you want you can start the server and make a request to the shipments creation endpoint.

```bash
$ rails server
```

POST http://localhost:3000/shipments

```json
{
  "shipment": {
    "carrier": "sandbox",
    "tracking_reference": "001"
  }
}
```

### Run the synchronization script

The script syncs shipments for a given carrier (sandbox or fedex).

```bash
$ rake shipments:synchronize[sandbox]
$ rake shipments:synchronize[fedex]
```

### Added gems

These are the gems that I added to the project:

- interactor-rails
- fedex
- aws-sdk-sns
- rspec-rails
- shoulda-matchers

### Project structure overview

These are the folders and files created/modified. Where to start? Look at the file **lib/tasks/shipments.rake**.

```
├── app
│   ├── controllers
│   │   └── shipments_controller.rb
│   ├── factories
│   │   ├── trackers
│   │   │   ├── base_tracker.rb
│   │   │   ├── fedex_tracker.rb
│   │   │   └── sandbox_tracker.rb
│   │   └── tracker_factory.rb
│   ├── interactors
│   │   ├── steps
│   │   │   ├── find_shipments.rb
│   │   │   ├── publish_notifications.rb
│   │   │   ├── track_shipments.rb
│   │   │   └── update_shipments.rb
│   │   └── synchronize_shipments.rb
│   ├── models
│   │   └── shipment.rb
│   ├── services
│   │   ├── shipments
│   │   │   └── create_service.rb
│   │   └── application_service.rb
│   └── singletons
│       ├── fedex_service_error.rb
│       ├── fedex_service.rb
│       ├── sns_service_error.rb
│       └── sns_service.rb
├── config
│   ├── database.yml
│   └── routes.rb
├── db
│   ├── migrate
│   │   └── 20201118205942_create_shipments.rb
│   ├── schema.rb
│   └── seeds.rb
├── lib
│   └── tasks
│       └── shipments.rake
├── spec
│   └── *
└── Gemfile
```
