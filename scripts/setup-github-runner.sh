#!/bin/bash
set -e

# Install a GitHub Actions self-hosted runner on this VM.
# Run inside the Vagrant VM: bash scripts/setup-github-runner.sh

REPO="Rajandeep1/Module4-devops-activity2"
RUNNER_VERSION="2.323.0"
RUNNER_DIR="$HOME/actions-runner"
LABELS="linux,vagrant-vm"

if [[ -z "${GITHUB_RUNNER_TOKEN:-}" ]]; then
  echo "Get a registration token from:"
  echo "  https://github.com/${REPO}/settings/actions/runners/new"
  echo ""
  read -rsp "Paste the runner registration token: " GITHUB_RUNNER_TOKEN
  echo ""
fi

sudo apt-get update
sudo apt-get install -y curl jq docker.io
sudo usermod -aG docker "$USER"

mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

if [[ ! -f ./config.sh ]]; then
  curl -fsSL -o actions-runner.tar.gz \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
  tar xzf actions-runner.tar.gz
  rm actions-runner.tar.gz
fi

./config.sh \
  --url "https://github.com/${REPO}" \
  --token "$GITHUB_RUNNER_TOKEN" \
  --name "vagrant-vm-runner" \
  --labels "$LABELS" \
  --unattended \
  --replace

sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status

echo ""
echo "Runner installed. It should appear as online in GitHub:"
echo "  https://github.com/${REPO}/settings/actions/runners"
echo ""
echo "Log out and back in (or run: newgrp docker) so Docker works without sudo."
