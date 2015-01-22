* Add Docker repo
* Install lxc-docker
* Modify `/etc/default/docker` to `DOCKER_OPTS="-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"`
* Restart docker service

# Shipyard

Shipyard requires three instances:

* RethinkDB data volume instance
* RethinkDB instance
* Shipyard GUI instance

### Installation

1. Start a data volume instance of RethinkDB:

	`docker run -it -d --name shipyard-rethinkdb-data --entrypoint /bin/bash shipyard/rethinkdb -l`
    
2. Start RethinkDB instance using the data volume container:

	`docker run -it -P -d --name shipyard-rethinkdb --volumes-from shipyard-rethinkdb-data shipyard/rethinkdb`
    
3. Start the Shipyard controller instance:

	`docker run -it -p 8080:8080 -d --name shipyard --link shipyard-rethinkdb:rethinkdb shipyard/shipyard`
    
Shipyard will create a default user account with the username `admin` and the password `shipyard`. You should then be able to open a browser to `http://<your-host-ip>:8080` and see the Shipyard login.

If for any reason things aren't working then use `docker ps -a` to list all the containers on your machine and troubleshoot from there.

### Add an Engine

Shipyard currently has no engines attached, you need to add your Docker hosts engine. Navigate to Engines and click `+ADD`.

`Address` - Should match the IP and port number set under `DOCKER_OPTS` earlier. In this case it's something like `192.168.x.x:4243`.

### Deploy a container

Navigate to the Containers tab and click `DEPLOY`.

