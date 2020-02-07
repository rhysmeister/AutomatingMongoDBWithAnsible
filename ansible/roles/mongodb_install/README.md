mongodb_install
================

Installs MongoDB packages.
------------

Role Variables
--------------

mongodb_packages: List of packages to install.

default: mongodb-org

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: mongodb_install, x: 42 }


Author Information
------------------

Rhys Campbell http://github.com/rhysmeister
