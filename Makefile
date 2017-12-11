.PHONY=server deploy

server:
	hugo server

clean:
	rm -rf public
	mkdir public
	git worktree prune
	rm -rf .git/worktrees/public/

publish: clean
	# make sure that everything is clean and pushed
	git diff-files --quiet
	git push origin master

	git worktree add -B gh-pages public origin/gh-pages
	rm -rf public/*
	hugo
	cd public && git add --all && git commit -m "Publishing to gh-pages" && cd ..
	git push origin gh-pages
