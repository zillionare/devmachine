# devmachine
docker image for python developer

installed with

sshd
git
redis
postgres
miniconda
python3
wget 
vim

# usage

## build and run

after clone files onto your local machine, build the image by running:

```
sudo docker build -t image_name .
```

at the folder where Dockerfile exists. Specify any image_name you want.

After the images is built, launch the container:

```
sudo docker run -d -P -p 31822:22 --name container_name image_name
```

'-P' here is used to mapping redis/postgres port to host. 

you can use other port rather than 31822 for ssh connection

## remote login

The user/password is 'root:root', 'PermitRootLogin' is set to 'yes'. After your first
login, you can edit /etc/ssh/sshd_config and change it to 'no' to prohibit root login.

You can also build your own images by running:

```
sudo docker build -t tag_name .
```

and before that, put an authorized_keys file into rootfs/root/.ssh/

so you can login by pubkey later.
