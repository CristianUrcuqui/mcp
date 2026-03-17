FROM python:3.11-slim

WORKDIR /app

# Install uv
RUN pip install --no-cache-dir uv

# Copy config
COPY services/configuration.yaml /app/services/tools_config.yaml

# Install the MCP server from PyPI
RUN uv pip install --system snowflake-labs-mcp

# Expose port
EXPOSE 9000

# Start MCP server in streamable-http mode
CMD ["uvx", "snowflake-labs-mcp", \
     "--service-config-file", "/app/services/tools_config.yaml", \
     "--transport", "streamable-http", \
     "--endpoint", "/snowflake-mcp"]