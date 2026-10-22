#!/data/data/com.termux/files/usr/bin/bash
# Omni-Injector Termux Live Verifier
set -e
pkg install -y curl >/dev/null 2>&1 || true
mkdir -p ~/omni-verify
cd ~/omni-verify
ENV_FILE="${1:-keys.env}"
if [ ! -f "$ENV_FILE" ]; then
  echo "Create $ENV_FILE with KEY=value lines, then re-run."
  echo "nano ~/omni-verify/keys.env"
  exit 1
fi
set -a
# shellcheck disable=SC1090
source <(grep -E '^[A-Za-z_][A-Za-z0-9_]*=' "$ENV_FILE" | sed 's/\r$//')
set +a
probe(){ local n="$1"; shift; local c; c=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 20 "$@" || echo ERR); echo "$n → HTTP $c"; }
[ -n "${OPENAI_API_KEY:-}" ] && probe OpenAI -H "Authorization: Bearer $OPENAI_API_KEY" https://api.openai.com/v1/models
[ -n "${XAI_API_KEY:-}" ] && probe xAI -H "Authorization: Bearer $XAI_API_KEY" https://api.x.ai/v1/models
[ -n "${ANTHROPIC_API_KEY:-}" ] && probe Anthropic -H "x-api-key: $ANTHROPIC_API_KEY" -H "anthropic-version: 2023-06-01" https://api.anthropic.com/v1/models
[ -n "${GEMINI_API_KEY:-}" ] && probe Gemini "https://generativelanguage.googleapis.com/v1beta/models?key=$GEMINI_API_KEY"
[ -n "${GROQ_API_KEY:-}" ] && probe Groq -H "Authorization: Bearer $GROQ_API_KEY" https://api.groq.com/openai/v1/models
[ -n "${GITHUB_TOKEN:-}" ] && probe GitHub -H "Authorization: Bearer $GITHUB_TOKEN" -H "Accept: application/vnd.github+json" https://api.github.com/user
[ -n "${STRIPE_SECRET_KEY:-}" ] && probe Stripe -u "$STRIPE_SECRET_KEY:" https://api.stripe.com/v1/balance
[ -n "${HF_TOKEN:-}" ] && probe HF -H "Authorization: Bearer $HF_TOKEN" https://huggingface.co/api/whoami-v2
[ -n "${REPLICATE_API_TOKEN:-}" ] && probe Replicate -H "Authorization: Token $REPLICATE_API_TOKEN" https://api.replicate.com/v1/account
echo "DONE. 200=ACTIVE  401/400=INVALID  429=RATE-LIMITED"
