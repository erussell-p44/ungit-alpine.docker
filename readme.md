TODO: Replace this text. This is unrelated info from the old project.

# Docker stuff to try out ungit

The original blog post is here: <http://blog.goguardian.com/nerds/ungit-the-easiest-way-to-use-git>

The original project is here: <https://github.com/FredrikNoren/ungit>

To try this out without installing anything on your machine etc
you can use Docker.

## Quick start with docker

- Install `docker` and `docker-compose`. See docs here: <https://docs.docker.com/engine/installation/>

- Grab this repository

- From command line do:

```
cd <path to this repo>
docker-compose build
docker-compose up -d
```

- In the browser go to <http://localhost:8448/#/repository>

- There is a special path `/vso` which is by default mapped to directory
  in `~/vso` on your machine. This is where you can put all your git repos
  and `ungit` will see them there. See further for optional config.


## Optional config:

- for those running docker with `boot2docker` etc (on OS X or Windows for example)
  set up port forwarding between your machine and the "docker vm".

  See "Forwarding Ports to a Virtual Machine" in this post:
  <http://www.howtogeek.com/122641/how-to-forward-ports-to-a-virtual-machine-and-use-it-as-a-server/>

- change the path where your git repositories are. Edit `docker-compose.yml`
  and add a mapping to `volumes` section.

  For example, to make directory `~/codez/coolproj` available to ungit, you
  can make this volume config:


```
         volumes:
             # add this line
             - ~/codez/coolproj:/codez/coolproj
```
