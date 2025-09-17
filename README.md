# bash
Writing scripts, code and anything that I like relating to RHCSA/RHCE learning! 

## Command to copy my bashrc profile that sets colors and basic useful alias
```bash
curl -s "https://raw.githubusercontent.com/vatsal1991/bash/main/clrterminal" >>~/.bashrc; source ~/.bashrc
```



## Install tmux on ubuntu/debian
```bash
apt install tmux
```
## Common shortcuts
- **Bind key** `CTRL-B`
- Vertical split `%`
- Horizontal split `"`
- Switch panes `o`
- Kill pane `x`

## Install terraform
```
#!/bin/bash
set -e

# Update system and install gpg
sudo apt update && sudo apt install -y gpg

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

# Add HashiCorp official repo
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
sudo apt update && sudo apt install -y terraform

# Verify installation
terraform -version
```
