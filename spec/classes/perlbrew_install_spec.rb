require 'spec_helper'

describe 'perlbrew::install' do

  it { should include_class('perlbrew::install') }

  it { should contain_package('build-essential').with(
    'ensure' => 'present'
  )}

  it { should contain_package('wget').with(
    'ensure' => 'present'
  )}

end
