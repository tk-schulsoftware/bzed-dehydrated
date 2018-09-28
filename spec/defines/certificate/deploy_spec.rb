require 'spec_helper'

describe 'dehydrated::certificate::deploy' do
  let(:title) { 'namevar' }
  let(:params) do
    { 'dn' => 'test.example.com' }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :pre_condition do
        if os =~ %r{windows.*}
          'class { "dehydrated" : dehydrated_host => "some.other.host.example.com" }'
        else
          'class { "dehydrated" : dehydrated_host => $facts["fqdn"] }'
        end
      end

      it { is_expected.to compile }
    end
  end
end
