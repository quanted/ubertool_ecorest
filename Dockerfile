# qed_py3 is debian linux with buildpack-deps
# updated with all needed qed python dependencies
# Use 'version' ARG for grabbing correct qed_py3 base image.
# Defaults to 'latest' if not set.
FROM quanted/qed_py3:mc3.8_3.1.4

# Overwrite the uWSGI config
COPY uwsgi.ini /etc/uwsgi/

COPY . /src/
WORKDIR /src
EXPOSE 7777 8080

# Install UWSGI
RUN conda install -n pyenv -c conda-forge --force-reinstall -y uwsgi xarray numpy netCDF4 importlib_metadata=3.8.1
ENV PYTHONPATH $PYTHONPATH:/src:/src/pram_flask/ubertool/ubertool

RUN chmod 755 /src/start_flask.sh

CMD ["sh", "/src/start_flask.sh"]
