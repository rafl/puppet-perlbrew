class perlbrew::dependencies {
  case $::osfamily {
    debian         : { require perlbrew::dependencies::debian }
    redhat, Linux  : { require perlbrew::dependencies::centos }
    suse           : { require perlbrew::dependencies::suse   }
    default        : { notice("Could not load dependencies for ${::osfamily}") }
  }
}
