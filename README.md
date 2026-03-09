# L2TP tunnel

The goal of the project is to connect multiple routers using VPN networks.
The server router is listening on a public IP address while client routers could be behind NAT.
The router should run xl2tpd process in a container. Kubernetes pod is supported.
