# Docker version of a Handle Server

This is a docker version of the handle server software at http://www.handle.net/
All information for how to use a handle server should be via the handle.net
server documentation and support systems.

This is a docker image with an embedded configuration script that is run on docker
start to load default settings from environment variables.

# Configuration
Configuration follows the same rules as the main handle configuration however with environments, see official documentation for more detailed configuration details.

| Config                        | Default       | Required  | Description
| ------                        | -------       | --------  | -----------
| HANDLE_HOST_IP                | 0.0.0.0       | No        | Public handle host ip used for siteinfo
| SERVER_ADMIN_FULL_ACCESS      | yes           | No        | Admins listed in SERVER_ADMINS will have full permissions over all handles on the server
| SERVER_ADMINS                 | None          | No        | A list of handle admins comma seperated e.g. ADMIN1,ADMIN2,ADMIN3
| REPLICATION_ADMINS            | None          | No        | A list of handle admins for replication comma seperated e.g. "ADMIN1,ADMIN2,ADMIN3"
| CASE_SENSITIVE                | no            | No        | Are handles case sensitive
| MAX_SESSION_TIME              | 86400000      | No        | Max authenticated client session time in ms.
| MAX_AUTH_TIME                 | 60000         | No        | Max time to wait for for client to respond to auth challenge.
| THIS_SERVER_ID                | 1             | No        | An identifier for this handle server.
| TRACE_RESOLUTION              | no            | No        | Set to yes for debugging information to be logged for handle resolution.
| ALLOW_LIST_HDLS               | no            | No        | Used to disable list_handles functionality.
| ALLOW_RECURSION               | no            | No        | Allow recursive lookup outside of this handle server into global handle network.
| SERVER_PRIVATE_KEY_PEM        | None          | Yes       | PEM PKCS8 format private key for encryption on the server.
| SERVER_PUBLIC_KEY_PEM         | None          | Yes       | PEM PKCS8 format public key for encryption on the server.

## Creating a PEM keypair

The PRIVATE_KEY and PUBLIC_KEY need to be in pksc8 format, below is an example that makes ready for usage in the environment variables

Generate keypair

    ssh-keygen -f mykey.pem

Get it in a format for PKCS8 and put in explicit new lines ready for env var

    openssl pkcs8 -topk8 -in mykey.pem -nocrypt | sed ':a;N;$!ba;s/\n/\\r\\n/g'
    openssl pkcs8 -topk8 -in mykey.pem -nocrypt | openssl pkey -pubout | sed ':a;N;$!ba;s/\n/\\r\\n/g'