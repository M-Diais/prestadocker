FROM mysql:5.7

# Override some conf
ADD my.cnf /etc/mysql/docker.cnf

COPY ./run.sh /
RUN chmod 755 /run.sh
#RUN sed -e 's/user._=._mysql/user=root/' -i /etc/mysql/my.cnf

ENTRYPOINT ["/run.sh"]
