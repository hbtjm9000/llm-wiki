#!/usr/bin/env bash

# Idempotent deployment script for worker processes
# Exit codes: 0=success, 1=error, 2=no changes

set -euo pipefail

# Ensure we are on the master branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$current_branch" != "master" ]]; then
  echo "Not on master branch (currently on $current_branch). Exiting."
  exit 1
fi

# Detect if there are any changes to commit
if ! git diff --quiet || ! git diff --cached --quiet; then
  # Stage all changes
  git add .
  # Commit with timestamp
  commit_msg="Production update: $(date +'%Y-%m-%d %H:%M:%S')"
  git commit -m "$commit_msg"
  # Push to origin if remote exists
  if git remote get-url origin >/dev/null 2>&1; then
    git push origin master
    echo "Changes committed and pushed."
  else
    echo "Changes committed locally (no remote configured)."
  fi
else
  echo "No changes to deploy."
  exit 2
fi

# Ensure worker.py logging is configured (Python-based worker)
worker_path="/home/hbtjm/library/queue_manager.py"
if [[ -f "$worker_path" ]]; then
  echo "Python-based queue_manager.py found - logging handled via worker.log"
else
  echo "queue_manager.py not found at $worker_path" >&2
fi

# Ensure logrotate config exists
logrotate_conf="/home/hbtjm/library/logrotate.conf"
if [[ ! -f "$logrotate_conf" ]]; then
  cat > "$logrotate_conf" <<'EOF'
/home/hbtjm/library/worker.log {
    daily
    rotate 14
    compress
    missingok
    notifempty
}
EOF
  echo "Created logrotate configuration."
else
  echo "logrotate.conf already exists."
fi

# Send notification (using AgentMail send_message if configured)
if command -v send_message >/dev/null 2>&1; then
  send_message inboxId="${AGENTMAIL_INBOX_ID:-}" to="${AGENTMAIL_ALERT_RECIPIENT:-}" subject="Deploy Worker completed" text="Deployment script executed successfully."
  echo "Notification sent via send_message."
else
  echo "send_message command not available; skipping notification."
fi

exit 0
