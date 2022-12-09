This is a very simple script that checks if you have an open-ssh agent available and if not opens KeePassXC. Once you have opened your database KeePass will be minimized.

It then executes whatever parameter it is given. Simplest use example would be to use an ssh agent protected by KeePassXC to connect to a server via ssh.

The opening and minimizing of keepassxc is done via xdotool, meaning it only works with the X display server.
If you still wish to use this script on wayland you will need to disable the xdotool requirement and remove the line using the command of the same name.

# Usage

```bash
./linux_ssh.sh [command]
```

# Example


```bash
./linux_ssh.sh "ssh -A root@example.com"
```

# Dependencies

The scripts requires bash and 2 packages installed on your system


* keepassxc 
* xdotool

The script will attempt to install them using some of the most popular package managers, namely

* apk
* apt
* apt-get
* dnf
* zypper

If your system has no access one of these or if the respective packages cannot be found under the common name in the repositories then you need to install those packages manually.