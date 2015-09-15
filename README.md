## Rales Engine

[![Stories in Ready](https://badge.waffle.io/applegrain/rales-engine.svg?label=ready&title=Ready)](http://waffle.io/applegrain/rales-engine) [![Code Climate](https://codeclimate.com/github/applegrain/rales-engine/badges/gpa.svg)](https://codeclimate.com/github/applegrain/rales-engine) [![Build Status](https://travis-ci.org/applegrain/rales-engine.svg?branch=master)](https://travis-ci.org/applegrain/rales-engine)

[Project Outline](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rales_engine.md)

This is the first individual project of Module 3 at the Turing School. Students have to use Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.

Sales Engine is the last project of Module 1. Students have to build a relational database and mimick
ActiveRecord query methods using just Ruby. [Sales Engine](https://github.com/applegrain/sales_engine)

###### instructions
* clone the project: `git clone git@github.com:applegrain/rales-engine.git`
* bundle
* run the migrations with `rake db:migrate`
* load the data with `rails runner "Parser.load"`
* start the server with `puma` or `rails s`

#### Learning Goals

* Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.
* Learn how to use controller tests to drive your design.
* Use Ruby and ActiveRecord to perform more complicated business intelligence.

#### Technical Expectations

* All endpoints will expect to return JSON data
* All endpoints should be exposed under an `api` and version (`v1`)
namespace (e.g. `/api/v1/merchants.json`)
* JSON responses should included `ids` only for associated records unless otherwise indicated (that is, don't embed the whole associated record, just the id)

