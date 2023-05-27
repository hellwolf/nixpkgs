UPSTREAM_BRANCH=nixos-23.05
LOCAL_CLONE_PATH=/var/lib/nixpkgs/$(shell git rev-parse --abbrev-ref HEAD)
LOCAL_CLONE_DEPTH=5

sync-upstream:
	git fetch upstream

sync-local:
	cd $(LOCAL_CLONE_PATH) && \
	git pull --depth $(LOCAL_CLONE_DEPTH) --rebase origin && \
	{ git branch; du -sh .; git log; }

sync-local-init:
	git clone --depth $(LOCAL_CLONE_DEPTH) file://$(PWD) $(LOCAL_CLONE_PATH)

rbi:
	git merge upstream/$(UPSTREAM_BRANCH)
	git rebase -i upstream/$(UPSTREAM_BRANCH)

.PHONY: sync-* rbi
