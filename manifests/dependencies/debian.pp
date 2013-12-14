class perlbrew::dependencies::debian {
  if ! defined(Package['build-essential']) { package { 'build-essential':  ensure => installed } }
}
