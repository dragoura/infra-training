[workers]
%{ for idx, ip in droplet_ips ~}
${droplet_names[idx]} ansible_host=${ip}
%{ endfor ~}

[utilities]
grafana.julia-b.work

[all:children]
workers
utilities

[all:vars]
ansible_ssh_private_key_file=${ssh_private_key_path}                                                        