class perlbrew::install {
  package {
    "build-essential":
      ensure => present,
  }

  file {
    "/usr/local/bin/perlbrew":
      owner   => root,
      group   => root,
      mode    => 0755,
      source  => "puppet:///modules/perlbrew/perlbrew"
      require => Package["build-essential"],
  }
}
