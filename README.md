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

To get started, you'll need get the image first. There're two ways to do so:

1. pull image from docker hub by simply run ``sudo docker pull zillionare/python-dev-machine``
2. build local image by your own:
    1. clone files onto your local machine, cd to that dir
    2. run the following command:
        ```
        sudo docker build -t image_name .
        ```

        Specify any image_name you want.

3. now you have a image at local now, then create the container by:
    ```
    sudo docker run -d -P -p 31822:22 --name container_name --restart unless-stopped image_name
    ```

    '-P' here is used to mapping redis/postgres port, and 5 reserved ports 3180~3184 to host. You can run your service on these reserved ports.

    port 31822 here is for ssh connection, you can use port rather than 31822 for ssh connection.

    "--restart unless-stopped" tells docker enginer restart this container after system boot, or other case, if not stopped by user.

4. running the container
    after step 3, the container is up and run. For later usage, since this is dev machine and should run for a long period, you should start the container by:

    ```
    sudo docker start your_container_name
    ```

    instead of execute command `run` found in step 3, which will always create new containers.

## remote login
When you log into this machine by ssh (``ssh your_host_ip 31822``), you will be prompted to provide password. The password is `root`.

If you'd like to use public key, then please copy your pubkey to the container by：

```bash
scp -P 31822 authorized_keys root@your_host_ip:~/.ssh/
```

Here your_host_ip means the machine which host your container. The pub key is actually copied into the container, since we used "-P 31822" here. ``authorized_keys`` is your private key file.

then try to login the container again, to see if there's no prompt for password. If succeed, then your can prohibit remote root login by editing /etc/ssh/sshd_config and set 'PermitRootLogin' to 'no'
'PermitRootLogin' is set to 'yes'. 
# customize

Some area may expirence low connection speed with default PYPI repo. In such case, you can specify a mirror repo when create the container by:

```
    sudo docker run -d -P -p 31822:22 -e PYPI_INDEX_URL=https://my_pypi_mirror --name container_name image_name
```
replace my_pypi_mirror with a real mirror repo.


