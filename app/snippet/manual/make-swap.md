#### 查看磁盘空间

```bash
df -h
```

#### 查看交换分区

```bash
free -h
```

#### 创建交换分区

```bash
sudo fallocate -l 64G /home/ubuntu/swapfile
ls -lh /home/ubuntu/swapfile

sudo chmod 600 /home/ubuntu/swapfile
sudo mkswap /home/ubuntu/swapfile
sudo swapon /home/ubuntu/swapfile
sudo swapon --show
```

#### 持久化交换分区设置

```bash
sudo cp /etc/fstab /etc/fstab.bak
echo '/home/ubuntu/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```
