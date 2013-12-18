Ruby ParseConfig Library
========================

ParseConfig provides simple parsing of standard configuration files in the
form of 'param = value'.  It also supports nested [group] sections.

[![Continuous Integration Status](https://secure.travis-ci.org/datafolklabs/ruby-parseconfig.png)](http://travis-ci.org/datafolklabs/ruby-parseconfig)

Installation
------------

    $ sudo gem install parseconfig

Usage
-----

An example configuration file might look like:

    # Example Config
    param1 = value1
    param2 = value2

    [group1]
    group1_param1 = group1_value1
    group1_param2 = group1_value2

    [group2]
    group2_param1 = group2_value1
    group2_param2 = group2_value2


Access it with ParseConfig:

    >> require('parseconfig.rb')
    => true

    >> config = ParseConfig.new('/path/to/config/file')
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
                }
            >

    >> config.get_params()
    => ["param1", "param2", "group1", "group2"]

    >> config['param1']
    => "value1"

    >> config.get_groups()
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


License
-------

The ParseConfig library is Open Source and distributed under the MIT license.
Please see the LICENSE file included with this software.
