R projects to reproduce research results
==================================================

This is an R project to reproduce the research results in R using Git/GitHub, Docker, RStudio, and R package `checkpoint`.

The DOI of the research article that has relevance to this repository is [10.1000/xyz123](https://).

# 1. Features of this R project
- Git/GitHub
   - [Git](https://git-scm.com/) for source code version control
   - [GitHub](https://github.com/) for publish datasets and source code
- Docker/Docker Compose
   - Using Docker container image [`rocker/rstudio`](https://hub.docker.com/r/rocker/rstudio) containing R and RStudio Server
   - Reproduce the same working environment, including Linux distribution and libraries, R and RStudio versions, etc.
   - Manage container startup settings in the `compose.yml` file.
- Make
   - Customize the startup commands with the `Makefile`
   -  Start and stop the working environment with just `make up` and `make down` commands
- R package [`checkpoint`](https://cran.r-project.org/web/packages/checkpoint/index.html)
   - Create and manage project-specific libraries 
   - Install packages as they existed on CRAN on a specific snapshot date
   - Mount package cache from Docker hosts
- dotfiles
   - Manage RStudio and Git global configuration files in the dotfiles directory
   - Mount and use configuration files from Docker hosts to containers
   - Settings are maintained even when the container is stopped

# 2. Usage
## 2.1. Initial settings
1. Install Docker, Git, and Make.
2. Set up a connection to GitHub.
3. Clone the GitHub repository of this R project to an appropriate location in your local environment.

## 2.2. From startup to shutdown of the work environment
The following steps assume that the Docker daemon is running.

1. When you start your work, Run the `make up` command in the directory of this R project.
2. Open <http://localhost:8787> in a browser and connect to RStudio Server.
3. Open the [`research.Rproj`](./research.Rproj) file in RStudio Server.
4. Open the [`codes`](./codes/) folder on RStudio Server and perform analysis.
5. When you finish your work, run the `make down` command in this R project directory.

Note: To see a list of make commands, run the `make` command in the directory of this R project.

# 3. Optional settings
## 3.1. Create a `.env` file
To set the environment variables, you need to copy the [`.env.example`](./.env.example) file and create a `.env` file based on it. An `.env` file has been excluded from Git management by a [`.gitignore`](./.gitignore) file in advance.

## 3.2. Share your settings between projects via universal dotfiles
By default, RStudio and Git global settings are configured in [`dev/dotfiles/`](./dev/dotfiles) folder, such as `.config/rstudio/rstudio-prefs.json` or `.gitconfig`.
However, this folder is used on a project-specific basis, so the settings are not reflected in other projects.

If you want to share your settings among multiple projects, copy the project-specific [`dev/dotfiles/`](./dev/dotfiles) and create a universal dotfiles directory (e.g. `~/rproject-dotfiles`) on your machine based on it.
Once the universal dotfiles directory is created, specify its path in the environment variable `DOTFILES_ROOT` in the `.env` file.

In addition, dotfiles can be managed as a GitHub repository to synchronize settings among multiple machines.

## 3.3. Use Git and GitHub on RStudio in the container
### 3.3.1. Setting up your username and email address
Open the Terminal pane in RStudio and run the following commands to set up a user name and email address for Git in the container:

```sh
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

This configuration is written to the `.gitconfig` file in `dotfiles`.

### 3.3.2. Setting up SSH private key
Store the SSH private key for connecting to GitHub on the Docker host machine. Specify the file path of the private key (e.g. `~/.ssh/id_ed25519`) in the `GITHUB_SSH_IDENTITY` environment variable in `.env` to mount the private key in the container and allow SSH connections to GitHub from inside the container.
