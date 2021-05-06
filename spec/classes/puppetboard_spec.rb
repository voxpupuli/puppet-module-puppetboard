require 'spec_helper'

describe 'puppetboard', type: :class do
  on_supported_os.each do |os, facts|
    let :facts do
      facts
    end

    context "on #{os}" do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('puppetboard') }
      it { is_expected.to contain_group('puppetboard') }
      it { is_expected.to contain_user('puppetboard') }
      if ['FreeBSD'].include?(facts[:os]['family'])
        it { is_expected.to contain_package('py38-puppetboard') }
      else
        it { is_expected.to contain_file('/srv/puppetboard/puppetboard/settings.py') }
        it { is_expected.to contain_file('/srv/puppetboard/puppetboard') }
        it { is_expected.to contain_file('/srv/puppetboard') }
        it { is_expected.to contain_python__pyvenv('/srv/puppetboard/virtenv-puppetboard') }
        it { is_expected.to contain_vcsrepo('/srv/puppetboard/puppetboard') }
      end
    end
  end
end
