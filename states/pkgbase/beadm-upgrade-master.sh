cd /usr/src
# sudo etcupdate extract # First time only
svn up
sudo umount /usr/obj/usr/src/repo; rm -rf /usr/obj/usr
mkdir -p /usr/obj/usr/src/repo && sudo mount /usr/obj/usr/src/repo && script /usr/obj/usr/src/BUILDOUTPUT
make -C sys cscope && time make -j12 buildworld buildkernel && time make -j12 packages
sudo umount /usr/obj/usr/src/repo
BENAME=r$(svn info | grep Revision | sed -e 's/Revision\:\ \(.*\)$/\1/g') && sudo zfs snapshot -r zroot/usr/src@$BENAME zroot/usr/obj@$BENAME && sudo beadm create $BENAME && sudo beadm mount $BENAME /tmp/newbe && sudo beadm list
#sudo etcupdate -p -D /tmp/newbe
#sudo make -s installworld installkernel DESTDIR=/tmp/newbe
sudo pkg -c /tmp/newbe upgrade -r FreeBSD-base
diff <(sudo pkg -c /tmp/newbe rquery -r FreeBSD-base %n) <(sudo pkg -c /tmp/newbe query -e '%o = base' %n) | grep -v lib32 | grep "^[<>]"
sudo pkg -c /tmp/newbe install -r FreeBSD-base XXX
sudo etcupdate -D /tmp/newbe && sudo make -DBATCH_DELETE_OLD_FILES delete-old DESTDIR=/tmp/newbe
sudo beadm umount $BENAME && sudo beadm activate $BENAME && sudo beadm list
exit
#sudo shutdown -r now
sudo mount /usr/local/poudriere/data/packages
sudo rm -rfv /usr/local/poudriere/data/packages/12amd64-* /usr/local/poudriere/data/cache/12amd64-*
sudo poudriere jail -j 12amd64 -u -m src=/usr/src
cd /usr/ports
svn up
sudo poudriere bulk -j 12amd64 -f /usr/local/etc/poudriere-list
sudo pkg clean -ay
sudo pkg upgrade -r FreeBSD-ports
sudo pkg autoremove
sudo pkg upgrade -r FreeBSD-ports -f
sudo pkg clean -ay
cd /usrc/src
sudo make -DBATCH_DELETE_OLD_FILES delete-old-libs
