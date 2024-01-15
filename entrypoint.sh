# File: docker_phx/entrypoint.sh
#!/bin/bash
# docker entrypoint script.

bin="/app/bin/integration_reports"

# start the elixir application
exec "$bin" "start"