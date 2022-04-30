FROM rocker/rstudio:4.2.0

# Install apt packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     ssh \
     libxt-dev \
     libxml2-dev \
     libgit2-dev \
     libfontconfig1-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN install2.r -e -s -n -1 \
     checkpoint \
     pacman \
     rmarkdown \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Add github.com to known_hosts in SSH
RUN mkdir -p /home/rstudio/.ssh \
  && ssh-keyscan -t rsa, ed25519 github.com > /home/rstudio/.ssh/known_hosts \
  && chown -R rstudio:rstudio /home/rstudio \
  && chmod 700 /home/rstudio/.ssh

# Copy the configuration files
COPY --chown=rstudio:rstudio .Renviron /home/rstudio/.Renviron
COPY --chown=rstudio:rstudio .ssh/config /home/rstudio/.ssh/config

# Copy the startup script
COPY startup.sh /startup

# Change the startup command
CMD [ "/startup" ]
