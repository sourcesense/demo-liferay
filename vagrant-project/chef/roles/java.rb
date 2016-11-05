name 'java'
description 'Install Oracle Java on Ubuntu'
override_attributes(
  'java' => {
    'oracle' => {
      'accept_oracle_download_terms' => true
    },
    'jdk_version' => '7',
    'install_flavor' => 'oracle'
  }
)
run_list(
  'recipe[java]'
)
