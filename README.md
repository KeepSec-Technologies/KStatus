# KStatus

## *This bash script makes a cronjob to notify you when one of your service is down via user inputs prompts to make the configuration as easy as possible.*

### ***Prerequisites:***

**1)** Install 'expect' to be able to use the autoexpect command:

Debian-based OS: 
```bash
sudo apt-get install -y expect
```
RHEL-based OS: 
```bash
sudo yum install -y expect
```

Arch-based OS: 
```bash
sudo pacman install -y expect
```

**2)** Being logged in as root or super-user

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
sudo chmod +x KStatus.sh
```
**2)** Then run: 
```bash
sudo autoexpect -quiet $PWD/KStatus.sh
```
***(Very important to use this exact command)***

**3)** Answer the questions like the image below and you're good to go!

![image](https://user-images.githubusercontent.com/108779415/177498003-25d6eb23-b29c-49fd-95a5-ef14c6e1c6af.png)



**Warning: Do not change the path of the 'script.exp' file since the cronjob depends on it.**

If you messed up your input don't worry just rerun the script with autoexpect, it will overwrite everything.

Feel free to modify the code if there's something that you want to change.




