class perlbrew::environment {
  group {
    "perlbrew":
      ensure => present,
      gid    => 300,
  }

  user {
    "perlbrew":
      ensure   => present,
      home     => "/usr/local/perls",
      uid      => 300,
      gid      => "perlbrew",
  }

  file {
    "/usr/local/perls":
      ensure  => directory,
      mode    => 0755,
      owner   => perlbrew,
      group   => perlbrew,
      require => [ Group["perlbrew"], User["perlbrew"] ],
  }
}
