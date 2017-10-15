sudo mount smash.woods.am:/usr/src /usr/src && sudo mount smash.woods.am:/usr/obj /usr/obj
cd /usr/src
# sudo etcupdate extract # First time only
BENAME=rXXXXXXX && sudo beadm create $BENAME && sudo beadm mount $BENAME /tmp/newbe && sudo beadm list
#sudo etcupdate -p -D /tmp/newbe
#sudo make -s installworld installkernel DESTDIR=/tmp/newbe
sudo pkg -c /tmp/newbe upgrade -r FreeBSD-base
diff <(sudo pkg -c /tmp/newbe rquery -r FreeBSD-base %n) <(sudo pkg -c /tmp/newbe query -e '%o = base' %n) | grep -v lib32 | grep "^[<>]"
sudo pkg -c /tmp/newbe install -r FreeBSD-base XXX
sudo etcupdate -D /tmp/newbe && sudo make -DBATCH_DELETE_OLD_FILES delete-old DESTDIR=/tmp/newbe
sudo make -DBATCH_DELETE_OLD_FILES delete-old-libs DESTDIR=/tmp/newbe
cd ~ && sudo umount /usr/src /usr/obj
sudo pkg -c /tmp/newbe clean -ay
sudo pkg -c /tmp/newbe upgrade -r FreeBSD-ports -f
sudo beadm umount $BENAME && sudo beadm activate $BENAME && sudo beadm list
#reboot
