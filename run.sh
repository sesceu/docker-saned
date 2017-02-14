#! /bin/sh

echo "SANED_ACL = [ $SANED_ACL ]"
echo "SANED_DLL = [ $SANED_DLL ]"
echo "SANED_DEVICE = $SANED_DEVICE"

if [ -n "$SANED_ACL" ]; then
    echo $SANED_ACL >> /etc/sane.d/saned.conf
else
    echo "localhost" >> /etc/sane.d/saned.conf
fi

if [ -z "$SANED_DEVICE" ]; then
    echo "You need to set the environment variable SANED_DEVICE to some scanner returned by 'scanimage -L'."
    exit 1
fi

if [ -n "$SANED_DLL" ]; then
    echo $SANED_DLL >> /etc/sane.d/dll.conf
fi

if [ -z "$SANED_LOG_LEVEL" ]; then
    $SANED_LOG_LEVEL = 2
fi

saned -d$SANED_LOG_LEVEL "$SANED_DEVICE"
