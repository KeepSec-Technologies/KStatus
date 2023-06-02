# KStatus

## *This bash script makes a cronjob to notify you when one of services is down configured 100% via user inputs prompts to make the configuration as easy as possible.*

### ***Prerequisites:***

**1)** Being logged in as root or super-user

**3)** An internet domain pointing to your server, I recommend installing an SPF/DMARC record to pass through some email provider when sending your notifications.

That's it!

### ***What's next:***

**1)** Install the KStatus.sh file and make it executable.

To install it: 
```bash
wget https://raw.githubusercontent.com/KeepSec-Technologies/KStatus/main/KStatus.sh
```
To make it executable:
```bash
chmod +x KStatus.sh
```
**2)** Then run: 
```bash
./KStatus.sh
```

**3)** Answer the questions like the image below and you're good to go!

![image](https://github.com/KeepSec-Technologies/KStatus/assets/108779415/c38fab88-2821-4508-ad4e-1f581ab06b44)

*It will install everything you need and then we're done!*


The cronjob is in **/etc/cron.d/KStatus-[DOMAIN]-job** 

The cronjob logs is in **/etc/KStatus/logs**

If you want to remove only the configurations re-run the script and it will ask you for this:
![image](https://github.com/KeepSec-Technologies/KStatus/assets/108779415/58053917-1517-4c6d-ba51-d0b851e2019a)

If you want to uninstall completely it do:
```bash
rm -f /etc/cron.d/KStatus-*
rm -fr /etc/KStatus
```

Feel free to modify the code if there's something that you want to change.
