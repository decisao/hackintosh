#!/bin/bash
sudo pmset -a proximitywake 0
sudo pmset -a hibernatemode 3
sudo pmset -a standbydelaylow 7200
sudo pmset -a standbydelayhigh 7200
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool yes
pmset -g live