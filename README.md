Ruby ParseConfig Library
========================

ParseConfig provides simple parsing of standard configuration files in the 
form of 'param = value'.  It also supports nested [group] sections.

Installation
------------

    $ sudo gem install parseconfig

Usage
-----

    >> require('parseconfig.rb')
    => true
    
    >> config = ParseConfig.new('/path/to/config/file')
    => #<ParseConfig:0x102410908 @config_file="utils/examples/demo.conf", @groups=["group1", "group2"], @params={"group2"=>{"group2_param2"=>"group2_value2", "group2_param1"=>"group2_value1"}, "group1"=>{"group1_param2"=>"group1_value2", "group1_param1"=>"group1_value1"}, "param2"=>"value2", "param1"=>"value1"}>
    
    >> config.get_params()
    => ["group2", "group1", "param2", "param1"]

    >> config.get_groups()
    => ["group1", "group2"]
    
    >> config['group1']
    => {"group1_param2"=>"group1_value2", "group1_param1"=>"group1_value1"}

    >> config['param1']
    => "value1"

    >> config['group1']['group1_param1']
    => "group1_value1"


License
-------

The ParseConfig library is Open Source and distributed under the MIT license.
Please see the LICENSE file included with this software.
