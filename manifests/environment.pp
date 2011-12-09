class perlbrew::environment {
  group {
    "perlbrew":
      ensure => present,
      gid    => 300,
  }

  user {
    "perlbrew":
      ensure   => present,
      home     => $perlbrew::params::perlbrew_root,
      uid      => 300,
      gid      => "perlbrew",
  }

  file {
    $perlbrew::params::perlbrew_root:
      ensure  => directory,
      mode    => 0755,
      owner   => perlbrew,
      group   => perlbrew,
      require => [ Group["perlbrew"], User["perlbrew"] ],
  }
}
