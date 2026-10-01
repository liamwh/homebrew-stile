# homebrew-stile

Homebrew tap for [stile](https://github.com/liamwh/stile) — the
capability-oriented secret broker. Linux only (x86_64/arm64); the
binaries are static musl builds from stile's GitHub releases.

```console
$ brew tap liamwh/stile
$ brew install stile
```

Installs both binaries:

- `stile` — unprivileged CLI
- `stile-brokerd` — privileged broker daemon (see the main repository's
  systemd example and setup guide)

Security note: stile is early-stage, security-sensitive and not
independently audited. Read
[THREAT_MODEL.md](https://github.com/liamwh/stile/blob/main/THREAT_MODEL.md)
before use.

Updating: formulas are updated per release; `brew update` picks them up.
