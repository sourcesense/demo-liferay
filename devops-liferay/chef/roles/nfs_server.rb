name 'nfs_server'
description 'Role applied to the system that should be an NFS server.'
override_attributes

run_list ['nfs::server']
