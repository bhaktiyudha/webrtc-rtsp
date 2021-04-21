#!/bin/sh
mv rtsp-webrtc.service /etc/systemd/system/rtsp-webrtc.service
sudo systemctl enable rtsp-webrtc.service 
sudo systemctl start rtsp-webrtc.service 