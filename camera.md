```shell
insmod /lib/modules/4.9.280/kernel/drivers/media/usb/gspca/gspca_main.ko
insmod /lib/modules/4.9.280/kernel/drivers/media/usb/gspca/gspca_sonixb.ko
LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libv4l/v4l1compat.so ./mjpg_streamer -i "input_uvc.so" -o "output_http.so -w ./www"
```