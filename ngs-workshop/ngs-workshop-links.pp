define workshop_links($source) {
  $parent_path = hiera('ngs_workshop::parent_path')
  $data_dir = hiera('ngs_workshop::data_dir')
  $working_dir = hiera('ngs_workshop::working_dir')
  $trainee_user = hiera('ngs_workshop::trainee_user')
  $trainee_uid = hiera('ngs_workshop::trainee_uid')
  
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

class ngs_workshop::links {
  $data_links = hiera('ngs_workshop::data_links', {})

  create_resources(workshop_links, $data_links)
}

node default {
  include ngs_workshop::links
}
