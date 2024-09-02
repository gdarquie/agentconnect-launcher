## Install

Copy this file to your machine after installing AgentConnect with fc repository. Nothing more is supposed to be done.

## Alias

In .bashrc, .zshrc or in your shell configuration file, add the following lines replacing "path/of/the/folder" by the path of agentconnect-launcher:

```
alias agentconnect=/path/of/the/folder/agentconnect-launcher/agentconnect-launcher.sh
alias ac=/path/of/the/folder/agentconnect-launcher/agentconnect-launcher.sh
```

Don't forget to source the file or to restart the shell.

## "Permission denied" error

If you have a "permission denied" error, try to add execute permission to the launcher file.

```
sudo chmod ugo+x agentconnect-launcher.sh
```
