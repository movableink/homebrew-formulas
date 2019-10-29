# movableink/homebrew

Repository for custom brews.

We use a custom homebrew 'tap' for a couple of different cases:

* qt and qt-webkit - we build our own custom versions of qt and qtwebkit to support some proprietary features for capturama
* postgres - homebrew aggressively upgrades postgres, and we want to keep everyone nearer to the same version
* nsq - we maintain a version of NSQ that is compatible with the NSQ that we run in production

## Using the tap

```bash
brew tap movableink/formulas
```

## Adding a new formula

Copy the formula from the `homebrew-core` repo to `Formula/formula-name.rb`, or create your own from scratch. Create a pull request, get it approved and merged. Your formula will then be available as `movableink/formulas/formula-name`.

## Bottling

Small formula that are quick to build are fine to build from source each time and don't need a 'bottle' (pre-built binary). If your formula takes a long time to build, a bottle can speed up installation. First get your formula installing correctly without the bottle. Then:

```bash
brew reinstall --build-bottle formula-name
brew bottle --root-url https://movableink-homebrew-formulas.s3.amazonaws.com formula-name
```

This will create a tarball of the built formula and generate a ruby block to add to the formula. Upload the tarball to s3:

```bash
s3cmd put -M -P formula-name-version.tar.gz s3://movableink-homebrew-formulas/
```

Note that "rebuilds" (re-bottling the same version) will append a rebuild version to the tarball which should be accompanied by the rebuild directive in the ruby block.

Lastly, add the ruby block to the formula and open a PR.
