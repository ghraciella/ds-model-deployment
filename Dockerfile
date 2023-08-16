# Use the official Python image as the base image
FROM python:3.10-slim-buster

# Set the working directory
WORKDIR /app

# Copy the application code to the working directory
COPY model.bin /app/
COPY requirements.txt /app/
COPY main.py /app/

# Install the dependencies from requirements.txt NOT requirements_dev.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port
EXPOSE 9696

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9696"]