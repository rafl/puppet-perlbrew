# Class: perlbrew::install
#
#   This class will install the perlbrew script itself and uses the package
#   manager of the operating system to install the required compiler
#   toolchain. The compiler toolchain is required to compile the Perl
#   interpreter later.
#
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew::install {

  if ! defined( Class['perlbrew::dependencies'] ) {
    require perlbrew::dependencies
  }

  if !defined (Package['wget'])
  { package
    { 'wget':ensure => present, }
  }

  file {
    $perlbrew::params::perlbrew_bin:
      owner   => root,
      group   => root,
      mode    => '0755',
      source  => "puppet:///modules/${module_name}/perlbrew",
      require => [ Class['perlbrew::dependencies'], Package['wget'] ],
  }
}
