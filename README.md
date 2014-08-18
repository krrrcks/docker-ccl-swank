Clozure Common Lisp and swank server for developing 
===================================================

Introduction
------------

This image provides Clozure Common Lisp togethert with Quicklisp and
the SWANK component for debugging. The standard way for connecting a
remote SWANK server is via ssh tunneling. Therefore this image runs a
sshd as well. CCL is run as User "ubuntu". The entry point is a script
in the container's root directory. It starts sshd and CCL, the startup
script then loads /home/ubuntu/lisp/startup.lisp. Therefore you could
put all your code via -v into /home/ubuntu/lisp and use a startup.lisp
script of your own to get everything running.

This image should only be used for developing purposes. If you plan to
use it in a production environment you should take some security
measures.

Installed software
------------------

The Dockerfile and all files can be found in /.docker/ccl-swank/

This image consists of:

- Ubuntu 14.04
- Clozure Common Lisp 1.9
- Quicklisp
- sshd

Beside this image you could always have a look at the source at github: 


Example
-------

Create a new directory, e.g. with "mkdir hunchentoot". Then edit a
file startup.lisp with the following content:

```
(ql:quickload "swank")
(swank:create-server :dont-close t)

;;; put your startup code here

(ql:quickload "hunchentoot")
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
```

For accessing the web server you could create a Dockerfile of your own, e.g. with the following content:

```
FROM krrrcks/ccl-swank
EXPOSE 22 4242 
CMD ["/bin/bash", "/startup.sh"]
```

or you could use a ssh tunnel

```
ssh -L 4242:localhost:4242 ubuntu@localhost -p XXX
``` 

with XXX being the published ssh port of the ccl-swank container. 

Open Questions
--------------

Well, somehow I loose the setuid bit on /usr/bin/sudo. I have no idea
why this happens and therefore I have chmod call in my Dockerfile. Any
idea or hint is appreciated.

Feedback
--------

Your feedback, bug reports, hints are welcome. You could send me an
e-mail (look into the Dockerfile for my address) or open an issue at
github: