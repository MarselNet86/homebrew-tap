# Homebrew tap for Peekle

[Peekle](https://github.com/MarselNet86/peekle) is Claude Code, answered from
the notch. macOS 13 or newer, Apple silicon and Intel in one build.

```sh
brew install --cask MarselNet86/tap/peekle
peekle init
open -a Peekle
```

The bundle is signed ad hoc rather than notarized, so the cask clears the
quarantine flag after installing; that is what makes the first launch silent.
`brew upgrade --cask peekle` moves to the next release; `brew uninstall --cask
peekle` quits the app and removes it, `--zap` also removes its config and
caches. Take the hooks out of `~/.claude/settings.json` with `peekle
uninstall` first.

## How the cask is kept current

The cask is rendered by Peekle's release workflow from
[`packaging/homebrew/peekle.rb`](https://github.com/MarselNet86/peekle/blob/main/packaging/homebrew/peekle.rb)
and attached to every release as `peekle.rb`. [`bump.yml`](.github/workflows/bump.yml)
copies the one from the latest release into `Casks/` every hour and on demand,
and commits it when it differs. Nothing here is edited by hand; change the
template in the main repository instead. If GitHub has paused the schedule
for inactivity, run the workflow once by hand.
