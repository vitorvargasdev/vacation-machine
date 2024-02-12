USER=$1
PWD=$2

pacman-key --init
pacman -Sy --noconfirm reflector 

reflector --latest 5 \
  --protocol http,https \
  --save "/etc/pacman.d/mirrorlist" \
  --sort rate

pacman -Syu --noconfirm base base-devel sudo zip unzip docker docker-compose git go

useradd -m -g users -G wheel $USER

echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

systemctl enable docker

usermod -aG docker $USER

echo -e "$PWD\n$PWD" | passwd $USER

cp /etc/sudoers /etc/sudoers.bkp

echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

cp /tmp/dev.zip /home/$USER/dev.zip
chown $USER /home/$USER/dev.zip
su $USER -c "unzip /home/$USER/dev.zip"
rm /home/$USER/dev.zip

su $USER -c "cd /home/$USER && mkdir -p /home/$USER/pkgs && cd /home/$USER/pkgs"
su $USER -c "cd /home/$USER/pkgs && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm"
su $USER -c "cd /home/$USER/pkgs && git clone https://aur.archlinux.org/go-task-bin.git && cd go-task-bin && makepkg -si --noconfirm"

bash -c "cat /etc/sudoers.bkp > /etc/sudoers"
rm /etc/sudoers.bkp
