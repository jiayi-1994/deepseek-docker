# FROM ollama/ollama


# Use a base image with CUDA support if using GPU, otherwise use Ubuntu
FROM tensorflow/tensorflow:latest-gpu

# Set non-interactive mode to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt update && apt install -y \
    curl \
    git \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh
# RUN ollama -v
# Expose Ollama's default port (if needed)
EXPOSE 11434

# Pull Llama 3 model
# RUN ollama pull llama3
# RUN ollama pull deepseek-r1
# Start Ollama service by default
# CMD ["ollama", "serve"]
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
