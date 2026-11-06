#!/usr/bin/env bash
# dashboard.sh — Interactive Rollback Dashboard
# Provides a clean menu to launch any of the 15 production rollback scripts
# and shows basic environment status.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

header() {
  clear
  echo -e "${BOLD}${CYAN}"
  echo "╔══════════════════════════════════════════════════════════════╗"
  echo "║           CITADEL PLATFORM — ROLLBACK DASHBOARD              ║"
  echo "║                 Production Ops Runbook                       ║"
  echo "╚══════════════════════════════════════════════════════════════╝"
  echo -e "${NC}"
  echo -e "  ${YELLOW}$(date -u '+%Y-%m-%d %H:%M:%S UTC')${NC}  |  Host: $(hostname)  |  User: $(whoami)"
  echo
}

check_tool() {
  local tool=$1
  if command -v "$tool" &>/dev/null; then
    echo -e "  ${GREEN}●${NC} $tool"
  else
    echo -e "  ${RED}○${NC} $tool (missing)"
  fi
}

status_panel() {
  echo -e "${BOLD}Environment Status${NC}"
  echo "──────────────────────────────────────────"
  check_tool kubectl
  check_tool helm
  check_tool aws
  check_tool terraform
  check_tool docker
  check_tool jq
  echo

  if command -v kubectl &>/dev/null; then
    CURRENT_CTX=$(kubectl config current-context 2>/dev/null || echo "none")
    echo -e "  Kubernetes context : ${CYAN}${CURRENT_CTX}${NC}"
  fi
  if command -v aws &>/dev/null; then
    AWS_ACCT=$(aws sts get-caller-identity --query Account --output text 2>/dev/null || echo "not authenticated")
    AWS_REGION=$(aws configure get region 2>/dev/null || echo "default")
    echo -e "  AWS Account        : ${CYAN}${AWS_ACCT}${NC}"
    echo -e "  AWS Region         : ${CYAN}${AWS_REGION}${NC}"
  fi
  echo
}

show_menu() {
  echo -e "${BOLD}Select a Rollback Action${NC}"
  echo "──────────────────────────────────────────"
  echo -e "  ${GREEN} 1${NC}) Kubernetes Deployment          ${BLUE}01-k8s-deployment.sh${NC}"
  echo -e "  ${GREEN} 2${NC}) ASG Launch Template            ${BLUE}02-asg-launch-template.sh${NC}"
  echo -e "  ${GREEN} 3${NC}) Terraform State                ${BLUE}03-terraform-state.sh${NC}"
  echo -e "  ${GREEN} 4${NC}) Database Migration             ${BLUE}04-db-migration.sh${NC}"
  echo -e "  ${GREEN} 5${NC}) ALB Traffic Shift              ${BLUE}05-alb-traffic-shift.sh${NC}"
  echo -e "  ${GREEN} 6${NC}) EC2 AMI Replacement            ${BLUE}06-ec2-ami.sh${NC}"
  echo -e "  ${GREEN} 7${NC}) Config File Restore            ${BLUE}07-config-file.sh${NC}"
  echo -e "  ${GREEN} 8${NC}) Helm Release                   ${BLUE}08-helm-release.sh${NC}"
  echo -e "  ${GREEN} 9${NC}) Docker Compose                 ${BLUE}09-docker-compose.sh${NC}"
  echo -e "  ${GREEN}10${NC}) Package Version                ${BLUE}10-package-version.sh${NC}"
  echo -e "  ${GREEN}11${NC}) Route53 DNS                    ${BLUE}11-route53-dns.sh${NC}"
  echo -e "  ${GREEN}12${NC}) Feature Flag / Config          ${BLUE}12-feature-flag.sh${NC}"
  echo -e "  ${GREEN}13${NC}) Systemd Unit                   ${BLUE}13-systemd-unit.sh${NC}"
  echo -e "  ${GREEN}14${NC}) ECS Service                    ${BLUE}14-ecs-service.sh${NC}"
  echo -e "  ${GREEN}15${NC}) Orchestrated Multi-Step        ${BLUE}15-orchestrated-rollback.sh${NC}"
  echo
  echo -e "  ${YELLOW} s${NC}) Show environment status"
  echo -e "  ${YELLOW} h${NC}) Open HTML dashboard in browser"
  echo -e "  ${YELLOW} q${NC}) Quit"
  echo
}

run_script() {
  local num=$1
  local script
  case $num in
    1)  script="01-k8s-deployment.sh" ;;
    2)  script="02-asg-launch-template.sh" ;;
    3)  script="03-terraform-state.sh" ;;
    4)  script="04-db-migration.sh" ;;
    5)  script="05-alb-traffic-shift.sh" ;;
    6)  script="06-ec2-ami.sh" ;;
    7)  script="07-config-file.sh" ;;
    8)  script="08-helm-release.sh" ;;
    9)  script="09-docker-compose.sh" ;;
    10) script="10-package-version.sh" ;;
    11) script="11-route53-dns.sh" ;;
    12) script="12-feature-flag.sh" ;;
    13) script="13-systemd-unit.sh" ;;
    14) script="14-ecs-service.sh" ;;
    15) script="15-orchestrated-rollback.sh" ;;
    *)  echo "Invalid selection"; return ;;
  esac

  if [[ ! -f "$script" ]]; then
    echo -e "${RED}Script $script not found.${NC}"
    return
  fi

  echo
  echo -e "${YELLOW}Launching: $script${NC}"
  echo -e "${YELLOW}You will be prompted for required arguments.${NC}"
  echo
  read -r -p "Press Enter to continue or Ctrl+C to cancel..."

  # Show usage first
  echo
  head -n 8 "$script" | grep -E "^#" || true
  echo
  bash "./$script" || true

  echo
  read -r -p "Press Enter to return to dashboard..."
}

open_html() {
  local html="$SCRIPT_DIR/dashboard.html"
  if [[ -f "$html" ]]; then
    if command -v xdg-open &>/dev/null; then
      xdg-open "$html" &>/dev/null &
    elif command -v open &>/dev/null; then
      open "$html" &>/dev/null &
    else
      echo "Open this file in a browser: $html"
    fi
  else
    echo "dashboard.html not found."
  fi
}

# Main loop
while true; do
  header
  status_panel
  show_menu

  read -r -p "Choice: " choice
  case "$choice" in
    [1-9]|1[0-5]) run_script "$choice" ;;
    s|S) header; status_panel; read -r -p "Press Enter to continue..." ;;
    h|H) open_html ;;
    q|Q) echo "Exiting dashboard."; exit 0 ;;
    *) echo "Invalid choice"; sleep 1 ;;
  esac
done
