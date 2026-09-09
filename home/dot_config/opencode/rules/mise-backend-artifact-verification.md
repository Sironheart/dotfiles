# Mise backend artifact verification

Before moving a tool install into mise (aqua/github/ubi/http/asdf), verify the chosen backend publishes installable artifacts for every target OS/arch the image or host must support. Aqua `supported_envs` (and similar registry metadata) is authoritative — a package that exists in `mise search` can still be darwin-only. If Linux-only artifacts are deb/rpm with no zip/tar/binary, keep distro package install (e.g. dpkg) instead of forcing a mise backend.
