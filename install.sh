#/bin/bash

SYSTEMD_PATH="/etc/systemd/system/"
BIN_PATH="/usr/local/bin/"

sudo /bin/cp ./temp_monitor.sh ${BIN_PATH} -v
sudo chmod +x ${BIN_PATH}
echo -e "\[Service\] \nExecStart=${BIN_PATH}temp_monitor.sh" | sudo tee ${SYSTEMD_PATH}temp_monitor.service

sudo systemctl daemon-reload

echo Install Complete.


