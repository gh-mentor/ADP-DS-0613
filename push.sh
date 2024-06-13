# This shell script uses git 2.30 or higher command to stage, commit, and push all changes in the current repository to the main branch of the repository.

# Stage all changes in the repository.
git add .

# Commit all changes in the repository.
git commit -m "Update"

# Push all changes in the repository to the main branch of the repository.
git push origin main

