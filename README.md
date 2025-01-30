# Welcome to EASY AI Docker WORLD!
  
---

### **Docker Compose Configuration Breakdown**

#### 1. **Version**
```yaml
version: '3.4'
```
- This specifies the version of Docker Compose you are using. Ensure it matches or is compatible with your Docker setup.

---

#### 2. **Services**

##### **OpenWebUI Service**
```yaml
services:
    openwebui:
        image: ghcr.io/open-webui/open-webui:main
```
- Uses the official [OpenWebUI image](https://github.com/OPenWebUI/open-webui) which provides a web-based interface for interacting with AI models.
- `restart: unless-stopped` ensures the service restarts if interrupted (e.g., by Ctrl+C).
- `depends_on: - ollamadeepseek` specifies that OpenWebUI depends on the Ollama DeepSeek service to function properly. If this service fails to start, OpenWebUI will not start either.
- **Ports:** Maps port 8333 (used by OpenWebUI) to port 8080 (used by your application).
- **Volumes:** mounts your project's `open-webui` directory to the host's `/app/backend/data` location. This is where OpenWebUI stores its configuration files and data.

##### **Ollama DeepSeek Service**
```yaml
    ollamadeepseek: 
        build:
            context: .
            dockerfile: Dockerfile
```
- This service runs the Ollama DeepSeek server, which allows you to interact with an Ollama model through a web interface.
- `restart: unless-stopped` ensures the service restarts if interrupted.

##### **Environment Variables**
```yaml
        environment:
            OLLAMA_BASE_URL: ollamadeepseek
```
- Sets the base URL for Ollama services (e.g., for accessing tokens or configuration files).

#### 3. **Ports**
```yaml
        ports:
          - './open-webui:/app/backend/data'
```
- **OpenWebUI Port Mapping:** Maps port 8333 on your local machine to port 8080 of the OpenWebUI service. This allows data and requests to flow between your application (running on port 8080) and OpenWebUI.
- **Volumes:** mounts your project's `open-webui` directory to the host's `/app/backend/data` location.

#### 4. **Volumes**
```yaml
        volumes:
          - './open-webui:/app/backend/data'
```
- **OpenWebUI Volumes:** Specifies that files in your project's `open-webui` directory should be mounted to the host's `/app/backend/data` location. This is where OpenWebUI stores its configuration and data.

#### 5. **Environment Variables for Ollama**
```yaml
        environment:
            OLLAMA_HOST: 0.0.0.0
            OLLAMA_PORT: 8080
```
- `OLLAMA_HOST`: Specifies the hostname used by the Ollama service.
- `OLLAMA_PORT`: Specifies the port used by the Ollama service.

---

### **How It Works Together**
1. **OpenWebUI** runs first and maps its ports to your application's ports.
2. **Ollama DeepSeek** runs next, using the environment variables (e.g., `OLLAMA_HOST` and `OLLAMA_PORT`) to connect to Ollama services.
3. OpenWebUI communicates with Ollama through JSON-RPC requests on port 8080.

---

### Example Workflow
- **OpenWebUI:** Runs and provides a web interface for interacting with your model (e.g., entering prompts in the chat interface).
- **Ollama DeepSeek:** Allows you to query an external Ollama server using the OpenWebUI interface.
- **Volumes:** Ensure that configuration files and data are persistently available between services.

---

### Common Issues to Watch For
1. Ensure all services are running before starting OpenWebUI.
2. Verify that ports 8333 (OpenWebUI) and 8080 (Ollama DeepSeek) are correctly mapped in your host machine.
3. Check that environment variables like `OLLAMA_HOST` and `OLLAMA_PORT` match those configured in Ollama services.

This configuration provides a simple way to integrate OpenWebUI with an Ollama DeepSeek service using Docker Compose, allowing you to work with AI models through a web interface.
