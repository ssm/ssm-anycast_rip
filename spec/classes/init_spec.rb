require 'spec_helper'
describe 'anycast_rip' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('anycast_rip') }
        it { is_expected.to contain_service('bird') }
        it { is_expected.to contain_service('bird6') }
        it { is_expected.to contain_file('/etc/bird/bird.conf') }
        it { is_expected.to contain_file('/etc/bird/bird6.conf') }
      end

      context 'only IPv6' do
        let(:params) { { instances: ['bird6'] } }
        it { is_expected.to contain_class('anycast_rip') }
        it { is_expected.not_to contain_service('bird') }
        it { is_expected.to contain_service('bird6') }
        it { is_expected.not_to contain_file('/etc/bird/bird.conf') }
        it { is_expected.to contain_file('/etc/bird/bird6.conf') }
      end
    end
  end
end
