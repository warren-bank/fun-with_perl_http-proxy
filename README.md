# [Fun with: perl, HTTP:Proxy](https://github.com/warren-bank/fun-with_perl_http-proxy)
random examples for using perl [HTTP:Proxy](http://search.cpan.org/~book/HTTP-Proxy-0.301/lib/HTTP/Proxy.pm) to filter/rewrite content as it passes through (in either direction)

## Summary

  * something I was playing around with one Saturday morning
  * repo consists of a bunch of demos using the perl `HTTP:Proxy` library
  * each demo is fairly simple, and uses this library to run a light-weight proxy server that can perform content filtering via regex
  * the value here, if any, is learn-by-example;<br>
    this repo doesn't contain any original code that's particularly note-worthy
  * I was using a Windows machine, so all shell scripts are `.bat` files

## Configuration

  * there are two `.bat` files that you'll need to copy and edit:
    * `00_common/env.bat.sample`
      * save copy as: `00_common/env.bat`
      * edit variable: `perl_home`
    * `00_common/env.test.bat.sample`
      * save copy as: `00_common/env.test.bat`
      * edit variable: `wget_home`

## License

  > [WTFPL](http://www.wtfpl.net/txt/copying/)
  > Copyright (c) 2014, Warren Bank
