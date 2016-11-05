default['myloadbalancer']['liferay_backends'] = [
  'server liferaynode01 192.168.50.5:8080 weight 1 maxconn 100 check',
  'server liferaynode02 192.168.50.6:8080 weight 1 maxconn 100 check'
]
