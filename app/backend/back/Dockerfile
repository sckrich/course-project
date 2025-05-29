FROM python:3.13-slim

WORKDIR KP/app/backend/back

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 9090

CMD ["python", "manage.py", "runserver", "0.0.0.0:9090"]
