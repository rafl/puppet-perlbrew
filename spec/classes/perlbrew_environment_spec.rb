require 'spec_helper'

describe 'perlbrew::environment' do

  it { should include_class('perlbrew::environment') }

  it { should contain_group('perlbrew').with(
      'ensure' => 'present',
      'gid'    => nil,
      'system' => true
  )}

  it { should contain_user('perlbrew').with(
      'ensure' => 'present',
      'uid'    => nil,
      'gid'    => 'perlbrew',
      'system' => true
  )}

end
