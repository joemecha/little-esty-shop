![image](lib/assets/ascii_title.png)
## Table of contents
* [Link](#Link)
* [Description](#description)
* [Database Schema](#database-schema)
* [Learning Goals](#learning-goals)
* [Project Requirements](#project-requirements)
* [Setup](#setup)
* [Features](#features)
* [Development Phases](#development-phases)
* [Contact](#contact)


## Link: [Little Esty Shop on Heroku](https://fast-basin-75082.herokuapp.com/)


## Description

"Little Esty Shop" is a group project that requires students to build a
fictitious e-commerce platform where merchants and admins can manage inventory
and fulfill customer invoices.

## Database schema
![image](https://user-images.githubusercontent.com/24997456/115422934-9a523580-a1ba-11eb-9123-29c86e5f3a76.png)

## Learning Goals
- Practice designing a normalized database schema and defining model
  relationships
- Utilize advanced routing techniques including namespacing to organize and
  group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP
  principles to organize code

## Project Requirements
- use Rails 5.2.x
- use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- use GitHub branching, team code reviews via GitHub comments, and github
  projects to track progress on user stories
- must deploy completed code to Heroku

## Setup
This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Features
1. Admin and Merchant dashboards
2. SQL/ActiveRecord methods display statistics on top merchants, customers,
   sales, invoice revenue etc.
3. CRUD functionality for Merchant Items and Admin Merchants
4. Hit a GitHub API to display project and team member info on the site
5. Custom Rake actions to load CSV file data into database


## Phases
1. [Database Setup](./doc/db_setup.md)
2. [User Stories](./doc/user_stories.md)
3. [Extensions](./doc/extensions.md)
4. [Evaluation](./doc/evaluation.md)


## Contact
Created by
* [@joemecha](https://github.com/joemecha)

* [@alexanderbruek](https://github.com/brueck1988)

* [@andrewsmith](https://github.com/IcelandicGambit)

* [@keeganoshea](https://github.com/koshea9)

~ feel free to contact us ~
