# Bootstrap

On first run, you need to bootstrap the cluster by running: `kubectl exec -it -n
vault pods/vault-0 -- vault operator init`.

This will output recovery keys. Retrieve them and add it to a secure backup
storage.

It will also output an initial root token. You need to keep this to manage
Vault.
