FROM docker.io/centos

#inception
WORKDIR /opt/
RUN pwd && ls    
COPY ./inc.cnf /opt/
RUN echo 'after copy' && pwd && ls
RUN yum -y install wget git gcc gcc-c++ make cmake openssl-devel ncurses-devel m4\
    && cd /opt \  
    && wget https://github.com/hhyo/inception/releases/download/v2.1.52.1/Inception_2.1.52.1 \
    && mv Inception_2.1.52.1 /opt/Inception \
    && chmod 777 Inception && cp /opt/inc.cnf /tmp/inc.cnf\ 
#修改中文支持
    && rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
    && yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common \ 
    && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
ENV LC_ALL zh_CN.utf8 #设置环境变量

#port
EXPOSE 6669

#start service
ENTRYPOINT nohup /opt/Inception --defaults-file=/tmp/inc.cnf && bash
