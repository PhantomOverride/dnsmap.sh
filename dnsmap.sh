#!/usr/bin/env bash
# dnsmap.sh: script to enumerate DNS hostnames.
#
# Copyright (c) 2017 bindh3x <os@bindh3x.io>
#
# $ Fri, 01/09/17 14:30:58

# Colors
reset="\033[00m";
black="\033[1;30m";
blue="\033[0;34m";
cyan="\033[1;36m";
green="\033[0;32m";
orange="\033[1;33m";
purple="\033[1;35m";
red="\033[0;31m";
violet="\033[1;35m";
white="\033[1;37m";
yellow="\033[0;33m";

# Globals 
version="0.1"

dnsmap_usage() {

cat << EOF
Usage $0 <domain> <list> <record type> ...

dnsmap.sh - script to enumerate DNS hostnames

Examples:
 dnsmap.sh example.com list.txt A # IPv4
 dnsmap.sh example.com list.txt AAAA # IPv6
 dnsmap.sh example.com list.txt CNAME

Copyright (c) 2017 bindh3x <os@bindh3x.io>
Full documentation at: http://bindh3x.io/software/dnsmap.sh/
EOF
}

dnsmap_logo() {
printf "${green}dnsmap.sh${reset} - script to enumerate DNS hostnames\n"
printf "Copyright (c) 2017 ${red}bindh3x${reset} <os@bindh3x.io>\n\n"
}

dnsmap_error() {
  printf "${red}[-]${reset} $@.\n" 
} 

dnsmap_info() {
  printf "${blue}[*]${reset} $@.\n" 
} 

dnsmap_fail() {
  dnsmap_usage
  dnsmap_error "$@"
  exit 1
}

dnsmap_check_dep() {
  if [ -z $(which dig) ];then 
    dnsmap_fail "please install bind-tools. (dig)"
  fi
}

dnsmap() {
  dnsmap_logo
  match=0

  if [ ! -f "$2" ];then	
    dnsmap_fail "please specify word list"
  fi

  count=$(cat $2| wc -l)
  dnsmap_info "Starting dnsmap.sh ${version} - testing ${green}${count}${reset} domains ..."

  for x in $(cat $2);do 
    domain="${x}.${1}"
    o=$(dig $domain "${@:4}" | grep "${domain}" | awk 'NR==3{print $0}')
    if [ ! -z "$o" ];then
      printf "${green}[+]${reset} ${o}" && echo
      match=$((match + 1))
    fi
  done
  
  dnsmap_info "done, found ${match} domains."
}

if [ $# -lt 3 ];then
  dnsmap_usage
  exit 1
fi

case "$1" in
  -h|--help)
    dnsmap_usage
  ;;
  *)
esac

dnsmap_check_dep
dnsmap "$1" "$2" "${@:4}"
