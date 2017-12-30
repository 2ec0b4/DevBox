# Mac OS X Dev Box

Mac OS X Dev Box with dynamic virtual hosts: create a new folder in your vagrant webroot and have it directly accessible on a dev.local subdomain through a local dns lookup

## Box content

* Ubuntu Xenial 16.04 LTS x64
* Apache 2.4
* Ruby 2.3.1
  * capistrano
  * capistrano-composer
  * capistrano-file-permissions
* PHP 7.1
* MariaDB 10.2
  * Database name: dbname
  * Users:
    * root:root
    * dbuser:dbuser
* MailHog
  * after installation, accessible at <http://devbox.puphpet:8025/>

If you are using [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager), the hostname ```devbox.puphpet``` will be automatically add to your ```/etc/hosts``` file. If not, you will have to add it manually.

## Prerequisites

  * [VirtualBox](https://www.virtualbox.org/)
  * [Vagrant](https://www.vagrantup.com)
  * [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)

## Installing

Clone this repo:
```
$ git clone git://github.com/2ec0b4/DevBox.git && cd DevBox
```

Install dnsmasq with [Brew](http://brew.sh/):
```
$ brew install dnsmasq
```

## Configuring Dnsmasq

Copy the dnsmasq example files and start dnsmasq automatically:
```
$ cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
$ sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
$ sudo chown root /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
$ sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
```

Insert ```address=/dev.local/192.168.100.100``` into the dnsmasq configuration file: ```/usr/local/etc/dnsmasq.conf``` (near ```address=/double-click.net/127.0.0.1```, for example)

Restart dnsmasq:
```
$ sudo launchctl stop homebrew.mxcl.dnsmasq
$ sudo launchctl start homebrew.mxcl.dnsmasq
```

## Configuring Mac OS X

Send .local queries to dnsmasq:
```
$ sudo mkdir -p /etc/resolver
$ sudo tee /etc/resolver/local >/dev/null <<EOF
nameserver 127.0.0.1
EOF
```

## Testing

Launch the vagrant box and wait until it is ready:
```
$ vagrant box update && vagrant up
```

Test the configuration:
```
$ mkdir html/test/
$ touch html/test/index.php
$ ping -c 1 test.dev.local
```

Here is a command to list DNS servers configured on the system
```
$ scutil --dns
```

## Credits

Based on this great post: <https://passingcuriosity.com/2013/dnsmasq-dev-osx/>
