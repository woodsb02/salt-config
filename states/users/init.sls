woodsb02:
  user.present:
    - fullname: Ben Woods
    - shell: /usr/local/bin/zsh
    - home: /home/woodsb02
    - uid: 1001
    - gid: 1001
    - loginclass: staff
    - optional_groups:
      - wheel
      - operator
      - staff
      - dialer
      - video

kassia:
  user.present:
    - fullname: Kassia Tomlins
    - shell: /usr/local/bin/zsh
    - home: /home/kassia
    - uid: 1002
    - gid: 1002
    - loginclass: staff
    - optional_groups:
      - operator
      - staff
      - video

test:
  user.absent

testuser:
  user.absent

guest:
  user.absent
