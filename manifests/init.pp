# Class: perlbrew
#
#   This class will install a Perl interpreter using perlbrew and will install
#   Perl modules using cpanminus.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class perlbrew {
  include perlbrew::params
  include perlbrew::install
  include perlbrew::environment

  define build ($version) {
    exec {
      # puppet seems to change the current user weirdly when using the
      # user/group options. That causes cpanm to use /root/.cpanm for it's
      # temporary storage, which happens to not be writable for the perlbrew
      # user. Use /bin/su to work this around.
      "install_patchperl_${name}":
        command => "/bin/sh -c 'umask 022; PERLBREW_ROOT=${perlbrew::params::perlbrew_root} ${perlbrew::params::perlbrew_bin} install-patchperl'",
        creates => "${perlbrew::params::perlbrew_root}/bin/patchperl",
        require => Class['perlbrew::environment'],
    }

    exec {
      "perlbrew_build_${name}":
        command => "/bin/sh -c 'umask 022; PERLBREW_ROOT=${perlbrew::params::perlbrew_root} ${perlbrew::params::perlbrew_bin} install ${version} --as ${name} -Accflags=-fPIC -Dcccdlflags=-fPIC'",
        user    => 'perlbrew',
        group   => 'perlbrew',
        timeout => 3600,
        creates => "${perlbrew::params::perlbrew_root}/perls/${name}",
        require => [
          Class['perlbrew::environment'],
          Exec["install_patchperl_${name}"],
        ],
    }
  }

  define install_cpanm () {
    exec {
        # puppet seems to change the current user weirdly when using the
        # user/group options. That causes cpanm to use /root/.cpanm for it's
        # temporary storage, which happens to not be writable for the perlbrew
        # user. Use /bin/su to work this around.
      "install_cpanm_${name}":
        command => "/bin/su - -c 'umask 022; wget --no-check-certificate -O- ${perlbrew::params::cpanm_url} | ${perlbrew::params::perlbrew_root}/perls/${name}/bin/perl - App::cpanminus 2>&1 >/tmp/foo.log' perlbrew",
        creates => "${perlbrew::params::perlbrew_root}/perls/${name}/bin/cpanm",
        require => Perlbrew::Build[$name],
    }
  }

  define install_module ($perl, $force = 0, $sudo = 0) {
    if $force == 1 and $sudo == 1 {
      $flags = "-fS"
    }
    elsif $force == 1 {
      $flags = "-f"
    }
    elsif $sudo == 1 {
      $flags = "-S"
    }
    else {
      $flags = ""
    }

    exec {
      "install_module_${perl}_${name}":
        command => "/bin/su - -c 'umask 022; ${perlbrew::params::perlbrew_root}/perls/${perl}/bin/cpanm ${flags} ${name}' perlbrew >> ${perlbrew::params::perlbrew_root}/cpanm-install.log 2>&1",
        timeout => 1800,
        unless  => "${perlbrew::params::perlbrew_root}/perls/${perl}/bin/perl -m${name} -e1",
        require => Perlbrew::Install_cpanm[$perl],
    }
  }
}
