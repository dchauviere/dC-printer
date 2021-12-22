```shell
cat > /etc/udev/rules.d/60-gpiod.rules <<EOF
SUBSYSTEM=="gpio", KERNEL=="gpiochip[0-9]*", GROUP="dialout", MODE="0660"
EOF
```