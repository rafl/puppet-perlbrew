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
        timeout => 3600,
        creates => "${perlbrew::params::perlbrew_root}/perls/${name}",
        require => Class["perlbrew::environment"],
    }
  }

  define install_cpanm () {
    exec {
      "install_cpanm_${name}":
        # puppet seems to change the current user weirdly when using the
        # user/group options. That causes cpanm to use /root/.cpanm for it's
        # temporary storage, which happens to not be writable for the perlbrew
        # user. Use /bin/su to work this around.
        command => "/bin/su - -c 'umask 022; wget -O- ${perlbrew::params::cpanm_url} | ${perlbrew::params::perlbrew_root}/perls/${name}/bin/perl - App::cpanminus' perlbrew",
        creates => "${perlbrew::params::perlbrew_root}/perls/${name}/bin/cpanm",
        require => Perlbrew::Build[$name],
    }
  }
}
