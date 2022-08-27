# Based on lightweight python image
FROM python:3.10-slim

# Update pip to the latest version
RUN pip install --upgrade pip

# Copy the list of dependencies to be installed
COPY requirements.txt .

# Install the dependencies using pip
RUN pip install --no-cache-dir -r requirements.txt

# Allow external entities to access port 8000 of the container
EXPOSE 8000

# Start a web session
CMD deez-web.py
