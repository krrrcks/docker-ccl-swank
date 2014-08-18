# 
# Clozure Common Lisp / SWANK (SLIME environment)
#

FROM ubuntu:14.04
MAINTAINER krrrcks <krrrcks@krrrcks.net>
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update; \
  apt-get -q -y upgrade 
RUN /usr/sbin/locale-gen de_DE.UTF-8; \
    update-locale LANG=de_DE.UTF-8 
RUN apt-get -y -q install ssh screen git subversion wget && apt-get clean
RUN adduser --quiet ubuntu; \
      addgroup ubuntu adm; \
      addgroup ubuntu sudo; \
      echo 'ubuntu:ubuntu' | chpasswd

USER ubuntu 
ENV HOME /home/ubuntu
WORKDIR /home/ubuntu 
RUN svn co http://svn.clozure.com/publicsvn/openmcl/release/1.9/linuxx86/ccl
RUN wget http://beta.quicklisp.org/quicklisp.lisp
ADD . /.docker/ccl-swank/
RUN mkdir /home/ubuntu/lisp/
ADD startup.lisp /home/ubuntu/lisp/
ADD .ccl-init.lisp /home/ubuntu/
RUN /home/ubuntu/ccl/lx86cl64 -e "(progn (load (merge-pathnames \"quicklisp.lisp\" (user-homedir-pathname))) (funcall (read-from-string \"quicklisp-quickstart:install\")) (funcall (read-from-string \"ql:quickload\") \"quicklisp-slime-helper\"))"

USER root
ADD startup.sh /

EXPOSE 22 
CMD ["/bin/bash", "/startup.sh"]