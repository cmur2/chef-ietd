# chef-ietd

## Description

Installs and configures the IET iSCSI server providing a limited option subset (maybe easily extended) and currently **lacking** support for installing and configuring iSCSI initiator (client) software.

## Usage

Use ietd::default recipe to get an iSCSI server without any targets. These can be added to the `node[:ietd][:targets]` array like so:

	"ietd": {
		"targets": [
			{
				"iqn": "iqn.2013-01.org.example:storage",
				"luns": [
					[0, "Path=/path/to/lun0,Type=fileio"],
					[1, "Path=/path/to/lun1,Type=fileio"]
				]
			}
		]
	}

All targets are publicly accessible by default, use `node[:ietd][:initiators_allow]` and `node[:ietd][:targets_allow]` that reflect the settings for *initiators.allow* and *targets.allow*. See default attributes file for more examples.

## Requirements

### Platform

It should work on all OSes that provide a package containing the [iSCSI Enterprise Target](http://iscsitarget.sourceforge.net/) which currently is at least Debian.

## Recipes

### default

Installs and configures the IET iSCSI server deamon *ietd*.

## License

chef-ietd is licensed under the Apache License, Version 2.0. See LICENSE for more information.
