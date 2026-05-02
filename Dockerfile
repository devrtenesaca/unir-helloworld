# Use a slim Python image
FROM python:3.11-slim

# Install Java (JRE) and wget
RUN apt-get update && apt-get install -y default-jre wget && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download WireMock JAR
RUN wget https://repo1.maven.org/maven2/org/wiremock/wiremock-standalone/3.3.1/wiremock-standalone-3.3.1.jar -O /opt/wiremock.jar

# Copy the project files
COPY . .

# Expose both ports
EXPOSE 5000 9090

# Make sure the entrypoint script is executable
RUN chmod +x entrypoint.sh

# Start the services
ENTRYPOINT ["./entrypoint.sh"]