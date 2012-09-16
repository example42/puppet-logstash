require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'logstash::config' do

  let(:title) { 'logstash::config' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :arch => 'i386' , :operatingsystem => 'redhat' } }
  
  let(:params) {
    { 'ensure'       =>  'present',
      'name'         =>  'local_search',
      'source'       =>  'puppet:///logstash/config/local_search.erb',
    }
  }

  describe 'Test logstash::config populated with source file' do
    it 'should create a logstash::config file' do
      should contain_file('logstash.conf_local_search').with_ensure('present')
    end
    it 'should populate correctly logstash::config file with a given source' do
      content = catalogue.resource('file', 'logstash.conf_local_search').send(:parameters)[:source]
      content.should match "puppet:///logstash/config/local_search"
    end
  end

end

