FROM python:3.7.0
WORKDIR /home/renderserver
COPY . ./
RUN chown -R root:root /home/renderserver
RUN chown -R root:root /usr/local/lib/python*
RUN apt-get update && apt-get install libgl1 -y
RUN python -m pip install --upgrade pip
RUN pip install --upgrade pip wheel future-fstrings
RUN pip install cmake==3.22.0
RUN pip install bpy==2.91a0 && bpy_post_install
RUN pip install django==3.2.15
RUN pip install djangorestframework==3.13.1
RUN pip install google-cloud-storage==2.5.0
RUN cp -r /usr/local/lib/python3.7/site-packages/2.91 /usr/local/lib/python3.7
ENV DJANGO_SETTINGS_MODULE=building_render.settings.prod
CMD ["python", "./manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000
