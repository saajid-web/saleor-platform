# Use a specific version of the Saleor image as the base
FROM ghcr.io/saleor/saleor:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and upgrade packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    # Install necessary packages
    curl \
    git \
    build-essential \
    python3-pip \
    python3-dev \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Install application dependencies

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "saleor.wsgi:application"]

