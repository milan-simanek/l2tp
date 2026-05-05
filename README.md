# L2TP tunnel

The goal of the project is to connect multiple routers using VPN networks.
The server router is listening on a public IP address while client routers could be behind NAT.
The router should run xl2tpd process in a container. Kubernetes pod is supported.

Linux ``xl2tpd'' daemon implementation sometimes looses a connection which
is not detected. This image runs a script periodically checking the network
device *UP* flag. If we run a client and the device is not up, then the 
connection is reconnected.
