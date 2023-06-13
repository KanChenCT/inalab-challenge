# Solution

## "Dockerizing" the Application
A Dockerfile consisting of the application and it's dependencies was created. The application itself was also updated to support the injection of an optional string pulled from the environment variable `GREETING`. If the environment variable `GREETING` is unset, then the default greeting of _Hello, World!_ is used instead.

_Before proceeding, first verify you have Docker Desktop installed (which includes Docker Engine, Docker CLI, and Docker Compose). Install instructions can be found [here](https://docs.docker.com/engine/install/)._

Build and Run
-----
Run `docker compose up` from the top level directory of this repository and Docker will run all services defined in the `compose.yaml` file.

Note that the `GREETING` environment variable has been set in L27 of the `compose.yaml` file. If left empty, the application will use the default greeting of _Hello, World!_. To leave it empty and unset it, simply edit that line to read `GREETING: `

Navigate to <http://localhost:5000/> to see the custom greeting.

## Data Parsing Script

_Before proceeding, first verify you have `curl` and `jq` installed. If using a Mac, both can be installed with Brew `brew install curl && brew install jq`. If using another distribution of Linux, use the appropriate package manager for your distribution (e.g. `apt-get` for Ubuntu, or `yum` for RHEL/CentOS/AmazonLinux)_

Verify that you have completed the steps listed under **Build and Run**, so there is a running application for the script to retreive data from.

Open a new terminal window and run the script from the top level directory: `./retreive_data.sh`

The script will download the json data from `/data` endpoint of the flask application and create files per the initial instructions provided. The files will be created in the `files/` directory. 

A test has been included to verify that the SHA256 sum of each file's contents matches the name of the file. If the sum does not match, a `WARNING` message will be printed to STDOUT. Example shown below:

![Screen Shot 2023-06-13 at 2 13 57 PM](https://github.com/KanChenCT/inalab-challenge/assets/136380839/f905eb07-1e3e-4380-96e1-a763c6d75b59)

## Reverse Proxy Configuration
Nginx was chosen and configured as a reverse proxy for the application. The nginx service/image was included in the `compose.yaml` file, along with specific configuration values that allow it to proxy traffic to the backend flask application.

Similar to the previous step under **Build and Run**, first run `docker compose up` from the top level directory of this repository to run all services (including the reverse proxy) if you haven't already.

Navigate to <http://localhost:8000/> to see it in action.

Note that any URI paths, such as `/data` will also be preserved and proxied to the backend as well. Try it here: <http://localhost:8000/data>.
