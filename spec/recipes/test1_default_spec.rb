require 'chefspec'
require 'chefspec/berkshelf'
require 'chef-vault/test_fixtures'

def parse_data_bag(path)
  data_bags_path = File.expand_path(
    File.join(File.dirname(__FILE__), '../../test/integration/data_bags')
  )
  JSON.parse(File.read("#{data_bags_path}/#{path}"))
end

RSpec.describe 'test1::default' do
  include ChefVault::TestFixtures.rspec_shared_context

  let(:chef_run) do
    ChefSpec::ServerRunner.new do |_, server|
      server.create_data_bag(
        'baz', 'wibble' => parse_data_bag('baz/wibble.json')
      )
    end.converge(described_recipe)
  end

  it 'should converge' do
    expect(chef_run).to include_recipe(described_recipe)
  end
end
