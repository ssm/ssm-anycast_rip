# frozen_string_literal: true

require 'spec_helper'

describe 'anycast_rip::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          config_dir: '/test',
          config_file_owner: 'root',
          config_file_group: 'bird',
          network_interface: 'test0',
          auth_password: 'test secret',
          instances: ['bird', 'bird6'],
          network_prefixes: [
            '192.0.2.192/25',
            '2001:db8:1::/64',
          ],
        }
      end

      context 'bird v1' do
        let(:params) do
          super().merge(bird_major_version: 'v1')
        end

        it { is_expected.to compile }

        it {
          is_expected.to contain_file('/test/bird.conf')
            .with_content(%r{192\.0\.2\.192/25})
            .without_content(%r{2001:db8:1::/64})
            .with_content(%r{interface "test0"})
            .with_content(%r{password "test secret";})
        }
        it {
          is_expected.to contain_file('/test/bird6.conf')
            .with_content(%r{2001:db8:1::/64})
            .without_content(%r{192\.0\.2\.192/25})
            .with_content(%r{interface "test0"})
            .with_content(%r{password "test secret";})
        }
      end

      context 'bird v2' do
        let(:params) do
          super().merge(bird_major_version: 'v2')
        end

        it { is_expected.to compile }

        it {
          is_expected.to contain_file('/test/bird.conf')
            .with_content(%r{192\.0\.2\.192/25\+})
            .without_content(%r{2001:db8:1::/64\+})
            .with_content(%r{interface "test0";})
            .with_content(%r{password "test secret";})
        }
        it {
          is_expected.to contain_file('/test/bird6.conf')
            .with_content(%r{2001:db8:1::/64\+})
            .without_content(%r{192\.0\.2\.192/25\+})
            .with_content(%r{interface "test0";})
            .with_content(%r{password "test secret";})
        }
      end
    end
  end
end
