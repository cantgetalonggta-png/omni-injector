# Termux — exact steps

```bash
pkg install -y curl
mkdir -p ~/omni-verify && cd ~/omni-verify
nano keys.env
```

Paste real keys as KEY=value, save (CTRL+O Enter CTRL+X), then:

```bash
curl -sL -o termux_verify.sh https://raw.githubusercontent.com/cantgetalonggta-png/omni-injector/main/termux_verify.sh
chmod +x termux_verify.sh
./termux_verify.sh keys.env
```

**200 = ACTIVE. 401/400 = fake/revoked.**
