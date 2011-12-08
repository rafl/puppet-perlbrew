class perlbrew::install {
  file {
    "/usr/local/bin/perlbrew":
      owner  => root,
      group  => root,
      mode   => 0755,
      source => "puppet:///modules/perlbrew/perlbrew"
  }
}
