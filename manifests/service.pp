# Manage the bird services.
# @api private
class anycast_rip::service (
  Array[String] $instances
)
{

  $instances.each |$instance| {
    service { $instance:
      ensure => running,
      enable => true,
    }
  }

}
