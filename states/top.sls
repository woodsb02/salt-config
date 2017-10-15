# vim: tabstop=8 expandtab shiftwidth=2 softtabstop=2

base:
  '*':
    - salt
  'os:FreeBSD':
    - match: grain
    - csh
    - zsh
    - pkgng
    - syslog
    - vim
  '*.woods.am':
    - krb5
  'www.woods.am':
    - nginx
#  'pkgbase':
#    - match: nodegroup
#    - users
#    - pkgbase
  'graphical':
    - match: nodegroup
    - graphical
    - x11
    - xfce
  'interactive':
    - match: nodegroup
    - interactive
#    - ntpd
#    - ssh
#    - tmux
#    - sudo
#  'intel':
#    - match: nodegroup
#    - intel
#  'nvidia':
#    - match: nodegroup
#    - nvidia
#  'elantech':
#    - match: nodegroup
#    - touchpad_elantech
#  'synaptics':
#    - match: nodegroup
#    - touchpad_synaptics
#  'kdc':
#    - match: nodegroup
#    - kdc
