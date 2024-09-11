# ClamAV is an open-source antivirus engine
sudo apt install -y clamav clamav-daemon clamtk

# Stop service before update the virus definition database
sudo systemctl stop clamav-freshclam

# Update virus definition database
sudo freshclam

# Start service
sudo systemctl enable clamav-freshclam --now

# Create cron job
mkdir -p ~/.config/ClamAV
cp ~/.local/share/omakub/configs/ClamAV/cron-clamscan.sh ~/.config/ClamAV/
chmod +x ~/.config/ClamAV/cron-clamscan.sh
echo "0 14 * * 4 ~/.config/ClamAV/cron-clamscan.sh" | crontab -
