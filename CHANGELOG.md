motd CHANGELOG
=====================

This file is used to list changes made in each version of the motd cookbook.

0.4.0
-----

- Use a chef_handler instead of "knife status" to get the last successful chef run
  This is faster than invoking ruby on each login

0.1.0
-----
- [Chris Aumann] - Initial release of motd
