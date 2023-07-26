
This script may be used to start an ssh daemon from Term4x on bb10

```
ssh-keygen -f $HOME/.ssh/ssh_host_rsa_key -t rsa -b 4096 -N '' > /dev/null
ssh-keygen -f $HOME/.ssh/ssh_host_ecdsa_key -t ecdsa -b 521 -N '' > /dev/null
ssh-keygen -f $HOME/.ssh/ssh_host_ed25519_key -t ed25519 -N '' > /dev/null
mkdir $HOME/.ssh
echo AuthorizedKeysFile	.ssh/authorized_keys > $HOME/.ssh/sshd_config
echo HostKey ~/.ssh/ssh_host_rsa_key         >> ~/.ssh/sshd_config
echo HostKey ~/.ssh/ssh_host_ecdsa_key       >> ~/.ssh/sshd_config
echo HostKey ~/.ssh/ssh_host_ed25519_key     >> ~/.ssh/sshd_config
HostKey ~/.ssh/ssh_host_ed25519_key          >> ~/.ssh/sshd_config
```

Now you may launch the ssh daemon

```
/base/usr/sbin/sshd -p 4444 -f ~/.ssh/sshd_config
```


