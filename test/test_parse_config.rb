require 'rspec'
require '../lib/parseconfig.rb'

describe 'ruby-parseconfig' do
  
  Dir['./files/*.conf'].each do |config_file|

    it "should parse #{File.basename(config_file)} properly" do
      require "./files/#{File.basename(config_file, '.conf')}.rb"

      c = ParseConfig.new(config_file)

      # Test overall structure
      c.params.should == $result

      # Test individual accessors
      c.groups.sort.should == $result.keys.select{|k| $result[k].is_a? Hash}.sort
      c.config_file.should == config_file

      $result.keys.each do |k|
        c.get_value(k).should == $result[k]
      end

    end

  end

end
