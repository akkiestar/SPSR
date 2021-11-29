FROM akkie/tf240py37:latest
RUN pip install torch==1.0 -f
RUN pip install torchvision==0.2.1
RUN pip install tensorboardx
RUN pip install lmdb
EXPOSE 8888
EXPOSE 6006
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["/bin/sh", "-c", "while :; do sleep 10; done"]