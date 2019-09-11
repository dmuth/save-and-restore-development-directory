
# Save and Restore Your Development Directory

If you're like me, you have many projects under a directory called `development/`.
You may even have some nested directories for related projects.  As an example,
here's a fraction of my development directory:

```
./allaboutcheetahs.info/
./diceware/
./docker/check-disk-space/
./docker/health-check/
./node/circuitbreaker-demo/
./node/neural-network/
./s3/bucket-sizes/
./s3/disk-usage/
./snowdrift/
./ssh-to/
```

Each of those projects is something that is checked out from GitHub.

While I do back up my machine with Time Machine, I wanted additional
options, especially in the scenario where I'm not restoring a machine, but
instead *moving* to a new machine.

So I wrote these scripts.  They're relatively straightforward.


## Saving Your Development Directory

Run the `save.sh` script as follows:

`bash <(curl -s https://raw.githubusercontent.com/dmuth/save-and-restore-development-directory/master/save.sh) path/to/development/directory repos.txt`

This will go through your development directory, find every Git repo, 
and write the directory path (relative to the path given above)
and the `origin` Git resource it uses.


## Restoring Your Development Directory

Run the `restore.sh` script as follows:

`bash <(curl -s https://raw.githubusercontent.com/dmuth/save-and-restore-development-directory/master/restore.sh) repos.txt path/to/new/directory`

That will go through the file with directories and repos, and clone each 
of them the target directory, mirroring the directory structure
of the old development directory.


## FAQ

### Q: What if there are multiple remotes on a repo?

A: These scripts do not address this.


### Q: What if a clone in `restore.sh` fails because I didn't have `ssh-agent` set up, etc.?

A: Then the script will stop.


### Q: What if a repo's directory exists due to a previously aborted run of `restore.sh`?

A: If a repo's directory exists, it will be sanity checked to make sure the repo is sane, and then skipped.


## Contact

- <a href="https://twitter.com/dmuth">@dmuth</a> on Twitter
- <a href="https://facebook.com/dmuth">Douglas Muth</a> on Facebook
- Email: doug.muth AT gmail DOT com
- ...or just file an issue on this project!

You can also <a href="https://www.dmuth.org/saving-and-restoring-your-development-directory/">read about these scripts on my blog</a>...







