# consul

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with consul](#setup)
    * [What consul affects](#what-consul-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Installed Files - What gets installed](#installed-files)

## Overview

This module installs Consul for the Cerberus project along and an upstart script.

## Module Description

We're only using a subset of consul's capabilities:

Applications can make use of Consul's hierarchical key/value store for any number of purposes, 
including dynamic configuration, feature flagging, coordination, leader election, and more. 
The simple HTTP API makes it easy to use.

More Information: (https://www.consul.io/intro/index.html)

## Setup

### What consul affects

This module should be run on an instance that will either host a consul client or server.

### Setup Requirements 

This puppet module assumes the base image already has tools like unzip and awscli installed.

## Usage

Start consul with upstart as root: `start consul`
Stop consul with upstart as root: `stop consul`

The process runs as a system user named `consul`

### Installed Files

Upstart Config: `/etc/init/consul.conf`
Binary: `/usr/local/bin/*`
Configuration: `/etc/consul/*`
Data: `/var/consul/data`
Log: `/var/log/consul/*`

*Server Only:*

Web UI: `/var/consul/webui/dist`