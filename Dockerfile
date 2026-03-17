FROM python:3.11-slim
 
WORKDIR /app
 
# Install uv
RUN pip install --no-cache-dir uv
 
# Copy config
COPY services/configuration.yaml /app/services/tools_config.yaml
 
# Install the MCP server from PyPI
RUN uv pip install --system snowflake-labs-mcp
 
# Railway assigns PORT dynamically, default to 9000 if not set
ENV PORT=9000
 
# Expose port
EXPOSE ${PORT}
 
# Start script that reads $PORT at runtime
CMD sh -c "uvx snowflake-labs-mcp \
  --service-config-file /app/services/tools_config.yaml \
  --transport streamable-http \
  --port $PORT \
  --server-host 0.0.0.0 \
  --endpoint /snowflake-mcp"