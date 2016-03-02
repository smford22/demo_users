# demo_users coobkook
This cookbook is used to demo chef_vault by creating users from `data_bags`.

## Data Bags
The following data_bags must exist on the Chef Server:

- users - A data bag for holding user data bag items (unencrypted)
- secrets - A data bag for holding passwords and ssh keys for a user (encrypted)

Once the data bags have been created on the Chef Server the data bag items must
be created. The following is an example of each data bag item:

## Data Bag items

#### user data bag example
```json
{
  "id": "bjoy",
  "action": "create",
  "comment": "Bill Joy",
  "home": "/home/bjoy",
  "uid": "3000",
  "gid": "0",
  "shell": "/bin/bash",
  "groups": ["wheel"]
}
```

#### secrets data bag example
```json

  "id": "bjoy",
  "password": "PASSWORD HASH GOES HERE",
  "ssh-key": "PRIVATE KEY GOES HERE\n"
}
```


## 
