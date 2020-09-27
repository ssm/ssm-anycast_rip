# Configure bird and bird6 instances
# @api private
class anycast_rip::config (
  Array[Enum['bird', 'bird6']] $instances,
  Stdlib::Absolutepath $config_dir,
  String $config_file_owner,
  String $config_file_group,
  Array[Variant[Stdlib::IP::Address::V6::CIDR, Stdlib::IP::Address::V4::CIDR]] $network_prefixes = [],
  String $network_interface,
  Optional[String] $auth_password,
)
{

  $instances.each |$instance| {
    file { "${config_dir}/${instance}.conf":
      content => template("anycast_rip/${instance}.conf.erb"),
      owner   => $config_file_owner,
      group   => $config_file_group,
      mode    => '0640',
    }
  }

}
