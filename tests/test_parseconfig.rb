require 'rspec'
require '../lib/parseconfig.rb'

describe 'ruby-parseconfig' do
  
  it "should parse empty config file" do
    parse_config = ParseConfig.new("files/#{File.basename('empty.conf')}")
    parse_config.params.should == {}
    parse_config.groups.should == []
  end

  it "should parse the values" do
    parse_config = ParseConfig.new("files/#{File.basename('values.conf')}")
    parse_config[:foo].should == "bar"
    parse_config[:baz].should == "quux"
    parse_config[:"123"].should == "456"
  end

  it "should return the same values" do
    parse_config = ParseConfig.new("files/#{File.basename('values.conf')}")
    parse_config.get_value(:foo).should == parse_config[:foo]
    parse_config.get_value(:baz).should == parse_config[:baz]
    parse_config.get_value(:"123").should == parse_config[:"123"]
  end

  it "should parse the groups" do
    parse_config = ParseConfig.new("files/#{File.basename('groups.conf')}")
    parse_config.params[:group1][:foo].should == "bar"
    parse_config.params[:group2][:baz].should == "quux"
    parse_config.groups.count == 2
    parse_config.groups.include?(:group1).should == true
    parse_config.groups.include?(:group2).should == true
  end

  it "should return the correct hash" do
    parse_config = ParseConfig.new("files/#{File.basename('groups.conf')}")
    parse_config.params[:group1].should == parse_config.get_value(:group1)
    parse_config.params[:group2].should == parse_config.get_value(:group2)
  end

  it "should parse configuration files with groups" do
    parse_config = ParseConfig.new("files/#{File.basename('demo.conf')}")
    parse_config.params[:admin_email].should == "root@localhost"
    parse_config.params[:listen_ip].should == "127.0.0.1"
    parse_config.params[:listen_port].should == "87345"
    parse_config.params[:group1][:user_name].should == "johnny"
    parse_config.params[:group1][:group_name].should == "daemons"
    parse_config.params[:group2][:user_name].should == "rita"
    parse_config.params[:group2][:group_name].should == "daemons"
    parse_config.groups.count.should == 2
    parse_config.groups.include?(:group1).should == true
    parse_config.groups.include?(:group2).should == true
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
