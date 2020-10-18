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
  Stdlib::IP::Address::V4::Nosubnet $router_id = $facts['networking']['ip'],
  Enum['v1','v2'] $bird_major_version = 'v2',
)
{

  File {
    owner => $config_file_owner,
    group => $config_file_group,
    mode  => '0640',
  }

  if 'bird' in $instances {
    $service_networks_ipv4 = $network_prefixes.filter |$prefix| {
      $prefix =~ Stdlib::IP::Address::V4::CIDR
    }
    $template_params_ipv4 = {
      router_id        => $router_id,
      rip_interface    => $network_interface,
      service_networks => $service_networks_ipv4,
      auth_password    => $auth_password,
    }
    file { "${config_dir}/bird.conf":
      content  => epp("anycast_rip/${bird_major_version}/bird.conf.epp",
                      $template_params_ipv4),
    }
  }

  if 'bird6' in $instances {
    $service_networks_ipv6 = $network_prefixes.filter |$prefix| {
      $prefix =~ Stdlib::IP::Address::V6::CIDR
    }
    $template_params_ipv6 = {
      router_id        => $router_id,
      rip_interface    => $network_interface,
      service_networks => $service_networks_ipv6,
      auth_password    => $auth_password,
    }
    file { "${config_dir}/bird6.conf":
      content  => epp("anycast_rip/${bird_major_version}/bird6.conf.epp",
                      $template_params_ipv6),
    }
  }
}
