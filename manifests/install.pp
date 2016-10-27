# Install the bird package
class anycast_rip::install {

  package { 'bird':
    ensure => installed,
  }

}
