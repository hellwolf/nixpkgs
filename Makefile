UPSTREAM_BRANCH=nixos-22.11

sync:
	git fetch upstream
	git rebase upstream/$(UPSTREAM_BRANCH)

rbi:
	git rebase -i upstream/$(UPSTREAM_BRANCH)

.PHONY: sync rbi
