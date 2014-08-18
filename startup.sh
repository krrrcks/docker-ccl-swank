#!/bin/bash

if [ ! -d /var/run/sshd ]
then 
  mkdir /var/run/sshd
fi

/etc/init.d/ssh start

sudo -u ubuntu -H /bin/bash -l -c "/home/ubuntu/ccl/lx86cl64 -l /home/ubuntu/lisp/startup.lisp"

