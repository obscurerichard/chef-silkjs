#
# Cookbook Name:: silkjs
# Recipe:: default
# Author:: Richard Bullington-McGuire <richard@moduscreate.com>
#
# Copyright (c) 2012 Modus Create, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if platform?("debian", "ubuntu")
  include_recipe "apt"
end
include_recipe "git"

silkjs_src = node[:silkjs][:src]
silkjs_bin = node[:silkjs][:bin]
silkjs_user = node[:silkjs][:user]

packages = [ 
  "build-essential",
  "subversion",
  "libmm-dev",
  "libssl-dev",
  "libgd2-xpm-dev",
  "libncurses5-dev",
  "libcurl4-openssl-dev",
  "libssh2-1-dev",
  "libcairo2-dev",
  "libmysqlclient-dev",
  "libsqlite3-dev",
  "libmemcached-dev",
  "apache2-utils",
]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

bash "install_silkjs" do
  cwd silkjs_src
  user silkjs_user
  code "(make && make install) 2>&1 | logger -t silkjs"
  not_if {File.exists?(silkjs_bin)}
end

