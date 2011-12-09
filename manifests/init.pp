class perlbrew {
  include perlbrew::params
  include perlbrew::install
  include perlbrew::environment

  define build ($version) {
    exec {
      "perlbrew_build_${name}":
        command => "/bin/sh -c 'umask 022; /usr/bin/env PERLBREW_ROOT=${perlbrew::params::perlbrew_root} ${perlbrew::params::perlbrew_bin} install ${version} --as ${name}'",
        user    => "perlbrew",
        group   => "perlbrew",
        creates => "${perlbrew::params::perlbrew_root}/perls/${name}",
        require => Class["perlbrew::environment"],
    }
  }
}
