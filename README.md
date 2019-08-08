# nagios-nvidia-smi

This plugin for checks Nvidia GPU stats via the nvidia-smi executable.

Takes measures of GPU user, GPU Memory use and temperature

## Instalation

[Check_Mk](https://checkmk.com/) installation

In every node... (Using [puppet](https://en.wikipedia.org/wiki/Puppet_(software)) or another [SCM](https://en.wikipedia.org/wiki/Software_configuration_management) is extremely recommended)

```
root@gpu:~#cd /lib/check_mk_agent/local
root@gpu:/usr/lib/check_mk_agent/local# git clone https://github.com/icalvete/nagios-nvidia-smi .
root@gpu:/usr/lib/check_mk_agent/local# bundler install
```

Then...

Go to check_mk.
Go any host and rediscover services.

https://github.com/icalvete/nagios-nvidia-smi/blob/master/example.jpg

## TODO

* Warning and critical thresholds are shared between GPU use, GPU Memory use.
* No warning and critical thresholds to temperature

