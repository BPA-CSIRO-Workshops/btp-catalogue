define workshop_links($source) {
  $parent_path = hiera('btp_workshop::parent_path')
  $data_dir = hiera('btp_workshop::data_dir')
  $working_dir = hiera('btp_workshop::working_dir')
  $trainee_user = hiera('btp_workshop::trainee_user')
  $trainee_uid = hiera('btp_workshop::trainee_uid')
  
  $data_path = "${parent_path}/${data_dir}"
  $working_path = "${parent_path}/${working_dir}"

  if $source == 'root' {
    $target_path = "${data_path}"
  }
  else {
    $target_path = "${data_path}/${source}"
  }

  file { "${working_path}/${name}":
    ensure => 'link',
    target => $target_path,
    owner  => $trainee_user,
    group  => $trainee_user,
  }
}

class btp_workshop::links {
  $data_links = hiera('btp_workshop::data_links', {})

  create_resources(workshop_links, $data_links)
}

node default {
  include btp_workshop::links
}
