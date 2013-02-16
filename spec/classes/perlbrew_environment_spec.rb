require 'spec_helper'

describe 'perlbrew::environment' do

  it { should include_class('perlbrew::environment') }

  it { should contain_group('perlbrew').with(
      'ensure' => 'present',
      'gid'    => '300'
  )}

  it { should contain_user('perlbrew').with(
      'ensure' => 'present',
      'uid'    => '300',
      'gid'    => 'perlbrew'
  )}

end
