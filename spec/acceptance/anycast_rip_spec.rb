require 'spec_helper_acceptance'

pp_default = <<-PUPPETCODE
  include anycast_rip
PUPPETCODE


describe 'Anycast RIP' do
  context 'defaults' do
    it do
      idempotent_apply(pp_default)
    end
  end
end
