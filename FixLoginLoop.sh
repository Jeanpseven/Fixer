#!/bin/bash
sudo mv ~/.Xauthority ~/.Xauthority.backup
sudo chmod 700 ~
sudo chown -R kali:kali ~
sudo service lightdm restart
