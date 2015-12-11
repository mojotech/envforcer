![Build status](https://travis-ci.org/mojotech/env-enforcer.svg)

# Envforcer

Enforce environment variable requirements.

Storing [configuration in the environment](http://www.12factor.net/config) is one of the tenets of a [twelve-factor app](http://www.12factor.net/). However, problems arise when required environment variables aren't set.

## Installation

### Rails

Add this line to your application's Gemfile:

```ruby
gem 'envforcer'
```

And then execute:

    $ bundle

## Usage

Add your required ENV keys to `.envforcer.yml`:

```shell
default:
- REQUIRED_KEY
development:
- DEVELOPMENT_KEY
production:
- PRODUCTION_KEY
test:
- TEST_KEY
```

When the app starts, `envforcer` will check that all the required environment variables for the current Rails environment are set, and raise an error if they are not.

## Contributing
We welcome pull requests. Please make sure tests accompany any PRs.

---

Curated by the good people at MojoTech.

<a href="http://mojotech.com"><img width="140px" src="https://mojotech.github.io/jeet/img/mojotech-logo.svg" title="MojoTech's Hiring"></a> <sup>(psst, [we're hiring](http://www.mojotech.com/jobs))</sup>
