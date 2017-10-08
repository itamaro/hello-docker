FROM python:3.6
ADD requirements.txt /usr/src/
RUN pip install -r /usr/src/requirements.txt
WORKDIR /usr/src/app
ADD echo.py .
ENTRYPOINT ["python", "echo.py"]
