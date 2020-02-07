mongodb_repository
===================

Configures a repository for MongoDB on Debian and RedHat based platforms.

Role Variables
--------------

mongodb_version: The version of MongoDB to install. This forms part of the repository url and should be in the form <major>.<minor> i.e. 4.2


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: mongodb_repository, x: 42 }

Author Information
------------------

Rhys Campbell http://github.com/rhysmeister
