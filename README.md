# anycast_rip

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with anycast_rip](#setup)
    * [What anycast_rip affects](#what-anycast_rip-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with anycast_rip](#beginning-with-anycast_rip)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module configures bird and bird6 for announcing anycast service
addresses using the RIP routing protocol.

## Setup

### What anycast_rip affects

This module configures geographically redundant service IP addresses
within a multi-datacenter network. Clients will be routed to the
closest data center announcing the service.

The software used is `bird`. The configuration will announce IPV6 and
IPv4 service addresses to be picked up by the closest router, and
distributed within the network by another routing protocol (`OSPF` in
this document, but other routing protocols will work).

This is typically combined on each host with `keepalived` using
service health checks for only announcing services in working order.

And it uses RIP to do it. Deal with it. :-)

### Setup Requirements

* Establish a set of data centers for hosting services, with a routing
  protocol between data centers. For this example, "OSPF", but other
  routing protocols will also work.

### Beginning with anycast_rip

* Choose network prefixes for anycast service IP addresses.
* Announce the prefixes locally on all datacenters.
* Configure routers to allow servers to announce service IP addresses
  with RIP within these prefixes.
* Permit the RIP received routes to be announced as OSPF routes.
* Inspect the OSPF routes to see the CIDR ranges from each site.
* Include this module, configure network prefixes and interface.
* When a service is up, see the service IP being present in the RIP
  table on the host and the OSPF tables on routers from multiple
  sites. Clients will pick the closest instance.

## Usage

Basic usage of the module: This will install the daemons and
configuration, but will not announce any addresses:

```puppet
include anycast_rip
```

Advanced example: Restrict to IPv6 only (IPv4 is obsolete and long
gone by now, right?), announce to an external network interface, and
add network prefixes for filtering service addresses to announce.

Any local IP addresses within this prefix will be announced. Please
use a separate network prefix from your interface link-local routes.

```puppet
class { 'anycast_rip':
  instances         => ['bird6'],
  network_interface => 'team0',
  network_prefixes  => ['2001:db8::/64'],
}
```

## Limitations

This module only configures RIP version 2, no other routing protocols.  It
works with bird version 1.6, but not with bird 2.0 and newer.

## Development

In the Development section, tell other users the ground rules for contributing
to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel are
necessary or important to include here. Please use the `##` header.

[1]: https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
[2]: https://puppet.com/docs/puppet/latest/puppet_strings.html
[3]: https://puppet.com/docs/puppet/latest/puppet_strings_style.html
