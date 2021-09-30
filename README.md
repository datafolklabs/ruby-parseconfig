# Ruby ParseConfig Library

ParseConfig provides simple parsing of standard configuration files in the
form of `param = value`.  It also supports nested `[group]` sections.

[![Continuous Integration Status](https://app.travis-ci.com/datafolklabs/ruby-parseconfig.svg?branch=master)](https://app.travis-ci.com/github/datafolklabs/ruby-parseconfig)

## Installation

```
$ gem install parseconfig
```

Gemfile

```
gem 'parseconfig'
```

## Usage

An example configuration file might look like:

```
# Example Config
param1 = value1
param2 = value2

[group1]
group1_param1 = group1_value1
group1_param2 = group1_value2

[group2]
group2_param1 = group2_value1
group2_param2 = group2_value2
```

Access it with ParseConfig:

```ruby
>> require 'parseconfig'
=> true

>> config = ParseConfig.new('/path/to/config/example.conf')
=> #<ParseConfig:0x102410908
      @config_file="example.conf",
      @groups=["group1", "group2"],
      @params={
            "param1"=>"value1"
            "param2"=>"value2",
            "group1"=>{
                "param1"=>"value1"
                "param2"=>"value2",
            },
            "group2"=>{
                "param1"=>"value1"
                "param2"=>"value2",
            },
    }>

>> config.get_params
=> ["param1", "param2", "group1", "group2"]

>> config['param1']
=> "value1"

>> config.get_groups
=> ["group1", "group2"]

>> config['group1']
=> {"group1_param1"=>"group1_value1", "group1_param2"=>"group1_value2"}

>> config['group1']['group1_param1']
=> "group1_value1"

>> file = File.open('/path/to/config/file', 'w')
=> #<File:file>

>> config.write(file)
=> []

>> file.close
=> nil

```

## Development

### Docker

This project includes a `docker-compose` configuration that sets up all required services, and dependencies for development and testing.  This is the recommended path for local development, and is the only fully supported option.

The following creates all required docker containers, and launches a BASH shell within the `parseconfig` dev container for development.
```
$ make dev

|> parseconfig <| src #
```

The above is the equivalent of running:

```
$ docker-compose up -d

$ docker-compose exec parseconfig /bin/bash
```

**Testing Alternative Versions of Ruby**

The latest stable version of Ruby is the default, and target version accessible as the `parseconfig` container within Docker Compose.  For testing against alternative versions of Ruby, additional containers are created (ex: `parseconfig-rb26`, `parseconfig-rb27`, etc). You can access these containers via:

```
$ docker-compose ps
               Name                    Command    State   Ports
---------------------------------------------------------------
ruby-parseconfig_parseconfig-rb26_1   /bin/bash   Up
ruby-parseconfig_parseconfig-rb27_1   /bin/bash   Up
ruby-parseconfig_parseconfig-rb30_1   /bin/bash   Up
ruby-parseconfig_parseconfig_1        /bin/bash   Up


$ docker-compose exec parseconfig-rb26 /bin/bash

|> parseconfig-rb26 <| src #
```

### Running Unit Tests

```
$ make test
```


## License

The ParseConfig library is Open Source and distributed under the MIT license.
Please see the LICENSE file included with this software.


