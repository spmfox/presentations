# Podman + Quadlet + Ansible:
## Rootless service management

###### Michael Fox
###### SouthEast LinuxFest 2025

---
## What are containers?
Containers are technologies that allow the packaging and isolation of applications with their entire runtime environment - all of the files necessary to run.

This makes it easy to move the contained application between environments (dev, test, production, etc.) while retaining full functionality.

###### https://www.redhat.com/en/topics/containers

---
## What is Podman?
Podman (short for pod manager) is an open source tool for developing, managing, and running containers.

Podman's daemonless and inclusive architecture makes it an accessible, security-focused option for container management.

###### https://www.redhat.com/en/topics/containers/what-is-podman

---
## What is Podman?
Podman stands out from other container engines because it’s daemonless, meaning it doesn't rely on a process with root privileges to run containers.

Daemons are processes that run in the background of your system to do the work of running containers without a user interface. 

###### https://www.redhat.com/en/topics/containers/what-is-podman

---
## What are pods?
Pods are groups of containers that run together and share the same resources, similar to Kubernetes pods.

Each pod is composed of 1 infra container and any number of regular containers. The infra container keeps the pod running and maintains user namespaces, which isolate containers from the host.

###### https://www.redhat.com/en/topics/containers/what-is-podman

---
## What is systemd?
systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system.

Other parts include a logging daemon, utilities to control basic system configuration like the hostname, date, locale, maintain a list of logged-in users and running containers and virtual machines, system accounts, runtime directories and settings, and daemons to manage simple network configuration, network time synchronization, log forwarding, and name resolution.

###### https://systemd.io/

---
## What is Quadlet?
Quadlet is a tool for running Podman containers under systemd in an optimal way by allowing containers to run under systemd in a declarative way.

Anywhere you want to run a containerized system service without requiring human intervention, it's wise to use systemd to manage your locally running Podman containers.

###### https://www.redhat.com/en/blog/quadlet-podman
###### https://docs.podman.io/en/stable/markdown/podman-systemd.unit.5.html

---
## What is Ansible?
Ansible is an open source, command-line IT automation software application written in Python. It can configure systems, deploy software, and orchestrate advanced workflows to support application deployment, system updates, and more.

Ansible’s main strengths are simplicity and ease of use. It also has a strong focus on security and reliability, featuring minimal moving parts. It uses OpenSSH for transport (with other transports and pull modes as alternatives), and uses a human-readable language that is designed for getting started quickly without a lot of training.

###### https://www.redhat.com/en/ansible-collaborative/how-ansible-works

---
## How can these work together?
- Pods and containers are declared with Quadlet
- Quadlets can be declared into logical units via YAML inventory
- Ansible can configure the host
- Ansible can manage the deployment of the Quadlet files per the YAML inventory
- Systemd sees the Quadlet files then manages the pods and containers as services
- This can all be done **rootless**

---
## Considerations for running Podman rootless
There are other potential issues, depending on which distro you are using. In general its best to use a distro with recent versions of Podman, systemd, and the related tooling.

The latest release of Fedora or CentOS Stream are a good starting point.

###### https://github.com/containers/podman/blob/main/rootless.md

---
## Configuring the host
What is the bare-minimum configuration needed on the host?
- systemd:
  - `loginctl enable-linger <rootles_containers_user>` 
  - If this is not enabled, systemd will stop a user's processes when not logged in

- sysctl:
  - `net.ipv4.ip_unprivileged_port_start=<rootless_port_start>`
  - If ports are needed, such as 80 or 22, sysctl needs to know that unprivileged users can use these ports

---
## Configuring the host
![configure-host](gifs/configure-host.gif)

---
## Switching users
The containers user should be as restricted as possible, and maybe even difficult to accidentally access (so you don't mess up production).

In our example we will use the "containers" user that has no password (and no SSH key), but is accessed with the systemd command `machinectl`. This command is powerful and does many other things, but we are going to use it as a replacement for `sudo su`.

When you `sudo su` into a user, it's not a full session so you cannot easily manipulate systemd user services.

You can access the containers user like this: `sudo machinectl shell <user>@`

---
## Switching users
![machinectl](gifs/machinectl.gif)

---
## Running containers with Podman
There are multiple methods of running containers:
- `run`
- `compose`

Most people have heard of Docker Compose, many projects have compose instructions. There are ways to get compose working with Podman however this will not easily work with Quadlet.

We will be focusing on `podman run` (or `docker run`). If you have `podman run` instructions you'll be able to easily work with Quadlet.

---
## Running your first rootless container
![rootless-container-run](gifs/rootless-container-run.gif)

---
## Creating Quadlet files
To use Quadlet, you'll need the Quadlet files.

You can use a tool called Podlet to assist with this process. Once you get the hang of it, they can be written manually.

Using a `podman run` command you can generate a Quadlet file:

`podlet podman run --rm -d --name wordpress-app docker.io/library/wordpress`

Podlet can translate Compose files however your mileage may vary.

###### https://github.com/containers/podlet

---
## Creating Quadlet files
![podlet](gifs/podlet.gif)

---
## Creating Quadlet files
Podlet is useful as a starting point, but there is no replacement for reading the manual itself and building your own.

###### https://docs.podman.io/en/stable/markdown/podman-systemd.unit.5.html

---
## Getting started with Quadlet
Quadlet files look and act mostly like systemd service files, but with Podman directives added.

Because they are systemd service files, we can tell systemd to tie our services together as one logical unit.

Here is an example of our WordPress with fully populated Quadlet files.

---
## Getting started with Quadlet
`wordpress.pod`

    [Unit]
    Wants=check-network-online.service podman-auto-update.timer wordpress-app.service wordpress-db.service
    Before=wordpress-app.service wordpress-db.service
    After=check-network-online.service

    [Pod]
    PublishPort=80:80
    PodName=wordpress

    [Install]
    WantedBy=default.target

- [Unit]: we are asking for other systemd services that should start, and what order to start them in
- [Pod]: Podman configuration for the pod goes
- [Install]: allows `wordpress-pod.service` service to start automatically (if enabled)

---
## Getting started with Quadlet
`wordpress-app.container`

    [Unit]
    Wants=wordpress-pod.service wordpress-db.service
    After=wordpress-pod.service wordpress-db.service
    PartOf=wordpress-pod.service

    [Container]
    ContainerName=wordpress-app
    Pod=wordpress.pod
    Environment=WORDPRESS_DB_HOST=127.0.0.1 WORDPRESS_DB_USER=root WORDPRESS_DB_PASSWORD=wordpress
    Environment=WORDPRESS_DB_NAME=wordpress WORDPRESS_TABLE_PREFIX=wp_
    Image=docker.io/library/wordpress:latest
    AutoUpdate=registry

- [Unit]: we are asking for other systemd services that should start, and what order to start them in - we also tie this service to `wordpress-pod.service`
- [Container]: Podman configuration for the container - name, environment variables, image path are all defined here

---
## Getting started with Quadlet
`wordpress-db.container`

    [Unit]
    Wants=wordpress-pod.service
    After=wordpress-pod.service
    PartOf=wordpress-pod.service

    [Container]
    ContainerName=wordpress-db
    Pod=wordpress.pod
    Environment=MARIADB_DATABASE=wordpress
    Environment=MARIADB_ROOT_PASSWORD=wordpress
    Image=docker.io/library/mariadb:latest
    AutoUpdate=registry

---
## Getting started with Quadlet
### Files
Quadlet files can go in two locations, depending on the user running them:
- `$HOME/.config/containers/systemd/` - rootless
- `/etc/containers/systemd/` - root

(The rest of this presentation will focus on rootless, many systemd commands will have `--user` in them, you can remove this to work with root Quadlets)

Once the files are in place, issue a `systemctl --user daemon-reload` to have systemd reload and automatically scan the Quadlet files.

---
## Getting started with Quadlet
### Troubleshooting

`/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun`
This command asks systemd to parse the Quadlet files, when successful it will dump your Quadlets translated into systemd units. If it fails, there will be an error.

---
## Getting started with Quadlet
### Running

Once systemd parses the Quadlet files, it creates the corresponding services automatically. All thats left to do is `systemctl --user start wordpress-pod.service`.

Quadlet generated systemd services are transient, so they cannot be enabled with `systemctl --user enable`. As long as the `[Install]` section is defined, systemd will automatically start the containers.

This also means once the files are removed from the directory, and the daemon is reloaded, the services are gone (unless they are running).

---
## Quadlet in action
![quadlet-run](gifs/quadlet-run.gif)

---
## Where are the gaps?
So far we saw how to manually run a container, how to generate a Quadlet file from a `podman run` command, we have tweaked our WordPress Quadlet files manually, and had them deployed as a pod.

There are a few gaps however:
- Containers were running rootless, however the user running the containers has passwordless sudo rights - user running the containers ideally should be our main user
- We need to keep track of many Quadlet files, perhaps version control, and potentially moving them into and out of the systemd Quadlet folder

