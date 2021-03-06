# Envforcer [![Build Status](https://travis-ci.org/mojotech/envforcer.svg?branch=master)](https://travis-ci.org/mojotech/envforcer) [![Gem Version](https://badge.fury.io/rb/envforcer.svg)](https://badge.fury.io/rb/envforcer)

Enforce environment variable requirements.

Storing [configuration in the environment](http://www.12factor.net/config) is one of the tenets of a [twelve-factor app](http://www.12factor.net/). However, problems arise when required environment variables aren't set.

## Usage

Add your required ENV keys to `.envforcer.yml`:

```yaml
- REQUIRED_KEY1
- REQUIRED_KEY2
- REQUIRED_KEY3
```

When the app starts, `envforcer` will check that all the required variables are set, and raise an error if they are not. This will prevent the app from starting.

> Note: Currently only tested with Heroku. Will cause push to be rejected.

## Installation

### Rails

Add this line to your application's Gemfile:

```ruby
gem 'envforcer', require: 'envforcer-rails'
```

And then execute:

    $ bundle

This will add a Railtie to enforce environment variables `after_initialize`.

### Other Frameworks

At the time you wish to enforce the environment variables, add the line:

```ruby
Envforcer.enforce
```

## Contributing
We welcome pull requests. Please make sure tests accompany any PRs.

---

Curated by the good people at MojoTech.

<a href="http://mojotech.com"><img width="140px" src="https://mojotech.github.io/jeet/img/mojotech-logo.svg" title="MojoTech's Hiring"></a> <sup>(psst, [we're hiring](http://www.mojotech.com/jobs))</sup>
