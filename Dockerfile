FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy dependencies first (for better caching)
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Expose the Django port
EXPOSE 8000

# Run migrations automatically, then start the server
