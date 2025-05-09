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

- [Unit]: here we ask for other systemd services that should start, and what order to start them in
- [Pod]: there is where the Podman configuration for the pod goes
- [Install]: this allows `wordpress-pod.service` service to start automatically (if enabled)

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

- [Unit]: here we ask for other systemd services that should start, and what order to start them in - we also tie this service to `wordpress-pod.service`
- [Container]: this is the Podman configuration for the container - name, environment variables, image path are all defined here

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
This command asks systemd to parse the Quadlet files, if it dumps a bunch of text with no errors then the parse was successful.

---
## Getting started with Quadlet
### Running

Once systemd parses the Quadlet files, it creates the corresponding services automatically. All thats left to do is `systemctl --user start wordpress-pod.service`.

Quadlet generated systemd services are transient, so they cannot be enabled with `systemctl --user enable`. As long as the `[Install]` section is defined, systemd will automatically start the containers.

This also means once the files are removed from the directory, and the daemon is reloaded, the services are gone (unless they are running).

---
## Quadlet in action
![quadlet-run](gifs/quadlet-run.gif)
