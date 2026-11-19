---
name: container-images
description: When writing Dockerfiles, image build steps, or fixing Dockerfile scanner findings (Trivy DS-*, Checkov CKV_DOCKER_*) — fix findings in the image instead of ignoring them, and set image labels from build-time values only.
---

# Container images

## Dockerfile findings: fix in the image

Do **not** trivyignore / checkov-skip Dockerfile rules that the image can satisfy:

- **USER / CKV_DOCKER_3 / DS-0002** — add `USER` with a non-root UID (`USER 65532` on scratch). Exception: images used as a GitLab CI job `image:` (runner clones and the job writes into the build dir) stay root; ignore the rule with that reason instead.
- **App health** — `GET /healthz` on the HTTP server, not a CLI in `main` and not a `healthcheck.go`. Kubernetes `httpGet` probes that path.
- **HEALTHCHECK / DS-0026** — skip on `FROM scratch` (no wget/shell; no health client in `main`). Do not switch to Alpine for wget.

Skip only true false positives or vulns with no fix (document the rule ID + reason).

## Image labels: build-time values only

- Images are usually built once per commit and later retagged/promoted (e.g. `crane tag` to the git tag). Labels are baked in at build time and do not change on retag.
- Do not set labels from release-time values (`org.opencontainers.image.version` from `$CI_COMMIT_TAG`, `ref.name` from the final tag). They would be missing or wrong on the promoted image.
- Use values fixed by the commit/build: `source`, `url`, `revision` (`$CI_COMMIT_SHA`), `created`, `title`.
- Before adding a release-derived label, check how the repo publishes release tags.
