anycast\_rip
=============

Table of Contents
^^^^^^^^^^^^^^^^^

1. `Description <#description>`__
2. `Setup - The basics of getting started with bird <#setup>`__

   -  `Beginning with bird <#beginning-with-bird>`__

3. `Usage - Configuration options and additional
   functionality <#usage>`__
4. `Reference - An under-the-hood peek at what the module is doing and
   how <#reference>`__
5. `Limitations - OS compatibility, etc. <#limitations>`__
6. `Development - Guide for contributing to the module <#development>`__

Description
-----------

This module configures bird and bird6 for announcing anycast service
addresses using the RIP routing protocol.

Setup
-----

Beginning with anycast\_rip
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configure your router for receiving routes from the network using RIP.

Usage
-----

Basic usage of the module: Will install the daemons and configuration,
but will not provide any meaningful service:

.. code-block:: puppet

   include anycast_rip

Recommended usage: Restrict to IPv6 only (IPv4 is obsolete, right?),
announce to an external interface, and add network prefixes for
filtering service addresses to announce.

.. code-block:: puppet

   class { 'anycast_rip':
     instances         => ['bird6'],
     network_interface => 'team0',
     network_prefixes  => ['2001:db8::/64'],
   }

Reference
---------

The only public class is "anycast\_rip". It takes a number of
parameters:

- instances An array with one or more of 'bird', 'bird6'. By default,
  both are configured.

- network_prefixes An array of IPv6 and IPv4 prefixes used to filter
  addresses to announce.

- network_interface The network interface to announce routes via.

- config\_dir The path to the configuration directory

- config\_file\_owner The owner of the configuration files

- config\_file\_group The group ownership of the configuration files

- auth\_password An optional password for authenticating with the next
  hop.

Limitations
-----------

This module only configures RIP, no other routing protocols.
