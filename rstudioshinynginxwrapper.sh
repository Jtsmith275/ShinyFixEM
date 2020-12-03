#!/bin/bash
# R/RStudio/Shiny-Server/nginx on Ubuntu

# Configure nginx with RStudio-Server and Shiny-Server virtualhosts
sudo cp default /etc/nginx/sites-enabled/default

# Configure Shiny-Server
sudo cp shiny-server.conf /etc/shiny-server/shiny-server.conf
sudo sed -i "s/run_as shiny/run_as $USER/" /etc/shiny-server/shiny-server.conf
sudo sed -i "s/site_dir \/srv\/shiny-server/site_dir \/home\/$USER\/shiny/" /etc/shiny-server/shiny-server.conf
mkdir $HOME/shiny

# Copy sample apps to users new Shiny dir
cp -r /opt/shiny-server/samples/sample-apps/hello/ ~/shiny

# Restart services
sudo systemctl restart nginx
sudo systemctl enable nginx
sudo systemctl restart shiny-server

#Tell user everything works
echo "nginx is now hosting a webpage on http://127.0.0.1"
echo "RStudio Server is now available on http://127.0.0.1:8787 & http://127.0.0.1/rstudio"
echo "Shiny Server is now available on http://127.0.0.1:3838 & http://127.0.0.1/shiny"
