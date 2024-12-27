CREATE USER 'replica_user'@'%' IDENTIFIED BY 'replica_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';

CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitor';
GRANT REPLICATION CLIENT ON *.* TO 'monitor'@'%';


FLUSH PRIVILEGES;


