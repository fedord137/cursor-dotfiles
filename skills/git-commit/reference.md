# Conventional Commits — reference for git-commit skill

Source: [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)

## Commit format (full)

```text
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

## Types (Angular / commitlint set)

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation |
| `style` | Formatting, no logic |
| `refactor` | Neither feat nor fix |
| `perf` | Performance |
| `test` | Tests |
| `build` | Build / deps |
| `ci` | CI configuration |
| `chore` | Other maintenance |

## Breaking changes

- `feat!:` or `feat(scope)!:` in subject, **or**
- Footer: `BREAKING CHANGE: description`

## Branch naming (convention, not in spec)

The spec defines **commit** types, not branches. This skill maps:

```text
branch = <commit-type>/<kebab-slug>
```

So `feat/foo-bar` pairs with `feat: …` or `feat(scope): …`.

## Revert commits

```text
revert: summary of revert

Refs: <sha1>, <sha2>
```

## SemVer mapping

| Commits landed | Version bump |
|----------------|--------------|
| `fix` | PATCH |
| `feat` | MINOR |
| any + BREAKING CHANGE | MAJOR |
