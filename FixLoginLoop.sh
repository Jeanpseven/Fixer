#!/bin/bash
sudo mv ~/.Xauthority ~/.Xauthority.backup
sudo chmod 700 ~
chown -R kali:kali ~
sudo service lightdm restart
