# frozen_string_literal: true

require 'spec_helper'

bird_conf_dir = {}
bird_conf_dir.default = '/etc/bird'
bird_conf_dir['Debian'] = '/etc/bird'
bird_conf_dir['RedHat'] = '/etc'

describe 'anycast_rip' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:conf_dir) { bird_conf_dir[os_facts[:os]['family']] }

      context 'with default values for all parameters' do
        it { is_expected.to compile }
        it { is_expected.to contain_class('anycast_rip') }
        it { is_expected.to contain_service('bird') }
        it { is_expected.to contain_service('bird6') }
        it { is_expected.to contain_file("#{conf_dir}/bird.conf") }
        it { is_expected.to contain_file("#{conf_dir}/bird6.conf") }
      end

      context 'only IPv6' do
        let(:params) { { instances: ['bird6'] } }

        it { is_expected.to compile }
        it { is_expected.to contain_class('anycast_rip') }
        it { is_expected.not_to contain_service('bird') }
        it { is_expected.to contain_service('bird6') }
        it { is_expected.not_to contain_file("#{conf_dir}/bird.conf") }
        it { is_expected.to contain_file("#{conf_dir}/bird6.conf") }
      end
    end
  end
end
