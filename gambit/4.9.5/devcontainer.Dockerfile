FROM ghcr.io/pcrab/gambit:4.9.5 AS BUILD

FROM mcr.microsoft.com/vscode/devcontainers/base:bookworm AS FINAL
COPY --from=BUILD /usr/local /usr/local
ENV PATH="/usr/local/bin:${PATH}"
