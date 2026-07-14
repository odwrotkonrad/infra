# Purpose

## What It Is

The `restricted` group as code: Terraform IaC owning the separate top-level `restricted` group tree (its `infra` project, branch protection) plus the sandbox identity it holds: a GitLab `konradodwrot` group access token (Developer, write, no delete), a shared sandbox SSH key, a least-privileged GCP service account, and the GCP Secrets Manager secrets those flow through. State lives in its own GCS bucket, isolated from git-repos.

## Why It Exists

GitLab permission inheritance is additive-only: a write token on `konradodwrot` inherits write into every subgroup, so it cannot be kept out of a subgroup. The only way to hold a write token that agents cannot reach is to keep that token, and the identity around it, in a group entirely outside the `konradodwrot` subtree. This repo is that group's single source of truth, applied by your own identity, never by a sandbox.

## Goals

- One repo owns the whole `restricted` group tree and the sandbox identity.
- Sandbox identity is code: GitLab token, SSH key, GCP SA, Secrets Manager secrets.
- Least privilege: the GCP SA reads only its two secrets; the GitLab token is Developer (write, no delete) and cannot reach `restricted`.
- State isolated at the storage boundary: a separate GCS bucket from git-repos.
- Nothing secret committed: every sensitive value lives in Secrets Manager / op, every sensitive attr is masked.
