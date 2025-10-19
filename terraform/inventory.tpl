[workers]
%{ for ip in droplet_ips ~}
${ip}
%{ endfor ~}

[utilities]
grafana.julia-b.work

[all:children]
workers
utilities

[all:vars]
ansible_ssh_private_key_file=${ssh_private_key_path}                                                        