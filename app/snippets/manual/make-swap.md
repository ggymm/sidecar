```bash


# 查看磁盘空间
df -h

# 查看交换分区
free -h

# 创建交换分区
sudo fallocate -l 64G /home/ubuntu/swapfile

# 检查交换分区
ls -lh /home/ubuntu/swapfile

# 设置交换分区权限
sudo chmod 600 /home/ubuntu/swapfile
sudo mkswap /home/ubuntu/swapfile
sudo swapon /home/ubuntu/swapfile
sudo swapon --show

# 查看交换分区
free -h

# 持久化交换分区设置
sudo cp /etc/fstab /etc/fstab.bak
echo '/home/ubuntu/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


```