---
title: gitlab migration
date: 2026-04-10 16:42:10
description: The FSR Info moved from GitLab to forgejo. Here is what I learned
slug: gitlab-migration
title-image: /blog/gitlab-migration/title.svg
---

I am part of the computer science student council for the uni Leipzig and one of the things I do there is maintaining the server.
On there we are hosting among other things a gitlab instance where students can upload material that helps other prepare for their exams.

The resources on our server are limited and gitlab is overkill for our usecase, so we wanted to migrate away from it and to forgejo
(Gitlab is an entire company management system and forgejo feels like better software overall). So I said that I would do the migration.
Here I want to give a quick rundown of how it happened because it was surprisingly involved on general Linux knowledge (because I made one "mistake"
at the beginning).

To minimize downtime I did it in small steps and kept the gitlab and forgejo running side by side on different ports when working on it.
First I set up the authentication source but I won't go into detail on that here because I think it is too specific to my case and not that
interesting. I just used the `ldapsearch` tool to get the names of the fields and filled in the according values in the forgejo admin UI.
To transfer the existing repositories I wanted to use the [gitlab-to-forgejo](https://github.com/GEANT/gitlab-to-forgejo) python script.
The one "error" I made in the beginning is to have gitlab running on port 80 and forgejo on port 443 and not the other way around. This 
lead to problems with the tokens in the script because it failed to verify them against the gitlab that tried to call the api on the 
443 post, which failed because there forgejo was listening, not gitlab. In the script we made this change to allow the different ports
on the same url.

```diff
diff --git a/migrate.py b/migrate.py
index bea198e..a4735c8 100755
--- a/migrate.py
+++ b/migrate.py
@@ -93,7 +93,7 @@ def main():
     print()
 
     # private token or personal token authentication
-    gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_TOKEN)
+    gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_TOKEN, keep_base_url=True)
     gl.auth()
     assert isinstance(gl.user, gitlab.v4.objects.CurrentUser)
     fg_print.info(f"Connected to Gitlab, version: {gl.version()[0]}")
```

This lead to some follow-up issues. The repos on forgejo were 
stuck in the intermediate "migrating" state. Therefore we had to figure out how to delete all the repositories again (there are too many
to delete them all by hand). To do that I used the first script I found online 
([shoutout to justyn](https://justyn.io/til/delete-all-repos-from-an-organization-in-forgejo-gitea/)).

```bash
#!/bin/bash

# See https://justyn.io/til/delete-all-repos-from-an-organization-in-forgejo-gitea/ for more informataion

# Change these
FORGEJO_URL=https://git.domain.tld:3000
FORGEJO_USER=justyns
FORGEJO_TOKEN=xxxx
ORG_NAME=mirrors

# List all repositories in the organization
repos=$(curl -s -u $FORGEJO_USER:$FORGEJO_TOKEN "$FORGEJO_URL/api/v1/orgs/$ORG_NAME/repos?limit=100" | jq -r '.[].name')

# Loop through each repository and delete it
for repo in $repos; do
    echo "Deleting repository: $repo"
    echo "^^^ I didn't really delete anything yet.  Remove this line and the next if you are really sure you want to delete _ALL_ repos in $ORG_NAME"
    exit 1
    curl -s -u $FORGEJO_USER:$FORGEJO_TOKEN -X DELETE "$FORGEJO_URL/api/v1/repos/$ORG_NAME/$repo"
done

echo "All repositories have been deleted."
```

This only deleted some at a time because of pagination but I increased the page size and just executed it multiple times.
One the migration script ran successfully (after we switched the ports) I thought it would be smooth sailing from there. But an unexpected issue
were the permissions. The majority of the repos are in one group and everyone that is logged in should be able to see and edit the content.
For that they need to be part of a team that has these permissions. Sadly I didn't find a way to enable people to enter the team themselves or
any hook that is called upon signup of a new user. So instead I wrote a cronjob that runs every 5 minutes and adds the newest 10 users to the team.
I used the api/swagger tool that is shipped with forgejo to get these commands and I found it quite pleasant to use.

```bash
#!/bin/bash
token="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
users=$(curl -X 'GET' \
	"https://git.example.com/api/v1/admin/users?sort=newest&limit=10&token=$token" \
	-H 'accept: application/json')
echo "$users"| jq -r '.[].login' | while read -r username; do
  	curl -X 'PUT' \
  		"https://git.example.com/api/v1/teams/<GROUP_ID>/members/$username?token=$token" \
  		-H 'accept: application/json'
done
```
the systemd service
```systemd
[Unit]
Description=Add the new users to the team

[Service]
Type=simple
ExecStart=/path/to/script.sh
```
the systemd timer
```systemd
[Unit]
Description=Run the script defined in the service with the same name every 5 minutes

[Timer]
OnCalendar=*:0/5:00
Persistent=true

[Install]
WantedBy=timers.target
```

This is probably not the most elegant way but it worked alright for us and why not share it :).
