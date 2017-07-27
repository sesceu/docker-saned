# docker-saned
Dockerized saned scanner server. Originally based on [sesceu/docker-saned](https://github.com/sesceu/docker-saned), but changed to use [Debian stable](https://debian.org) and [runit](http://smarden.org/runit/) instead.

## Usage
Make sure that the device node e.g. `/dev/usb/00x/` has group id 7 (lp) and group read access.

### Environment variables:
  * SANED_ACL: (***required***) IP ranges or hosts that are allowed access to the daemon.
  * SANED_DLL: (*optional*) Add this dll to /etc/sane.d/dll.conf with these values for faster response
  * SANED_LOGLEVEL: (*optional*) Set a higher log level for sane. Default = 2, up to 128

### Ports
This container exposes ports 6566 (saned), 10000 and 10001 (data ports)

### Running

Run as:
```
docker run -v /dev/bus/usb:/dev/bus/usb --privileged -e SANED_ACL="192.168.0.0/24\n10.0.0.0/8" -p 6566:6566 -p 10000:10000 -p 10001:10001 jdeluyck/docker-saned
```

### Logging

saned logs are put in `/var/log/saned` using svlog.