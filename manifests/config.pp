# Configure bird and bird6 instances
# @api private
class anycast_rip::config (
  Stdlib::Absolutepath $config_dir,
  String $config_file_owner,
  String $config_file_group,
  String $network_interface,
  Optional[String] $auth_password,
  Array[Enum['bird', 'bird6']] $instances,
  Array[Variant[Stdlib::IP::Address::V6::CIDR, Stdlib::IP::Address::V4::CIDR]] $network_prefixes = [],
  Stdlib::IP::Address::V4::Nosubnet $router_id,
) {

  $instances.each |$instance| {
    $template_parameters = {
      auth_password     => $auth_password,
      router_id         => $router_id,
      network_interface => $network_interface,
      network_prefixes  => $instance ? {
        'bird'  => $network_prefixes.filter |$net| { $net =~ Stdlib::IP::Address::V4 },
        'bird6' => $network_prefixes.filter |$net| { $net =~ Stdlib::IP::Address::V6 },
      }
    }
    file { "${config_dir}/${instance}.conf":
      content => epp("anycast_rip/${instance}.conf.epp", $template_parameters),
      owner   => $config_file_owner,
      group   => $config_file_group,
      mode    => '0640',
    }
  }
}
