# NAME

  *puppet-perlbrew*

  This puppet module features the tool perlbrew. Perlbrew can be used to install
  different Perl versions on your OS.

# SYNOPSIS

```puppet
class { "perlbrew": }
perlbrew::build { "5.8.9":
  version => "5.8.9",
}
perlbrew::install_cpanm { "5.8.9": }
perlbrew::install_module { "Log::Log4perl": perl => "5.8.9" }
```

# LICENSE

  This module is licensed under The Artistic License 2.0 which is included in
  this package. Perlbrew is licensed under the MIT license.
