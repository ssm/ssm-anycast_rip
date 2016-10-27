require 'spec_helper'
describe 'bird' do
  context 'with default values for all parameters' do
    it { should contain_class('bird') }
  end
end
