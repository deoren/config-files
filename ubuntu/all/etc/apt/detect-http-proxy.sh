#!/bin/bash

# Original Author: Lekensteyn <lekensteyn@gmail.com>

# Purpose:
#
#   Returns a HTTP proxy which is available for use to work around
#   a bug in APT which causes it to not fall back to direct access
#   if the proxy server is unavailable.

# References:
#
# https://askubuntu.com/questions/53443/how-do-i-ignore-a-proxy-if-not-available
# https://bugs.launchpad.net/ubuntu/+source/apt/+bug/827627
#

# Put this file in /etc/apt/detect-http-proxy and create and add the below
# configuration in /etc/apt/apt.conf.d/30detectproxy
#    Acquire::http::ProxyAutoDetect "/etc/apt/detect-http-proxy";


# APT calls this script for each host that should be connected to. Therefore
# you may see the proxy messages multiple times (LP 814130). If you find this
# annoying and wish to disable these messages, set show_proxy_messages to 0
show_proxy_messages=0

# on or more proxies can be specified. Note that each will introduce a routing
# delay and therefore its recommended to put the proxy which is most likely to
# be available on the top. If no proxy is available, a direct connection will
# be used
try_proxies=(
172.23.194.74:3128
)

print_msg() {
    # \x0d clears the line so [Working] is hidden
    [ "$show_proxy_messages" = 1 ] && printf '\x0d%s\n' "$1" >&2
}

for proxy in "${try_proxies[@]}"; do
    # if the host machine / proxy is reachable...
    if nc -z ${proxy/:/ }; then
        proxy=http://$proxy
        print_msg "Proxy that will be used: $proxy"
        echo "$proxy"
    else
        print_msg "No proxy will be used"

        # Workaround for Launchpad bug 654393 so it works with Debian Squeeze (<0.8.11)
        echo DIRECT
    fi
done

