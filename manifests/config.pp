# Configure bird and bird6 instances
class anycast_rip::config (
  Array[Enum['bird', 'bird6']] $instances,
  String $config_dir,
  String $config_file_owner,
  String $config_file_group,
  Array[String] $network_prefixes,
  String $network_interface,
  Optional[String] $auth_password,
)
{

  validate_absolute_path($config_dir)

  $instances.each |$instance| {
    file { "${config_dir}/${instance}.conf":
      content => template("anycast_rip/${instance}.conf.erb"),
      owner   => $config_file_owner,
      group   => $config_file_group,
      mode    => '0640',
    }
  }

}
