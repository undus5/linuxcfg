# tunn

## Preparation

Create system user for running services:

```
(root)# useradd -r -m tunn
```

-r, --system\
-m, --create-home

Add server IP to client's `/usr/local/etc/hosts` and `/usr/local/etc/tunn.nft`.

## Dependencies

[nftables](https://wiki.nftables.org/)
, [smartdns](https://github.com/pymumu/smartdns)
, [go-gost/gost](https://github.com/go-gost/gost)
, [xjasonlyu/tun2socks](https://github.com/xjasonlyu/tun2socks)
, [klzgrad/naiveproxy](https://github.com/klzgrad/naiveproxy)
, [17mon/china_ip_list](https://github.com/17mon/china_ip_list)

