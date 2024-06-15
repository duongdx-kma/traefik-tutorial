[all]
%{ for key, value in jsondecode(instances) ~}
${value.hostname} ansible_user=${value.username} ansible_host=${value.ip} ansible_port=22
%{ endfor ~}

[all:vars]
ansible_ssh_private_key_file=client.pem
