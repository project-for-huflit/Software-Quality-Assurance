## Git branching model

![model-](../server/image.png)

### The central repo holds two main branches with an infinite lifetime

- main
- develop

Note 1: origin/main to be the main branch where the source code of HEAD always reflects a production-ready state.

Note 2: origin/develop to be the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release.

Note 3: all of the changes should be merged back into main somehow and then tagged with a release number.

### Supporting branches

The different types of branches we may use are:

- Feature branches
- Release branches
- Hotfix branches

### Feature branches

1. May branch off from:

- develop

2. Must merge back into:

- develop

3. Branch naming convention:

- anything except master, develop, release-exp, or hotfix-exp

4. Feature branches typically exist in developer repos only, not in origin.

- example: "Creating a feature branch"

```
$ git checkout -b myfeature develop
Switched to a new branch "myfeature"
```

- example: "Incorporating a finished feature on develop"

```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```

### Release branches

1. May branch off from:

- develop

2. Must merge back into:

- develop and main

3. Branch naming convention:

- release-exp

- example: "Creating a release branch"

```
$ git checkout -b release-1.2 develop
Switched to a new branch "release-1.2"
$ ./bump-version.sh 1.2
Files modified successfully, version bumped to 1.2.
$ git commit -a -m "Bumped version number to 1.2"
[release-1.2 74d9424] Bumped version number to 1.2
1 files changed, 1 insertions(+), 1 deletions(-)
```

- example: "Finishing a release branch"

```
$ git checkout main
Switched to branch 'main'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2
```

- NOTE: "To keep the changes made in the release branch, we need to merge those back into develop"

```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
```

- NOTE: "If we don’t need it anymore"

```
$ git branch -d release-1.2
Deleted branch release-1.2 (was ff452fe).
```

### Hotfix branches

1. May branch off from:

- main

2. Must merge back into:

- develop and main

3. Branch naming convention:

- hotfix-exp

- NOTE: When a critical bug in a production version must be resolved immediately, a hotfix branch may be branched off from the corresponding tag on the main branch that marks the production version.

- example: "Creating the hotfix branch"

```
$ git checkout -b hotfix-1.2.1 master
Switched to a new branch "hotfix-1.2.1"
$ ./bump-version.sh 1.2.1
Files modified successfully, version bumped to 1.2.1.
$ git commit -a -m "Bumped version number to 1.2.1"
[hotfix-1.2.1 41e61bb] Bumped version number to 1.2.1
1 files changed, 1 insertions(+), 1 deletions(-)
```

- example: "after fix the bug and commit the fix in one or more separate commits"

```
$ git commit -m "Fixed severe production problem"
[hotfix-1.2.1 abbe5d6] Fixed severe production problem
5 files changed, 32 insertions(+), 17 deletions(-)
```

- example: "Finishing a hotfix branch"

```
$ git checkout master
Switched to branch 'master'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2.1
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
```

NOTE: The one exception to the rule here is that, when a release branch currently exists, the hotfix changes need to be merged into that release branch, instead of develop. Back-merging the bugfix into the release branch will eventually result in the bugfix being merged into develop too, when the release branch is finished. (If work in develop immediately requires this bugfix and cannot wait for the release branch to be finished, you may safely merge the bugfix into develop now already as well.)

- example: "remove the temporary branch if you want"

```
$ git branch -d hotfix-1.2.1
Deleted branch hotfix-1.2.1 (was abbe5d6).
```
