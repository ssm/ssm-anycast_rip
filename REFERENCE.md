# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`anycast_rip`](#anycast_rip): Class 'anycast_rip'  Configure bird and bird6 for anycast with rip  This class can be used to announce the availability of service IP address

#### Private Classes

* `anycast_rip::config`: Configure bird and bird6 instances
* `anycast_rip::install`: Install the bird package
* `anycast_rip::service`: Manage the bird services.

## Classes

### <a name="anycast_rip"></a>`anycast_rip`

Class 'anycast_rip'

Configure bird and bird6 for anycast with rip

This class can be used to announce the availability of service IP
addresses on the host to the next router, using the RIP routing
protocol.  Whenever an IP address exists on the host, and it matches
one of the configured network prefixes, it is announced by the RIP
daemon.

#### Examples

##### Declaring the class

```puppet
include anycast_rip
```

##### Actually doing something useful

```puppet
class { 'anycast_rip':
  network_interface => 'team0',
  network_prefixes  => ['192.0.2.0/24', '2001:db8::/64'],
}
```

#### Parameters

The following parameters are available in the `anycast_rip` class:

* [`instances`](#instances)
* [`config_dir`](#config_dir)
* [`config_file_owner`](#config_file_owner)
* [`config_file_group`](#config_file_group)
* [`network_prefixes`](#network_prefixes)
* [`network_interface`](#network_interface)
* [`auth_password`](#auth_password)
* [`router_id`](#router_id)

##### <a name="instances"></a>`instances`

Data type: `Array[Enum['bird', 'bird6']]`

The bird instances to control

Default value: `['bird', 'bird6']`

##### <a name="config_dir"></a>`config_dir`

Data type: `Stdlib::Absolutepath`

The path to the configuration directory

Default value: `'/etc/bird'`

##### <a name="config_file_owner"></a>`config_file_owner`

Data type: `String`

The owner of the configuration files

Default value: `'root'`

##### <a name="config_file_group"></a>`config_file_group`

Data type: `String`

The group ownership of the configuration files

Default value: `'bird'`

##### <a name="network_prefixes"></a>`network_prefixes`

Data type: `Array[Variant[Stdlib::IP::Address::V6::CIDR, Stdlib::IP::Address::V4::CIDR]]`

A list of IPv4 and IPv6 network prefixes
used to filter IP addresses to announce.

Default value: `[]`

##### <a name="network_interface"></a>`network_interface`

Data type: `String`

The network interface to announce prefixes to

Default value: `'lo'`

##### <a name="auth_password"></a>`auth_password`

Data type: `Optional[String]`

An optional password for authenticating with the next hop

Default value: ``undef``

##### <a name="router_id"></a>`router_id`

Data type: `Stdlib::IP::Address::V4::Nosubnet`



Default value: `$facts['networking']['ip']`

