SELECT CURRENT_USER usr
      ,inet_server_addr() host -- use inet_client_addr() to get address of the remote connection
      ,inet_server_port() port -- use inet_client_port() to get port of the remote connection
