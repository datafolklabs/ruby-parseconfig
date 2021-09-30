lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'parseconfig'
  s.version     = ParseConfig::VERSION
  s.licenses    = ["MIT"]
  s.date        = '2020-09-28'
  s.authors     = ['BJ Dierkes']
  s.email       = 'derks@datafolklabs.com'
  s.summary     = 'Config File Parser for Standard Unix/Linux Type Config Files'
  s.homepage    = 'http://github.com/datafolklabs/ruby-parseconfig/'
  s.description = 'ParseConfig provides simple parsing of standard' \
    "configuration files in the form of 'param = value'. " \
    'It also supports nested [group] sections.'
  s.files = ['README.md',
             'Changelog',
             'LICENSE',
             'doc/',
             'lib/parseconfig.rb',
             'lib/version.rb',
             'tests']
end
