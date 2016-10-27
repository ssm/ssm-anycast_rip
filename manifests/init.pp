# Class 'anycast_rip'
#
# Configure bird and bird6 for anycast with rip
#
# This class can be used to announce the availability of service IP
# addresses on the host to the next router, using the RIP routing
# protocol.  Whenever an IP address exists on the host, and it matches
# one of the configured network prefixes, it is announced by the RIP
# daemon.
#
# @example Declaring the class
#   include anycast_rip
#
# @example Actually doing something useful
#   class { 'anycast_rip':
#     network_interface => 'team0',
#     network_prefixes  => ['192.0.2.0/24', '2001:db8::/64'],
#   }
#
# @param instances The bird instances to control
#
# @param config_dir The path to the configuration directory
#
# @param config_file_owner The owner of the configuration files
#
# @param config_file_group The group ownership of the configuration files
#
# @param network_prefixes A list of IPv4 and IPv6 network prefixes
#        used to filter IP addresses to announce.
#
# @param network_interface The network interface to announce prefixes to
#
# @param auth_password An optional password for authenticating with the next hop
#
class anycast_rip (
  Array[Enum['bird', 'bird6']] $instances = ['bird', 'bird6'],
  String $config_dir = '/etc/bird',
  String $config_file_owner = 'root',
  String $config_file_group = 'bird',
  Array[String] $network_prefixes = [],
  String $network_interface = 'lo',
  Optional[String] $auth_password = undef,
)
{

  validate_absolute_path($config_dir)

  include anycast_rip::install

  class { '::anycast_rip::config':
    instances         => $instances,
    config_dir        => $config_dir,
    config_file_owner => $config_file_owner,
    config_file_group => $config_file_group,
    network_prefixes  => $network_prefixes,
    network_interface => $network_interface,
    auth_password     => $auth_password,
  }

  class { '::anycast_rip::service':
    instances => $instances,
  }

  Class['anycast_rip::install'] -> Class['anycast_rip::config']
  Class['anycast_rip::config'] ~> Class['anycast_rip::service']

}
