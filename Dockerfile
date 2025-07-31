# Stage 1: Build Stage 
FROM python:3.11-slim-buster as builder

# Set the working directory inside the container.
WORKDIR /app

# Copy the requirements.txt file into the container's working directory.
COPY requirements.txt .

# Install any needed Python packages.
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final Image Stage
FROM python:3.11-slim-buster

# Set the working directory for the final image
WORKDIR /app

# Copy the installed packages from the builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.9/site-packages

# Copy your application code into the container.
COPY FA_Agent_System.ipynb .

ENV OPENAI_MODEL_NAME='gpt-4-turbo'

# Command to run your application when the container starts.
CMD ["python", "FA_Agent_System.ipynb"]
