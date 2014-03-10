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
        c[k].should == $result[k]
        c.get_value(k).should == $result[k]
      end
      
      #Test add support for retrieving value using string and symbol 
      $result.keys.each do |k|
        c[k.to_s].should == $result[k]
        c.get_value(k.to_s).should == $result[k]
      end

    end

  end

  describe "adding configuration values and groups" do
    before :each do
      @parse_config = ParseConfig.new
    end
    it "should add given key and value" do
      @parse_config.add("foo", 1)
      @parse_config.params[:foo].should == 1
    end
    it "should add nested hashes" do
      @parse_config.add("foo", {"bar" => 123})
      @parse_config[:foo][:bar].should == 123
    end
    it "should add values to existing groups" do
      @parse_config.add("foo", {"bar" => 123})
      @parse_config.add_to_group("foo","buzz", 345)
      @parse_config[:foo][:bar].should == 123
      @parse_config[:foo][:buzz].should == 345
      @parse_config[:foo].count == 2
    end
    it "should add nested hash into the group" do
      @parse_config.add("foo", {"bar" => 123})
      @parse_config.add_to_group("foo","buzz", {"fizz" => 345})
      @parse_config[:foo][:bar].should == 123
      @parse_config[:foo][:buzz][:fizz].should == 345
      @parse_config[:foo].count == 2
    end
    it "should create a new group and add value" do
      @parse_config.add_to_group("foo","buzz", {"fizz" => 345})
      @parse_config[:foo][:buzz][:fizz].should == 345
    end
  end

end
