# A Helm chart of a Kerberos v5 KDC stack

This chart deploys a single-master KDC and kadmind service in two
containers linked via a volume containing the Kerberos database.

### Database Persistence

If persistence is enabled via the `kdc.persistence.enabled` key, a PVC
is created via the cluster's default storage class and mounted into both
containers to provide access to the database.

In the event persistence is _not_ enabled, an emptyDir is created on the host.

### Services

The KDC service is exposed on <release name>-kdc.<namespace>.svc.cluster.local,
defaulting to port 88 on both TCP and UDP.

The kadmind service is exposed on <release name>-kadmin.<namespace>.svc.cluster.local,
defaulting to the v5 admin port 749.

### Admin Principal

To administer the database out of the gate, a post-install helm hook job is run to
inject a user/admin principal into the database with the name and password specified
via environment variables which can be set via a number of ways, the simplest being
at the command line with `--set admin_princ.password=<password>`. For security reasons,
this should likely be done via Secret created within the cluster or some other secrets
management tool, or on a CI system that has the ability to mask certain sensitive data
from being output to the console.