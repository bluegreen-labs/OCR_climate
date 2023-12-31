# set base docker image to work from
# Tensorflow in this case
FROM nvcr.io/nvidia/tensorflow:23.09-tf2-py3

# create a non-root user named khufkens, 
# give them the password "khufkens" put them in the sudo group
# rename to your local username
RUN useradd -d /home/khufkens -m -s /bin/bash khufkens && echo "khufkens:khufkens" | chpasswd && adduser khufkens sudo

# start working in the "khufkens" home directory
WORKDIR /workspace

# install required python packages
RUN pip install jupyter
RUN pip install matplotlib

# set user to the local username
USER khufkens

# expose outgoing traffic on port 8888
EXPOSE 8888

# In the project run:
#
# docker build -t tensorflow-container .
# docker run --runtime=nvidia -it -p "8888:8888" -v $(pwd):/current_project/ -u $(whoami) tensorflow-container
# 
# Adding -u $(whoami) will make files written by the container have the user permissions
# 
# Start Jupyter notebooks:
# jupyter notebook -port=8888 --ip=0.0.0.0 --allow-root --no-browser .
# browse to http://localhost:8888 to access the notebook
#
# TODO: check user config
