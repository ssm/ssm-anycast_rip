# Install the bird package
# @api private
class anycast_rip::install {
  package { 'bird':
    ensure => installed,
  }
}
