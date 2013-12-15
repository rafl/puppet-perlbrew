# Class: perlbrew::environment
#
#   This class will setup a basic perlbrew environment
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew::environment {

  group {
    'perlbrew':
      ensure => present,
      gid    => $perlbrew::params::perlbrew_gid,
      system => true,
  }

  user {
    'perlbrew':
      ensure => present,
      home   => $perlbrew::params::perlbrew_root,
      uid    => $perlbrew::params::perlbrew_uid,
      gid    => 'perlbrew',
      system => true,
  }

  file {
    $perlbrew::params::perlbrew_root:
      ensure  => directory,
      mode    => '0755',
      owner   => perlbrew,
      group   => perlbrew,
      require => [ Group['perlbrew'], User['perlbrew'] ],
  }

  exec {
    'perlbrew_init':
      command => "/bin/sh -c 'umask 022; /usr/bin/env PERLBREW_ROOT=${perlbrew::params::perlbrew_root} ${perlbrew::params::perlbrew_bin} init'",
      creates => "${perlbrew::params::perlbrew_root}/perls",
      user    => 'perlbrew',
      group   => 'perlbrew',
      require => [
        Group['perlbrew'], User['perlbrew'],
        File[$perlbrew::params::perlbrew_bin],
      ],
  }
}
