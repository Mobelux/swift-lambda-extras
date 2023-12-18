# Bump Version

A GitHub Action to bump a given version number.

## Inputs

```yaml
inputs:
  current-version:
    description: The current semantic version number.
    required: true
  release-type:
    description: Type of release. Must be one of `patch` | `minor` | `major`.
    required: true
```

## Outputs

```yaml
outputs:
  version:
    description: The new version number.
```

## Example Usage

```yaml
name: Bump Version
on:
  workflow_dispatch:
    inputs:
      release_type:
        description: Type of release
        type: choice
        required: true
        options:
          - patch
          - minor
          - major
jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - name: Git Checkout main
        uses: actions/checkout@v4

      - name: Get latest release version
        id: get_current_version
        uses: actions/github-script@v7
        with:
          script: |
            const { data: { tag_name } } = await github.rest.repos.getLatestRelease({
              owner: context.repo.owner,
              repo: context.repo.repo
            })
            return tag_name

      - name: Bump version
        id: bump
        uses: ./.github/actions/bump-version
        with:
          bump-type: ${{ inputs.release_type }}
          version: ${{ steps.get_current_version.outputs.result }}

      - name: Push tag
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.git.createRef({
              owner: context.repo.owner,
              repo: context.repo.repo,
              ref: 'refs/tags/${{ steps.bump.outputs.version }}',
              sha: context.sha
            })
```

## Acknowledgments

Uses [semver-tool](https://github.com/fsaintjacques/semver-tool)
