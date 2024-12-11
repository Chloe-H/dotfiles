# Temporary Containers

Workspace for the fiddling I've been doing with Temporary Containers.

## Logging in to add-ons

In the "General" tab, disable "Automatic Mode". You _may_ also need to open a
new tab in the default container.
<!-- TODO: Confirm whether opening a new tab in the default container is necessary -->

## Regular expressions

**Template:** `/^(https://)?([^\s/]+\.)*?( TODO )\b(/.*)?$/`

### Template breakdown

- `/` - leading and trailing forward slash indicates to Temporary Containers
    that this is a regular expression
- `^` - start of line
- `(https://)?` - `https`, optionally
- `([^\s/]+\.)*?` - optional subdomain bs (not white space or forward slash)
- `( TODO )` - core domain pattern
- `\b(/.*)?` - word boundary, optional query parameters; trying to protect
    against matching the domain when it appears in the query parameters of a
    URL to a different domain
- `$` - end of line

Testing in [regular expressions 101](https://regex101.com/) with `gm` flags.
Requires escaping backslashes (Temporary Containers does not require this,
somehow).

## Per domain isolation patterns

As ordered in Temporary Containers (Options > Isolation > Per Domain).

- **Work:** `/^(https://)?((([^\s/]+\.)*?([REDACTED]|myworkday)\.com)|([REDACTED]-com\.access\.mcas\.ms)|(([^\s/]+\.)*?(live|microsoft(online)?|office|one(drive|note)|outlook|sharepoint|visualstudio|windowsazure)\.com(\.mcas\.ms)?)|(statics\.teams\.cdn\.office\.net)(\.mcas\.ms)?)\b(/.*)?$/`
    - **Microsoft:** `/^(https://)?([^\s/]+\.)*?(live|microsoft(online)?|office|one(drive|note)|outlook|sharepoint|visualstudio|windowsazure)\.com(\.mcas\.ms)?\b(/.*)?$/`
    - **Teams:** `/^(https://)?(statics\.teams\.cdn\.office\.net)(\.mcas\.ms)?\b(/.*)?$/`
    - **Company-specific:** `/^(https://)?((([^\s/]+\.)*?([REDACTED]|myworkday)\.com)|([REDACTED]-com\.access\.mcas\.ms))\b(/.*)?$/`
- **Microsoft:** `/^(https://)?((([^\s/]+\.)*?(live|microsoft(online)?|office|one(drive|note)|outlook|sharepoint|visualstudio|windowsazure)\.com)|(statics\.teams\.cdn\.office\.net))\b(/.*)?$/`
    - **Microsoft:** `/^(https://)?(([^\s/]+\.)*?(live|microsoft(online)?|office|one(drive|note)|outlook|sharepoint|visualstudio|windowsazure)\.com)\b(/.*)?$/`
    - **Teams:** `/^(https://)?(statics\.teams\.cdn\.office\.net)\b(/.*)?$/`
- **Google:** `/^(https://)?([^\s/]+\.)*?(google(usercontent)?|youtube)\.com\b(/.*)?$/`
- **Slack:** `/^(https://)?([^\s/]+\.)*?slack\.com\b(/.*)?$/`
- **Amazon/AWS:** `/^(https://)?([^\s/]+\.)*?(aws(apps|\.amazon)?)(\.com)?\b(/.*)?$/`
- **Bitbucket/Atlassian:** `/^(https://)?([^\s/]+\.)*?(atlassian\.(net|com)|bitbucket\.org)\b(/.*)?$/`
- **Firefox/Mozilla:** `/^(https://)?([^\s/]+\.)*?((firefox\.com)|(mozilla((\.org)|(\.auth0\.com))))\b(/.*)?$/`
- **Twitter, currently known as X:**  `/^(https://)?([^\s/]+\.)*?((twitter|x)\.com)\b(/.*)?$/`
