# dnsmap.sh

dnsmap.sh is a script enumerate DNS hostnames by brute force guessing of common
subdomains.

It's faster than the original [DNSMap](https://code.google.com/archive/p/dnsmap/source) by pagvac.
and uses only 100~ lines of code.

![dnsmap.sh](https://raw.githubusercontent.com/wiki/bindh3x/dnsmap.sh/images/dnsmap_screenshot.png)

# Installation

```
$ curl -o dnsmap -L git.io/dnsmap.sh
$ chmod +x dnsmap
$ ./dnsmap 
```

# Dependencies

* bind-tools >= 9.0 (dig)

# Usage

```bash
Usage ./dnsmap.sh <domain> <list> <record type> ...

dnsmap.sh - script to enumerate DNS hostnames

Examples:
 dnsmap.sh example.com list.txt A # IPv4
 dnsmap.sh example.com list.txt AAAA # IPv6
 dnsmap.sh example.com list.txt CNAME

```

# Copying

Copyright (c) 2017 bindh3x <os@bindh3x.io>
<br/>
[![license](https://img.shields.io/github/license/bindh3x/off.svg?style=flat-square)]()
